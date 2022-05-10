//
//  DownloadService.swift
//  Music
//
//  Created by Gilmar Junior on 09/05/22.
//

import Foundation

class DownloadService {
    
    var downloadSession: URLSession!
    var activeDownloads: [URL: Download] = [:]
    
    func startDownload(_ track: URL) {
        let download = Download(url: track)
        download.task = downloadSession.downloadTask(with: track)
        download.task!.resume()
        activeDownloads[download.url] = download
    }
}
