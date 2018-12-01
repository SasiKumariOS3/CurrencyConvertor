//
//  Currency+CoreDataProperties.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 01/12/18.
//  Copyright © 2018 sasi. All rights reserved.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var inr: Float
    @NSManaged public var srd: Float
    @NSManaged public var usd: Float

}
