//
//  UIEdgeInset+Extensions.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

extension UIEdgeInsets {
    
    init(allEdges: CGFloat) {
        self.init(top: allEdges, left: allEdges, bottom: allEdges, right: allEdges)
    }
    
    static func leftOnly(_ leftInsect: CGFloat) -> Self {
        .init(top: 0, left: leftInsect, bottom: 0, right: 0)
    }
    
    static func rightOnly(_ rightInsect: CGFloat) -> Self {
        .init(top: 0, left: 0, bottom: 0, right: rightInsect)
    }
    
    static func topOnly(_ toInsect: CGFloat) -> Self {
        .init(top: 0, left: 0, bottom: 0, right: toInsect)
    }
}

extension Double {
    /// Rounds the Float to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
