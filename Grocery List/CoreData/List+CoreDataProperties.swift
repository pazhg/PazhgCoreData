//
//  List+CoreDataProperties.swift
//  Grocery List
//
//  Created by Pazhg on 4/11/1398 AP.
//  Copyright © 1398 Pazhg. All rights reserved.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var itemTitle: String?

}
