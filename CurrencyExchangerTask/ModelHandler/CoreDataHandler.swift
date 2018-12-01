//
//  CoreDataHandler.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 01/12/18.
//  Copyright © 2018 sasi. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext
    {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        return (delegate?.persistentContainer.viewContext)!
    }
    
    class func saveObeject (inrValue:Float,usdValue:Float,srdValue:Float) -> Bool
    {
        var isSaved = Bool()
        let context =  getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Currency", in: context)
        let manageObjet = NSManagedObject(entity: entity!, insertInto: context)
        manageObjet.setValue(inrValue, forKey: "inr")
        manageObjet.setValue(usdValue, forKey: "usd")
        manageObjet.setValue(srdValue, forKey: "srd")
        do {
            try context.save()
            isSaved = true
        } catch {
            isSaved = false
            print("unable to save data")
        }
        return isSaved
    }
    
    class func getCountryDetail(name:String) ->Array<Any>?
    {
        let contecxt = getContext()
        let fetchRequest:NSFetchRequest<Currency> = Currency.fetchRequest()
        var user:[Currency] = []
        let predicate = NSPredicate(format: "inr LIKE[cd] %@",name)
        fetchRequest.predicate = predicate
        do{
            user =  try contecxt.fetch(fetchRequest)
            let currencyObj = user
            print(currencyObj)
            return (currencyObj) as? Array<Any>
        }catch{
            return nil
        }
    }

    class func deleteObject(user:Currency) ->Bool{
        let context = getContext()
        context.delete(user)
        do
        {
            try context.save()
            return true
        }catch{
            return false
        }
    }

    //Clean delete
    class func cleanDelete () ->Bool
    {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Currency.fetchRequest())
        do{
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
}
