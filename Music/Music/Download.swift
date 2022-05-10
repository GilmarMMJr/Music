//
//  Download.swift
//  Music
//
//  Created by Gilmar Junior on 09/05/22.
//

import Foundation

class Download {
    var url: URL
    var task: URLSessionDownloadTask?
    
    init(url: URL) {
        self.url = url
    }
}
