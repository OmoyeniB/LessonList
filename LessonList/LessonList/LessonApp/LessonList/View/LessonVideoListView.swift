//
//  LessonVideoListView.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 10/01/2023.
//

import SwiftUI

struct LessonVideoListView: View {
    
    @State var showUIKitViewController: Bool = false
    @State private var currentCount: Int = 0
    @StateObject var viewModel = LessonListViewModel(networkResult: LessonNetworkService())
    var lessonList: [StoredLessonModel] = [StoredLessonModel]()
    var body: some View {
        
        if #available(iOS 14.0, *) {
//            ZStack {
                NavigationView {
                    VStack {
                        Color.blue
                            .ignoresSafeArea(.all)
                        ZStack {
                        List {
                            ForEach(Array(self.viewModel.storedLessonModel.enumerated()), id: \.offset) { (index, lessonVideoList) in
                               let _ = print(index, " do with `index` anything needed here")
                                NavigationLink(destination: DetailsViewRespresentableWrapper(movieList: (lesson: lessonVideoList, arrayOfLesson: viewModel.storedLessonModel, totalCount: viewModel.storedLessonModel.count, currentCount: index), lessonListViewModel: viewModel)
                                    .navigationBarHidden(true), isActive: $showUIKitViewController) {
                                            HStack {
                                                URLImage(imageUrlString: lessonVideoList.thubmnail ?? "")
                                                Text(lessonVideoList.name ?? "")
                                                    .lineLimit(3)
                                                    .minimumScaleFactor(0.5)
                                            }
                                        .onTapGesture {
                                            showUIKitViewController = true
                                        }
                                    }
                            }
                            .listRowBackground(Color.green.ignoresSafeArea())
                        }
                        .navigationTitle("Lessons")
                        .onAppear(perform: {
                            UITableView.appearance().backgroundColor = .clear
                            viewModel.onViewDidLoad()
                            viewModel.onDismiss = {
                                showUIKitViewController = false
                            }
                        })
                    }
                }
            }
        }
        
        else {
            // Fallback on earlier versions
        }
    }
}




struct LessonVideoListView_Previews: PreviewProvider {
    static var previews: some View {
        LessonVideoListView()
    }
}


