//
//  LessonViewVideoList.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 11/01/2023.
//

import Foundation


import SwiftUI

class LessonViewVideoList: UIViewController {
    var swiftUIView: some View {
        LessonVideoListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.frame = view.frame
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}

