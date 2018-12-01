//
//  WebserviceHandler.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 29/11/18.
//  Copyright © 2018 sasi. All rights reserved.
//

import UIKit

class WebserviceHandler: NSObject {

    typealias CompletionHandler = ( _ responseData: [String:Any], _ error: Error?) -> Void
    
    func fetchGetApiRequestResponse(strurl : String, completion: @escaping CompletionHandler) {
        
        var request = URLRequest(url: URL(string: strurl)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!) as! [String : Any]
                print(jsonResponse)
                completion(jsonResponse,"" as? Error)
            } catch {
                print("error")
                completion([:],error)
            }
        }).resume()
    }
    
}
