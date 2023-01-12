//
//  VideoDowloader.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 05/01/2023.
//

import UIKit

import UIKit

class VideoDownloader: NSObject {
    var model: StoredLessonModel?
    private var observation: NSKeyValueObservation?
    var downloadProgress: ((Double) -> Void)?
    var completion: ((Result<URL, Error>) -> Void)?
    var downloadtask: URLSessionDataTask?
    
    deinit {
        observation?.invalidate()
    }
    
    func download(url: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = docsUrl.appendingPathComponent("\(model?.name ?? "").mp4")
        
        guard let videoUrl = URL(string: url) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        if !(FileManager().fileExists(atPath: destinationUrl.path)) {
            DispatchQueue.global(qos: .background).async { [weak self] in
                let request = URLRequest(url: videoUrl)
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
                    if let error = error {
                        completion(.failure(NetworkingError.serverError(error.localizedDescription)))
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data {
                            do {
                                try data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                completion(.success(destinationUrl))
                            } catch {
                                completion(.failure(error))
                            }
                        }
                    }
                })
                self?.downloadtask = task
                self?.observation = task.progress.observe(\.fractionCompleted) { progress, _ in
                    self?.downloadProgress?(progress.fractionCompleted * 100)
                }
                task.resume()
            }
        }
    }
    
    func pauseDownload() {
        DispatchQueue.main.async { [weak self] in
            self?.downloadtask?.suspend()
        }
    }
    
    func cancelDownload() -> Bool {
        var willCancel = false
        if downloadtask != nil {
            DispatchQueue.main.async { [weak self] in
                self?.downloadtask?.cancel()
            }
            willCancel = true
            return willCancel
        } else {
            return willCancel
        }
    }
}
