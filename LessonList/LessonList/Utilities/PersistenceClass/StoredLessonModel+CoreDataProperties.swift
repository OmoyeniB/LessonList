//
//  StoredLessonModel+CoreDataProperties.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 10/01/2023.
//
//

import Foundation
import CoreData


extension StoredLessonModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredLessonModel> {
        return NSFetchRequest<StoredLessonModel>(entityName: "StoredLessonModel")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var thubmnail: String?
    @NSManaged public var videoUrl: String?

}

extension StoredLessonModel : Identifiable {

}
