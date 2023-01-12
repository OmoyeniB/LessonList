////
//  VideoCache.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 06/01/2023.
//

import UIKit
import LinkPresentation

protocol VideoCacheProtocol {
    func didShowError(error: String)
}

class VideoCache {

   let videoDownloader = VideoDownloader()
    static let shared = VideoCache()
    private var delegate: VideoCacheProtocol?
    private let cachedMetadata = NSCache<NSURL, LPLinkMetadata>()
    final func metaData(url: NSURL) -> LPLinkMetadata? {
        return cachedMetadata.object(forKey: url)
    }
    
    final func load(url: NSURL, completion: @escaping ((LPLinkMetadata?) -> Void)) {
        if let cachedData = metaData(url: url) {
            completion(cachedData)
            return
        }
        let metaProvider = LPMetadataProvider()
        metaProvider.startFetchingMetadata(for: (url as URL)) {[weak self] metaData, error in
            completion(metaData)
            if let metaData {
                self?.cachedMetadata.setObject(metaData, forKey: url)
            } else {
               completion(nil)
                self?.delegate?.didShowError(error: error!.localizedDescription)
            }
        }
    }
}
