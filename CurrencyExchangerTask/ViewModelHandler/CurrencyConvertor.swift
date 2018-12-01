//
//  CurrencyConvertor.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 30/11/18.
//  Copyright © 2018 sasi. All rights reserved.
//

import UIKit

class CurrencyConvertor: NSObject {

    var apiCall = WebserviceHandler()
    var listArry: [String : Any] = [:]
    var keyValue = String()
    var multipleStrAmt = String()

    func fetchResponse(strurl :String, completion: @escaping () -> Void) {
        
        apiCall.fetchGetApiRequestResponse(strurl: strurl) { (fetchData, error) in
            DispatchQueue.main.async {
                if (fetchData.count) > 0 {
                    print(fetchData)
                    self.listArry = fetchData["\(self.keyValue)"] as! [String : Any]
                    completion()
                }
            }
        }
    }
    func getCalculatedTottalAmount() -> String {
        var stramt = String()
        let amount : Double = self.listArry["val"] as! Double
        if amount != 0 && multipleStrAmt.count>0 {
            let singleAmt : Float = Float(amount)
            let totaleAmt : Float = Float(multipleStrAmt) ?? 0.0
            let total = totaleAmt * singleAmt
            stramt = String(total)
        }
        return stramt
    }
}
