//
//  ControllerSceneDIContainer .swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//

import UIKit

final class ControllerSceneDIContainer {
    
    static let sharedInstance = ControllerSceneDIContainer()
    var movieList: (lesson: StoredLessonModel, arrayOfLesson: [StoredLessonModel], totalCount: Int, currentCount: Int)?
    var lessonListViewModel: LessonListViewModel? = nil

    func makeLessonListSwiftUIInjectible() -> LessonVideoListView {
        let vc = LessonVideoListView()
        return vc
    }
    
    func makeDetailPageInjectable() -> UINavigationController {
        let vc = LessonDetailsController()
        let navigationController = UINavigationController(rootViewController: vc)
        vc.lessonList = movieList
        vc.lessonListViewModel = lessonListViewModel
        return navigationController
    }


}
