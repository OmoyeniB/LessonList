//
//  UIViewController+Extensions.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

extension UIViewController {
 
    func addNavBarButton(button: UIButton) -> UIBarButtonItem {
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 150).isActive = true
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return menuBarItem
    }
    
    func setUpNavigationTitle(text: String) -> UILabel {
        let label = Label(text: text, font: .productSansBold(size: 35), textColor: .black, alignment: .center)
        return label
    }
    
}
