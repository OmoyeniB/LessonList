//
//  ControllerSceneDIContainer .swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

final class ControllerSceneDIContainer {
    
    static let sharedInstance = ControllerSceneDIContainer()
    
    func makeLessonListControllerInjectible() -> LessonListController {
        let vc = LessonListController()
        return vc
    }
    
    func makeDetailsControllerInjectible(navigationController: UINavigationController) {
        let vc = LessonDetailsController()
        navigationController.pushViewController(vc, animated: true)
    }
}
