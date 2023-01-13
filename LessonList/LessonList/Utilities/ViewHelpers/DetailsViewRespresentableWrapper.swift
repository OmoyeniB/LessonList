//
//  DetailsViewRespresentablerapper.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 11/01/2023.
//

import SwiftUI

struct DetailsViewRespresentableWrapper: UIViewControllerRepresentable {
    
    var configure: (UINavigationController) -> Void = { _ in }
    var movieList: (lesson: StoredLessonModel, arrayOfLesson: [StoredLessonModel], totalCount: Int, currentCount: Int)?
    var lessonListViewModel: LessonListViewModel? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DetailsViewRespresentableWrapper>) -> UIViewController {
        
        ControllerSceneDIContainer.sharedInstance.movieList = movieList
//        ControllerSceneDIContainer.sharedInstance.lessonListViewModel = lessonListViewModel
        return ControllerSceneDIContainer.sharedInstance.makeDetailPageInjectable()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<DetailsViewRespresentableWrapper>) {
        if let newController = uiViewController.navigationController {
                    self.configure(newController)
                }
    }
}
