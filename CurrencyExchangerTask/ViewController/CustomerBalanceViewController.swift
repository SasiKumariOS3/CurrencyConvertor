//
//  CustomerBalanceViewController.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 29/11/18.
//  Copyright © 2018 sasi. All rights reserved.
//

import UIKit
import CoreData

class CustomerBalanceViewController: UIViewController {
    
    @IBOutlet weak var lbl_blcINR: UILabel!
    @IBOutlet weak var lbl_blcSRD: UILabel!
    @IBOutlet weak var lbl_blcUSD: UILabel!
    
    var getConvertValues = NSManagedObject()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbl_blcINR.text = String(format: "INR : %@", getConvertValues.value(forKey: "inr") as! CVarArg)
        lbl_blcSRD.text = String(format: "SRD : %@", getConvertValues.value(forKey: "srd") as! CVarArg)
        lbl_blcUSD.text = String(format: "USD : %@", getConvertValues.value(forKey: "usd") as! CVarArg)

    }
    
    @IBAction func btnAction_clearentries(_ sender: UIButton) {
        print(deleteAllCoredataRecords())
    }
    
    func deleteAllCoredataRecords() -> Bool {
        
        var isdelete = Bool()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Currency")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
            isdelete = true
        } catch let error {
            print("Detele all data in  error :", error)
            isdelete = false
        }
        return isdelete
    }
    
}
