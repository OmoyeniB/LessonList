//
//  Label.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//


import UIKit

class Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .productSansRegular(size: 13)
    }
   
    init(text: String, font: UIFont, numberOfLines: Int = 0, textColor: UIColor = .black, alignment: NSTextAlignment = .left, letterSpacing: CGFloat = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping) {
        super.init(frame: .zero)
        self.font = font
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.lineBreakMode = lineBreakMode
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
