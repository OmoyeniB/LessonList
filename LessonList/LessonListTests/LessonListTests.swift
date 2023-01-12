//
//  LessonListTests.swift
//  LessonListTests
//
//  Created by Sharon Omoyeni Babatunde on 10/01/2023.
//

import XCTest
import Combine
@testable import LessonList

class LessonListTests: XCTestCase {
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: LessonListViewModelProtocol!
    private var mockNetworkService: MockLessonNetworkService!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockLessonNetworkService()
        viewModel = LessonListViewModel(networkResult: mockNetworkService)
    }
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables = Set<AnyCancellable>()
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchNetworkResult_Success() {
        // Given
        let expectedLessonsData = [Lesson(id: 1, name: "Lesson 1", description: "Description 1", thumbnail: "thumbnail_1", video_url: "video_1"),
                               Lesson(id: 2, name: "Lesson 2", description: "Description 2", thumbnail: "thumbnail_2", video_url: "video_2")]
        let expectedResult = LessonModel(lessons: expectedLessonsData)
        mockNetworkService.result = .success(expectedResult)
        
        // When
        let expectation = self.expectation(description: "Fetch lessons")
        viewModel.showLessonList = { _ in
            expectation.fulfill()
        }
        viewModel.fetchNetworkResult()
        wait(for: [expectation], timeout: 1.0)
        
        // Expected to pass if networkcall is successful and model contains data
        XCTAssertEqual(viewModel.lessonList, expectedLessonsData)
    }
    
    func testFetchNetworkResult_Failure() {
        // Given
        let expectedError = NSError(domain: "Test", code: 0, userInfo: nil)
        mockNetworkService.result = .failure(expectedError)
        
        // When
        let expectation = self.expectation(description: "Fetch lessons")
        viewModel.showError = { error in
            XCTAssertEqual(error as NSError, expectedError)
            expectation.fulfill()
        }
        viewModel.fetchNetworkResult()
        wait(for: [expectation], timeout: 1.0)
        
        // Expected to fail if networkcall is successful and model contains no data
        XCTAssertNil(viewModel.lessonList)
    }
    
}







