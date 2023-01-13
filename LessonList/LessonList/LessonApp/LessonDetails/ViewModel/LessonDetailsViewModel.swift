//
//  LessonDetailsViewModel.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 08/01/2023.
//

import Foundation
import LinkPresentation
import AVKit

protocol LessonDetailProtocol: AnyObject {
    func streamVideo(url: String)
}

final class LessonDetailsViewModel {
    
    weak var delegate: LessonDetailProtocol?
    let videoDownloader = VideoDownloader()
    var updateUI: (() -> Void)?
   
    var alreadyDownloadedID = [Int]() {
        didSet {
            saveDownloadedID()
        }
    }
    var downloadState = false {
        didSet {
            saveDownloadedState()
        }
    }
    
    func saveDownloadedState() {
        UserDefaults.standard.set(downloadState, forKey: "downloadedState")
    }
    
    func saveDownloadedID() {
       
        if #available(iOS 12.0, *) {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: alreadyDownloadedID, requiringSecureCoding: true)
                UserDefaults.standard.set(data, forKey: "alreadyDownloadedID")
            } catch {
              
            }
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: alreadyDownloadedID)
            UserDefaults.standard.set(data, forKey: "alreadyDownloadedID")
        }
    }
    
    func getDataFromUserDefault() {
        if let data = UserDefaults.standard.object(forKey: "alreadyDownloadedID") as? Data {
            let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Int]
            alreadyDownloadedID = array ?? [Int]()
        }
    }
    
    func isDownloaded(id: Int) -> String {
        getDataFromUserDefault()
        if alreadyDownloadedID.contains(id) {
            return "Downloaded"
        } else {
            return "Download"
        }
    }
    
    func playVideo_Downloaded_Video(urlString: String) {
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = docsUrl.appendingPathComponent("\(urlString).mp4")
        
        if (FileManager().fileExists(atPath: destinationUrl.path)) {
            let baseUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let assetUrl = baseUrl.appendingPathComponent("\(urlString).mp4")
            let url = assetUrl
            let avAssest = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: avAssest)
            let player = AVPlayer(playerItem: playerItem)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
        }
    }
}

