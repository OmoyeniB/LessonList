//
//  LessonDetailsView.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class LessonDetailsView: BaseView {
    
    
    lazy var lessonView: UIView = {
        let lessonView = UIView()
        lessonView.backgroundColor = .red
        lessonView.contentMode = .scaleAspectFill
        lessonView.clipsToBounds = true
        return lessonView
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var downloadButton: UIButton = {
        var downloadButton = UIButton(frame: CGRect(x: -13, y: 0.0, width: 100, height: 30))
        downloadButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.tintColor = .systemBlue
        downloadButton.setTitleColor(.systemBlue, for: .normal)
        downloadButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        downloadButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return downloadButton
    }()
    
    let lessonLabel = Label(text: "The Key To Success In iPhone Photography", font: .productSansBold(size: 25), textColor: .black, alignment: .center)
    
    let lessonOverview = Label(text: "If your iPhone has more than one lens, how do you choose which lens to use? And which lens is best for different photography genres? It turns out that you'll get dramatically different results depending on which lens you use. Watch this video from our breakthrough iPhone Photo Academy course and discover how to choose the correct iPhone camera lens.", font: .productSansRegular(size: 17), textColor: .black, alignment: .center)
    
    let nextLessonButton: Button = {
        let nextLessonButton = Button(btnTitle: "Next Lesson", btnTextColor: .systemBlue, btnBackgroundColor: .clear, buttonImage: "chevron.right", edgeInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20), position: .forceRightToLeft)
        return nextLessonButton
    }()
    
    let previousLessonButton: Button = {
        let previousLessonButton = Button(btnTitle: "Prev Lesson", btnTextColor: .systemBlue, btnBackgroundColor: .clear, buttonImage: "chevron.left", edgeInset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0), position: .forceLeftToRight)
        return previousLessonButton
    }()
    
    
    override func setup() {
        super.setup()
        addSubviews(lessonView, stackView)
        stackView.addSubviews(lessonLabel, lessonOverview, nextLessonButton, previousLessonButton)
        lessonView.anchor(top: safeAreaLayoutGuide.topAnchor ,leading: leadingAnchor, trailing: trailingAnchor, size: CGSize(height: 250))
        stackView.anchor(top: lessonView.bottomAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, margin: UIEdgeInsets(allEdges: 20))

        lessonLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor, margin: .init(top: 20, left: 10, bottom: 10, right: 10))
        
        lessonOverview.anchor(top: lessonLabel.bottomAnchor, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor, margin: .init(top: 20, left: 10, bottom: 10, right: 15))
        
        nextLessonButton.anchor(top: lessonOverview.bottomAnchor, trailing: stackView.trailingAnchor, margin: .init(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 140, height: 40))
        
        previousLessonButton.anchor(top: lessonOverview.bottomAnchor, leading: stackView.leadingAnchor, margin: .init(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 140, height: 40))
    }
}
