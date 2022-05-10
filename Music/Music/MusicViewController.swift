//
//  ViewController.swift
//  Music
//
//  Created by Gilmar Junior on 08/05/22.
//

import UIKit
import AVKit
import AVFoundation

class MusicViewController: UIViewController {
    
    let downloadService = DownloadService()
    
    lazy var downloadsSession: URLSession = {
        let configurationSession = URLSessionConfiguration.background(withIdentifier: "me.gilmame.bkgsessionconfiguration")
        return URLSession(configuration: configurationSession, delegate: self, delegateQueue: nil)
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Baixar Musicas"
        title.textAlignment = .center
        return title
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Baixar", for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(downloadTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tocar", for: .normal)
        button.layer.cornerRadius = 7
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(playDownload), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        downloadService.downloadSession = downloadsSession
    }
    
    @objc
    func downloadTapped(_ sender: UIButton){
        for url in urlDownloads {
            downloadService.startDownload(URL(string: url)!)
        }
    }
    
    @objc
    func playDownload(_ sender: UIButton){
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        let url = URL(string: String(describing: urlDownloads.first!))!
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    
}


extension MusicViewController: ViewCodeBuild {
    func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
        view.addSubview(playButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            downloadButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            downloadButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 50),
            downloadButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            playButton.leadingAnchor.constraint(equalTo: downloadButton.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: downloadButton.trailingAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 20)
        ])
    }
    
    func setupAdditionalConfiguration() { }
    
    
}

