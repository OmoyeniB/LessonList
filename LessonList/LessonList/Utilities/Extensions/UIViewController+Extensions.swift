//
//  UIViewController+Extensions.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

extension UIViewController {
 
    func displayAlert(title: String, message: String, type: LogType, action: ParameterHandler?) {
        var title = title
        switch type {
        case .success:
            title = "🟢🟢🟢   " + title + "   🟢🟢🟢"
        case .error:
            title = "🛑🛑🛑   " + title + "   🛑🛑🛑"
        case .info:
            title = "🟡🟡🟡   " + title + "   🟡🟡🟡"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in action?() }))
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alert, animated: true)
        }
    }
    
    func addNavBarButton(button: UIButton, width: CGFloat) -> UIBarButtonItem {
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: width).isActive = true
        return menuBarItem
    }
    
    func setUpNavigationTitle(text: String) -> UILabel {
        let label = Label(text: text, font: .productSansBold(size: 35), textColor: .white, alignment: .center)
        return label
    }
    
}
