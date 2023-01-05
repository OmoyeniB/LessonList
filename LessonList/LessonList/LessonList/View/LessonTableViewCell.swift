//
//  LessonTableViewCell.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class LessonTableViewCell: BaseTableViewCell {

    static let identifier = "LessonTableViewCell"
    
    lazy var userImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "square.and.arrow.up.trianglebadge.exclamationmark")
        img.cornerRadius = 7
        img.backgroundColor = .red
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let checkIcon: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "chevron.right"))
        img.contentMode = .center
        img.clipsToBounds = true
        return img
    }()
    
    
    let lessonLabel = Label(text: "5 Unique Ways To Release The iPhone's Shutter", font: .productSansBold(size: 15), textColor: .black)
    
    override func setup() {
        super.setup()
        addSubviews(userImg, lessonLabel, checkIcon)
        userImg.placeAtLeftCenterOf(centerY: centerYAnchor, leading: leadingAnchor, size: .init(width: 150, height: 80))
        lessonLabel.anchor(top: userImg.topAnchor, leading: userImg.trailingAnchor, trailing: checkIcon.leadingAnchor, margin: .init(allEdges: 10))
        checkIcon.placeAtRightCenterOf(centerY: centerYAnchor, trailing: trailingAnchor, size: .init(width: 23, height: 23))
    }


}
