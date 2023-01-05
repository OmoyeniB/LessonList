//
//  BaseTableViewCell.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell,
                              UITextFieldDelegate {
    

    func setup() {
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showToastWithTItle(_ title: String?, type: ToastType, duration: TimeInterval = 1.0) {
        Toast.shared.showToastWithTItle(title ?? "Unable to complete this process, please try again", type: type, duration: duration)
    }
    
}
