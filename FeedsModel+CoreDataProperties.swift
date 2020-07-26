//
//  FeedsModel+CoreDataProperties.swift
//  FeedsApp
//
//  Created by Vishal on 09/07/20.
//  Copyright © 2020 Vishal. All rights reserved.
//
//

import Foundation
import CoreData


extension FeedsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedsModel> {
        return NSFetchRequest<FeedsModel>(entityName: "FeedsModel")
    }

    @NSManaged public var articleUrl: String?
    @NSManaged public var avatar: String?
    @NSManaged public var comments: String?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var designation: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var lastName: String?
    @NSManaged public var likes: String?
    @NSManaged public var name: String?

}
