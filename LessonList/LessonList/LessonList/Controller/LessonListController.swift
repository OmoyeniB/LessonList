//
//  LessonListController.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

class LessonListController: BaseController<LessonListView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToDetailsPage()
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Lessons", style: .plain, target: nil, action: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: setUpNavigationTitle(text: "Lessons"))
        
    }
    
    
    func navigateToDetailsPage() {
        _view.didTapCell = { [weak self] in
            if let self {
                ControllerSceneDIContainer.sharedInstance.makeDetailsControllerInjectible(navigationController: self.navigationController!)
            }
            
        }
    }
}
