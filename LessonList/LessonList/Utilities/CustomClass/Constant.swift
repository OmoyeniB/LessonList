//
//  Constant.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class Constant {
    
    static var statusBarFrameHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIWindow.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
        }
        else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    static func lightHaptic(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
