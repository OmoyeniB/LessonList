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
    func playDownloadedVideo(avPlayer: AVPlayer, playerViewController: AVPlayerViewController)
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

    func presentDownloadedVideo(path: String) {
        let documentsFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let videoURL = documentsFolder.appendingPathComponent("\(path).mp4")
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        delegate?.playDownloadedVideo(avPlayer: player, playerViewController: playerViewController)
    }
}

