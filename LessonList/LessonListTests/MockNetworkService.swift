//
//  MockNetworkService.swift
//  LessonListTests
//
//  Created by Sharon Omoyeni Babatunde on 10/01/2023.
//

import XCTest
import Combine
@testable import LessonList
// MARK: - MockLessonNetworkService

class MockLessonNetworkService: LessonNetworkServiceProtocol {
    var result: Result<LessonModel, Error>?
    var networkResult: LessonNetworkServiceProtocol!
    var completion: ((AnyPublisher<LessonModel, Error>)-> Void)?
    
    
    func makeAPICall<T: Codable>(to url: URL, expecting: T.Type) -> AnyPublisher<T, Error> {
        switch result as! Result<T, Error> {
        case let .success(model):
            return Result.Publisher(model).eraseToAnyPublisher()
        case let .failure(error):
            return Result.Publisher(error).eraseToAnyPublisher()
        }
    }
}

