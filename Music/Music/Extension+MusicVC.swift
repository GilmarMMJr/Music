//
//  Extension+MusicVC.swift
//  Music
//
//  Created by Gilmar Junior on 09/05/22.
//

import Foundation
import UIKit

extension MusicViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURl = downloadTask.originalRequest?.url else { return }
        
        downloadService.activeDownloads[sourceURl] = nil
        let destinationURL = localFilePath(for: sourceURl)
        
        let fileManger = FileManager.default
        try? fileManger.removeItem(at: destinationURL)
        do {
            try fileManger.copyItem(at: location, to: destinationURL)
        } catch let erro{
            print("No copy file to disk: \(erro.localizedDescription)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if let url = downloadTask.originalRequest?.url, let _ = downloadService.activeDownloads[url] {
            let progress = round(Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) * 100)
            
            print("carregando: \(progress) %")
        }
    }
}


extension MusicViewController: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        OperationQueue.main.addOperation {
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
               let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                completionHandler()
            }
        }
    }
    
}
