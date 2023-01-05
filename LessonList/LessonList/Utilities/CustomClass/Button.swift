//
//  Button.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(btnTitle: String, btnTextColor: UIColor, btnBackgroundColor: UIColor, buttonImage: String, edgeInset: UIEdgeInsets, position: UISemanticContentAttribute, textFont: UIFont? = .productSansBold(size: 16)) {
        self.init(frame: .zero)
        setTitle(btnTitle, for: .normal)
        setTitleColor(btnTextColor, for: .normal)
        backgroundColor = btnBackgroundColor
        setImage(UIImage(systemName: buttonImage), for: .normal)
        titleEdgeInsets = edgeInset
        semanticContentAttribute = position
        titleLabel?.font = textFont
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
