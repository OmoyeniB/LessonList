//
//  MainBaseController.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class MainBaseController: UIViewController {
    
    private let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView.init(style: .large)
        activity.startAnimating()
        return activity
    }()
    
    private let loaderContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
    func runOnMainThread(action: @escaping () -> Void) {
        DispatchQueue.main.async {
            action()
        }
    }
    
    func showToastWithTItle(_ title: String?, type: ToastType, duration: TimeInterval = 1.0) {
        runOnMainThread {
            Toast.shared.showToastWithTItle(title ?? "Unable to complete this process, please try again", type: type, duration: duration)
        }
    }
    
    func showLoader() {
        guard let keyWindow = UIWindow.keyWindow else { return }
        keyWindow.addSubview(loaderContainer)
        loaderContainer.anchor(top: keyWindow.topAnchor, leading: keyWindow.leadingAnchor, bottom: keyWindow.bottomAnchor, trailing: keyWindow.trailingAnchor)
        keyWindow.bringSubviewToFront(loaderContainer)
        
        loaderContainer.addSubview(activity)
        activity.placeAtCenterOf(centerY: loaderContainer.centerYAnchor, centerX: loaderContainer.centerXAnchor)
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.loaderContainer.removeFromSuperview()
        }
    }
    
}
