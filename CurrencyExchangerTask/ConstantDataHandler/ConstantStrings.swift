//
//  ConstantStrings.swift
//  CurrencyExchangerTask
//
//  Created by mobile on 29/11/18.
//  Copyright © 2018 sasi. All rights reserved.
//

import Foundation
import UIKit

//MARK: - URL Constants -
struct APPURL {
    
    private struct Domains {
        static let dev = "http://www.apilayer.net"
    }
    
    private  struct Routes {
        static let api = "/api/live?"
    }
    
    private  struct AccessKey {
        static let accessKey = "access_key=6dc4cc4e25357a5daadf044f488cb0ae"
    }
    
    private  static let Domain = Domains.dev
    private  static let Route = Routes.api
    private  static let Access = AccessKey.accessKey
    private  static let BaseURL = Domain + Route + Access
    
    static var Currencylisturl: String {
        return BaseURL  + ""
    }
}
//MARK: - AppColor Constants -
struct AppColor {
    
    struct NavigationColor {
        static let navigationbac = UIColor(red: 100.0/255.0, green: 94.0/255.0, blue: 191.0/255.0, alpha: 1.0)

    }
    
  
}

