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
        if  hasSavedUrl(url: url) {
            let savedMetadata = self.getMetadataFromSavedUrl(url: url)
            completion(savedMetadata)
            return
        }
        if let cachedData = metaData(url: url) {
            completion(cachedData)
            return
        }
        let metaProvider = LPMetadataProvider()
        metaProvider.startFetchingMetadata(for: (url as URL)) { [weak self] metaData, error in
            completion(metaData)
            if let metaData = metaData{
                self?.cachedMetadata.setObject(metaData, forKey: url)
                let data = NSKeyedArchiver.archivedData(withRootObject: metaData)
                self?.saveMetaData(url: url, data: data)
            } else {
                completion(nil)
                self?.delegate?.didShowError(error: error!.localizedDescription)
            }
        }
    }
    
    func saveMetaData(url: NSURL, data: Data) {
        let filePath = getFilePath(url: url)
        FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
    }
    
    func hasSavedUrl(url: NSURL) -> Bool {
        let filePath = getFilePath(url: url)
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    func getMetadataFromSavedUrl(url: NSURL) -> LPLinkMetadata? {
        let filePath = getFilePath(url: url)
        if FileManager.default.fileExists(atPath: filePath) {
            let data = FileManager.default.contents(atPath: filePath)
            if let data {
                let metadata = NSKeyedUnarchiver.unarchiveObject(with: data) as? LPLinkMetadata
                return metadata
            }
        }
        return nil
    }
    
    func getFilePath(url: NSURL) -> String {
        let fileName = url.lastPathComponent ?? ""
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsUrl.appendingPathComponent(fileName).path
    }
}
