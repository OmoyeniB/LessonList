//
//  LessonVideoListView.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 10/01/2023.
//

import SwiftUI

struct LessonVideoListView: View {
    
    @State var displayAlert: Bool = false
    @StateObject var viewModel = LessonListViewModel(networkResult: LessonNetworkService())
    var blackColor = "BlackColor"
    @State var errorString: String? = nil
    
    var body: some View {
        if #available(iOS 14.0, *) {
            NavigationView {
                ZStack {
                    Color(blackColor)
                        .ignoresSafeArea(.all)
                    List(Array(viewModel.storedLessonModel.enumerated()), id: \.offset){ (index, lessonVideoList) in
                        
                        NavigationLink(destination:
                                        DetailsViewRespresentableWrapper(movieList: (lesson: lessonVideoList, arrayOfLesson: viewModel.storedLessonModel, totalCount: viewModel.storedLessonModel.count, currentCount: index),
                                                                         lessonListViewModel: viewModel)) {
                            HStack {
                                URLImage(imageUrlString: lessonVideoList.thubmnail ?? "")
                                    .cornerRadius(10)
                                Text(lessonVideoList.name ?? "")
                                    .lineLimit(3)
                                    .foregroundColor(Color.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.blue)
                                Spacer()
                            }
                            
                        }
                        .listRowBackground(Color(blackColor))
                        .foregroundColor(Color.clear)
                        .background(Color(blackColor))
      
                    }
                    .modifier(ListBackgroundModifier())
                    .listStyle(.insetGrouped)
                    .background(Color(blackColor))
                    .navigationBarItems(leading: Text("Lessons")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    )
                    .onAppear(perform: {
                        viewModel.onViewDidLoad()
                        viewModel.showError = { error in
                            errorString = error.localizedDescription
                            self.displayAlert = true
                        }
                    })
                }
                .alert(isPresented: $displayAlert) {
                    Alert(title: Text("Alert"), message: Text(errorString ?? ""), dismissButton: .default(Text("OK")))
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
}

struct LessonVideoListView_Previews: PreviewProvider {
    static var previews: some View {
        LessonVideoListView()
    }
}

