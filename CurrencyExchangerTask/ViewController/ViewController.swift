//
//  ViewController.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 29/11/18.
//  Copyright © 2018 sasi. All rights reserved.
//


// http://www.apilayer.net/api/live?access_key=6dc4cc4e25357a5daadf044f488cb0ae
import UIKit
import CoreData

extension UIViewController {
    
    func showAlert (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            completion(true)
        }))
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var txtfld_INR: UITextField!
    @IBOutlet weak var txtfld_USD: UITextField!
    @IBOutlet weak var txtfld_SRD: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "CurrencyExchanger"
    }

    @IBAction func btnAction_CurrencyExchange(_ sender: UIButton) {
        guard let textinr = txtfld_INR.text, !textinr.isEmpty else {
            
            showAlert(title: "Error", message: "Add your INR amount") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        guard let textusd = txtfld_USD.text, !textusd.isEmpty else {
            showAlert(title: "Error", message: "Add your USD amount") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        guard let textsrd = txtfld_SRD.text, !textsrd.isEmpty else {
            showAlert(title: "Error", message: "Add your SRD amount") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        
        print(CoreDataHandler.saveObeject(inrValue: Float(textinr) ?? 0.0, usdValue: Float(textusd) ?? 0.0, srdValue: Float(textsrd) ?? 0.0))
        
        if saveVlauesinCoreData(strinr: textinr, strusd: textusd, strsrd: textsrd) {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerDetailsViewController") as? CustomerDetailsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func saveVlauesinCoreData(strinr :  String, strusd : String, strsrd : String) -> Bool {
        
        var issaved = Bool()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Currency", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(Float(strinr), forKey: "inr")
        newUser.setValue(Float(strsrd), forKey: "srd")
        newUser.setValue(Float(strusd), forKey: "usd")
        
        do {
            issaved = true
            try context.save()
            
        } catch {
            issaved = false
            print("Failed saving")
        }
        return issaved
    }
}

