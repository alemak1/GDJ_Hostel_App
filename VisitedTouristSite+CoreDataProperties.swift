//
//  VisitedTouristSite+CoreDataProperties.swift
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/8/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreData


extension VisitedTouristSite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VisitedTouristSite> {
        return NSFetchRequest<VisitedTouristSite>(entityName: "VisitedTouristSite")
    }

    @NSManaged public var regionIdentifier: String?
    @NSManaged public var dateEntered: NSDate?
    @NSManaged public var dateExited: NSDate?

}
