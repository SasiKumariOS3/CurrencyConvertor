//
//  CustomerDetailsViewController.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 29/11/18.
//  Copyright © 2018 sasi. All rights reserved.
//

import UIKit
import CoreData

class CustomerDetailsViewController: UIViewController {
    
    @IBOutlet weak var txtfld_name: UITextField!
    @IBOutlet weak var txtfld_covertcurrency: UITextField!
    @IBOutlet weak var txtfld_givencurrency: UITextField!
    @IBOutlet weak var txtfld_amount: UITextField!
    @IBOutlet weak var txtfld_email: UITextField!
    @IBOutlet var pickey_Currencytype: UIPickerView!
    
    var currencyType = ["INR", "USD","SRD"]
    var doneToolBar: UIToolbar?
    var isGiventype: Bool = false
    var isConverttype: Bool = false
    var selectStr: String = ""
    var getConvervalModel = CurrencyConvertor()


    override func viewDidLoad() {
        super.viewDidLoad()
        txtfld_givencurrency.inputAccessoryView = pickey_Currencytype
        txtfld_covertcurrency.inputAccessoryView = pickey_Currencytype
    }
    
    @objc func doneTimeButtonAction(_ sender: UIToolbar) {
        
        self.view.endEditing(true)
        
        if currencyType.count > pickey_Currencytype.selectedRow(inComponent: 0) {
            selectStr = currencyType[pickey_Currencytype.selectedRow(inComponent: 0)]
            if isGiventype {
                txtfld_givencurrency.text = selectStr
            }else if isConverttype {
                txtfld_covertcurrency.text = selectStr
            }
            print(selectStr)
        }
    }
    @IBAction func btnAction_Pay(_ sender: UIButton) {
        
        guard let textname = txtfld_name.text, !textname.isEmpty else {
            showAlert(title: "Error", message: "Enter your name") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        guard let textemail = txtfld_email.text, !textemail.isEmpty else {
            showAlert(title: "Error", message: "Enter your email") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        guard let textamt = txtfld_amount.text, !textamt.isEmpty else {
            showAlert(title: "Error", message: "Enter your  amount") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        guard let textgiventype = txtfld_givencurrency.text, !textgiventype.isEmpty else {
            showAlert(title: "Error", message: "Select your currencytype") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        guard let textconvertype = txtfld_covertcurrency.text, !textconvertype.isEmpty else {
            showAlert(title: "Error", message: "Select your needed currencytype") { (result) in
                if result {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        
        let getdata = fetchCoredataValues()
        
        if txtfld_givencurrency.text == "INR" {
            if getdata.0{
                let amt: Float = getdata.1.value(forKey: "inr") as! Float
                let givenamt : Float = Float(textamt) ?? 0.0
                if amt < givenamt {
                    showAlert(title: "Error", message: "You account does not have enough INR amount") { (result) in
                        if result {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
                
            }
        }else if txtfld_givencurrency.text == "USD" {
            if getdata.0{
                let amt: Float = getdata.1.value(forKey: "usd") as! Float
                let givenamt : Float = Float(textamt) ?? 0.0
                if amt < givenamt {
                    showAlert(title: "Error", message: "You account does not have enough USD amount") { (result) in
                        if result {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        } else if txtfld_givencurrency.text == "SRD" {
            if getdata.0{
                let amt: Float = getdata.1.value(forKey: "srd") as! Float
                let givenamt : Float = Float(textamt) ?? 0.0
                if amt < givenamt {
                    showAlert(title: "Error", message: "You account does not have enough SRD amount") { (result) in
                        if result {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        
        apiRequest(strgiventype: textgiventype, strconverttype: textconvertype, strAmt: textamt, fetchdata: getdata.1 )
        
    }
    
    func apiRequest(strgiventype : String, strconverttype : String, strAmt : String , fetchdata : NSManagedObject)  {
        
        getConvervalModel.keyValue = "\(strgiventype)_\(strconverttype)"
        getConvervalModel.multipleStrAmt = strAmt
        getConvervalModel.fetchResponse(strurl: "https://free.currencyconverterapi.com/api/v6/convert?q=\(strgiventype)_\(strconverttype)&compact=y") {
            
            var savedAmt = Float()
            var previuosamt = Float()

            if strgiventype == "INR" {
                savedAmt = fetchdata.value(forKey: "inr") as! Float
                let givenamt : Float = Float(strAmt) ?? 0.0
                let previuosMinusTotl : Float = savedAmt - givenamt
                fetchdata.setValue(previuosMinusTotl, forKey: "inr")
                
            }else if strgiventype == "USD" {
                savedAmt = fetchdata.value(forKey: "usd") as! Float
                let givenamt : Float = Float(strAmt) ?? 0.0
                let previuosMinusTotl : Float = savedAmt - givenamt
                fetchdata.setValue(previuosMinusTotl, forKey: "usd")
                
            }else if strgiventype == "SRD" {
                savedAmt = fetchdata.value(forKey: "srd") as! Float
                let givenamt : Float = Float(strAmt) ?? 0.0
                let previuosMinusTotl : Float = savedAmt - givenamt
                fetchdata.setValue(previuosMinusTotl, forKey: "srd")
                
            }
            
            if strconverttype == "INR" {
                previuosamt = fetchdata.value(forKey: "inr") as! Float
                let calculateamt : Float = Float(self.getConvervalModel.getCalculatedTottalAmount()) ?? 0.0
                let previuosPlusTotl : Float = calculateamt + previuosamt
                fetchdata.setValue(previuosPlusTotl, forKey: "inr")

            }else if strconverttype == "USD" {
                previuosamt = fetchdata.value(forKey: "usd") as! Float
                let calculateamt : Float = Float(self.getConvervalModel.getCalculatedTottalAmount()) ?? 0.0
                let previuosPlusTotl : Float = calculateamt + previuosamt
                fetchdata.setValue(previuosPlusTotl, forKey: "usd")

            }else if strconverttype == "SRD" {
                previuosamt = fetchdata.value(forKey: "srd") as! Float
                let calculateamt : Float = Float(self.getConvervalModel.getCalculatedTottalAmount()) ?? 0.0
                let previuosPlusTotl : Float = calculateamt + previuosamt
                fetchdata.setValue(previuosPlusTotl, forKey: "srd")

            }
            
            if previuosamt != 0.0 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerBalanceViewController") as? CustomerBalanceViewController
                vc?.getConvertValues = fetchdata
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        }
    }
    
    
    
    func fetchCoredataValues() -> (Bool , NSManagedObject)  {
        
        var isFetched = Bool()
        var managedObject = NSManagedObject()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Currency")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.count != 0{
                managedObject = result.last as! NSManagedObject
                let accessToken: Float = managedObject.value(forKey: "inr") as! Float
                print(accessToken)
            }
            print(result)
            isFetched = true
        } catch {
            isFetched = false
            print("Failed")
        }
        return (isFetched,managedObject)
    }

}

//MARK: - PickerView Delagate & DataSource -
extension CustomerDetailsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectStr = currencyType[row]
        if isGiventype {
            txtfld_givencurrency.text = selectStr
        }else if isConverttype {
            txtfld_covertcurrency.text = selectStr
        }
        txtfld_covertcurrency.resignFirstResponder()
        txtfld_givencurrency.resignFirstResponder()
    }
}
extension CustomerDetailsViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtfld_givencurrency {
            isGiventype = true
        }else{
            isGiventype = false
        }
        
        if textField == txtfld_covertcurrency {
            isConverttype = true
        }else{
            isConverttype = false
        }
        
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtfld_givencurrency {
            isGiventype = false
        }
        
        if textField == txtfld_covertcurrency {
            isConverttype = false
            
            let getdata = fetchCoredataValues()
            if getdata.0{
                let accessToken: Float = getdata.1.value(forKey: "inr") as! Float
                print(accessToken)
            }
            
        }
        
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
}
