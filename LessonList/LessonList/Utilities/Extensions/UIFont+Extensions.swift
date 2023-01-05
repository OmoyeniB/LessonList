//
//  UIFont+Extensions.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

extension UIFont {

    static func productSansBoldItalic(size: CGFloat = 14) -> UIFont { UIFont(name: "ProductSans-BoldItalic", size: size) ?? UIFont.systemFont(ofSize: size) }
    
    static func productSansBold(size: CGFloat = 14) -> UIFont { UIFont(name: "ProductSans-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }

    static func productSansRegular(size: CGFloat = 14) -> UIFont { UIFont(name: "ProductSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size) }
}

