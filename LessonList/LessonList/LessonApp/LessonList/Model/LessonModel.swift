//
//  LessonModel.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 05/01/2023.
//

import Foundation

// MARK: - LessonModel
struct LessonModel: Codable, Equatable {
    let lessons: [Lesson]
}

// MARK: - Lesson
struct Lesson: Codable, Equatable {
    let id: Int?
    let name, description: String?
    let thumbnail: String?
    let video_url: String?
}
