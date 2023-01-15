//
//  LessonDetails+Extensions.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 10/01/2023.
//

import UIKit
import AVFoundation
import LinkPresentation
import AVKit

extension LessonDetailsController {
    
    func startDownload(url: String) {
        
        videoDownloader.download(url: url, completion: { [weak self] result in
            if let self {
                switch result {
                case .success(_):
                    self.viewModel.downloadState = true
                    self.updateUIAfterDownLoad()
                    self.viewModel.alreadyDownloadedID.append(Int(self.lessonList?.lesson.id ?? 0))
                    self.viewModel.getDataFromUserDefault()
                    if self.savedID.contains(Int(self.lessonList?.lesson.id ?? 0)) {
                        
                    } else {
                        self.downloadButton.setTitle(self.viewModel.isDownloaded(id: Int(self.lessonList?.lesson.id ?? 0)), for: .normal)
                        self.hideUnHideView(id: Int(self.lessonList?.lesson.id ?? 0))
                        self.cancelButton.isHidden = true
                    }
                case .failure(let error):
                    self.displayAlert(title: "Download Alert", message: error.localizedDescription, type: .error, action: nil)
                    self.viewModel.downloadState = false
                }
            }
        })
    }
    
    @objc func DidDownloadLessonVideo() {
        if !savedID.contains(Int(self.arrayOfLesson[self.currentCount].id)) {
            startDownload(url: self.lessonList?.lesson.videoUrl ?? "")
            self.videoDownloader.downloadProgress = { progress in
                let prog = String(progress.rounded(toPlaces: 2))
                DispatchQueue.main.async { [weak self] in
                    self?.cancelButton.isHidden = false
                    self?.downloadButton.setTitle(String(prog), for: .normal)
                }
            }
            
        }
    }
    
    @objc func clickPreviousLessonButton() {
        
        if currentCount != 0 {
            showLoading()
            self.nextLessonButton.isHidden = false
            DispatchQueue.main.async { [weak self] in
                if let self {
                    self.isPreviousLessonClicked = true
                    self.initializeView(with: self.arrayOfLesson[self.currentCount - 1])
                    self.updateCancelButton(int: Int(self.arrayOfLesson[self.currentCount - 1].id))
                    let title = self.viewModel.isDownloaded(id: Int(self.arrayOfLesson[self.currentCount - 1].id))
                    self.updateViewConfig()
                    if title == "Downloaded" {
                        self.lessonView.isHidden = false
                    }
                    self.downloadButton.setTitle(title, for: .normal)
                    self.currentCount -= 1
                    self.previousLessonButton.isHidden = false
                    if self.currentCount == 0 {
                        self.previousLessonButton.isHidden = true
                    }
                }
            }
        }
    }
    
    @objc func clickNextLessonButton() {
        if currentCount + 1 <= totalCount {
            showLoading()
            self.previousLessonButton.isHidden = false
            DispatchQueue.main.async { [weak self] in
                if let self {
                    self.isNextLessonClicked = true
                    self.initializeView(with: self.arrayOfLesson[self.currentCount + 1])
                    self.updateCancelButton(int: Int(self.arrayOfLesson[self.currentCount + 1].id))
                    let title = self.viewModel.isDownloaded(id: Int(self.arrayOfLesson[self.currentCount + 1].id))
                    if title == "Downloaded" {
                        self.lessonView.isHidden = false
                    }
                    self.updateViewConfig()
                    self.downloadButton.setTitle(title, for: .normal)
                    self.currentCount += 1
                    if self.currentCount + 1 == self.totalCount {
                        self.nextLessonButton.isHidden = true
                    }
                }
            }
        }
    }
    
    func updateViewConfig() {
        viewModel.getDataFromUserDefault()
        updateUIAfterDownLoad()
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        viewModel.presentDownloadedVideo(path: lessonList?.lesson.name ?? "")
    }
    
    
}

extension LessonDetailsController: LessonDetailProtocol {
    
    func playDownloadedVideo(avPlayer: AVPlayer, playerViewController: AVPlayerViewController) {
        
        playerViewController.player = avPlayer
        present(playerViewController, animated: true) {
            avPlayer.play()
        }
    }

}


