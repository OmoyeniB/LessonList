//
//  LessonListViewModel.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 05/01/2023.
//

import Foundation
import Combine
import CoreData
import Reachability

protocol LessonListViewModelProtocol {
    var lessonList: [Lesson] { get set }
    var storedLessonModel: [StoredLessonModel] { get set }
    var onDismiss: (() -> ())? { get set }
    var showError: ((Error) -> Void)? { get set }
    var showLessonList: ((Bool) -> Void)? { get set }
    func fetchNetworkResult()
    func onViewDidLoad()
}

class LessonListViewModel: LessonListViewModelProtocol, ObservableObject {
    
    var lessonList: [Lesson] = []
    var showLessonList: ((Bool) -> Void)?
    var onDismiss: (() -> ())?
    let reachability = try! Reachability()
    fileprivate var networkResult: LessonNetworkServiceProtocol
    private var subscribers = Set<AnyCancellable>()
    var showError: ((Error) -> Void)?
    
    @Published var storedLessonModel: [StoredLessonModel] = []
   
    init(networkResult: LessonNetworkServiceProtocol) {
        self.networkResult = networkResult
    }
    
    func onViewDidLoad() {
        initializeViewModel()
    }
    
    func fetchNetworkResult() {
        if let url = URL(string: "https://iphonephotographyschool.com/test-api/lessons") {
            networkResult.makeAPICall(to: url, expecting: LessonModel.self)
                .sink(receiveCompletion: { [unowned self] (completion) in
                    if case let .failure(error) = completion {
                        self.showError?(error)
                    }
                }, receiveValue: { data in
                    self.lessonList = data.lessons
                    self.showLessonList?(true)
                    if !(self.storedLessonModel.count > 0) {
                        self.saveToCoreData(lessonList: data.lessons)
                    } else {
                        self.fetchDataFromCoreData()
                    }
                    
                })
                .store(in: &subscribers)
        }
    }
    
    func saveToCoreData(lessonList: [Lesson]){
       
        storedLessonModel = []
        for datum in lessonList {
                let storedData = StoredLessonModel(context: PersistenceService.context)
                
                if let id = datum.id {
                    storedData.id = Int16(id)
                    storedData.name = datum.name
                    storedData.descriptions = datum.description
                    storedData.thubmnail = datum.thumbnail
                    storedData.videoUrl = datum.video_url
                    PersistenceService.saveContext()
                    DispatchQueue.main.async { [weak self] in
                        self?.storedLessonModel.append(storedData)
                    }
                }
        }
    }

    func fetchDataFromCoreData() {
        let fetchRequest: NSFetchRequest<StoredLessonModel> = StoredLessonModel.fetchRequest()
        let storedIds = self.storedLessonModel.map { Int($0.id) }
        fetchRequest.predicate = NSPredicate(format: "NOT (id in %@)", storedIds)
        fetchRequest.returnsDistinctResults = true
            do {
                let newStoredLessonModel = try PersistenceService.context.fetch(fetchRequest)
                if storedLessonModel != newStoredLessonModel {
                    self.storedLessonModel = newStoredLessonModel
                }
            } catch {
                print("Error fetching data from Core Data")
            }
    }
    
    func initializeViewModel() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi || reachability.connection == .cellular {
                self.fetchNetworkResult()
            }
        }
        reachability.whenUnreachable = { _ in
            self.fetchDataFromCoreData()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
}
