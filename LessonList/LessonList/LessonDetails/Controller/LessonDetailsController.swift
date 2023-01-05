//
//  LessonDetailsController.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//


import UIKit

class LessonDetailsController: BaseController<LessonDetailsView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setUpNavigationBar() {
        let downloadIcon = addNavBarButton(button: _view.downloadButton)
        self.navigationItem.rightBarButtonItem = downloadIcon
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
}
