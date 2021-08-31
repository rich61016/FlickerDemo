//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by YA on 2021/8/31.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "FavoriteData")
    }

    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?

}
