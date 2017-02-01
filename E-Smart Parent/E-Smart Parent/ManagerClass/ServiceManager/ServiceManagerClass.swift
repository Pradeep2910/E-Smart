//
//  ServiceManagerClass.swift
//  SchoolApp
//
//  Created by Pradeep AC on 22/10/16.
//  Copyright © 2016 Pradeep A C. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

@objc protocol ServiceManagerDelegate {
    @objc optional func didReceiveAlamofireResponse(_response : NSDictionary)
    @objc optional func didReceiveError(_error : Error)
     @objc optional func notReachable()
}


class ServiceManagerClass: NSObject {
    
    var  serviceDelegate :ServiceManagerDelegate? = nil
    let reachability = Reachability()!
    override init() {
        super.init()
    }
    convenience init(_delegate:ServiceManagerDelegate) {
        self.init()
        self.serviceDelegate = _delegate
    }
    
    //MARK:- Alamofire Delegates
    func callServiceForAlamofireURL(url: URL) {
        //    let userName: String = NSUserDefaults.standardUserDefaults().objectForKey("userName") as! String
        //    let password: String = NSUserDefaults.standardUserDefaults().objectForKey("password") as! String
        //    let credential = NSURLCredential(user: userName, password: password, persistence: .ForSession)
        //    let headers = ["Accept": "application/json"]
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
//                if reachability.isReachableViaWiFi {
//                    print("Reachable via WiFi")
//                } else {
//                    print("Reachable via Cellular")
//                }
                Alamofire.request(url, method: HTTPMethod.get, parameters: [:], encoding: URLEncoding.default, headers: nil).responseJSON { response in
                    if response.result.isSuccess {
                        guard let jsonResponseValue = response.result.value as? [String: AnyObject] else {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.serviceDelegate?.didReceiveAlamofireResponse!(_response: jsonResponseValue as NSDictionary)
                        }
                    } else {
                        self.serviceDelegate?.didReceiveError!(_error: response.result.error!)
                    }
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
           DispatchQueue.main.async {
                self.serviceDelegate?.notReachable!()
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }


       
    }

    
    /// Triggers webservice request.
    ///
    /// - parameter url : URL to be hit
    /// - parameter requestType: HTTP method such as .GET,.POST
    /// - parameter headers: headers to be appended in the request
    /// - parameter params:            params that needs to append in http post body
    /// - parameter completionHandler: completion handler to call back delegate method process with response comes from server.
    ///
    /// - returns: none
    func initiateRequest(url: String!, requestType: Alamofire.HTTPMethod, headers: Dictionary <String, String>?,queryParams: [String : AnyObject]?, params : [String : AnyObject]? , completionHandler:@escaping (_ success:Bool, _ response:NSDictionary?,_ error: NSError?) -> ()) {
        
        var request = URLRequest(url: URL(string: url)!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: REQUEST_TIMEOUT_TIME)
        
        request.httpMethod = requestType.rawValue
        
        if let reqHeaders = headers {
            // Headers
            for (key, value) in reqHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Form Params
        if queryParams != nil
        {
            //            if request.value(forHTTPHeaderField: "Content-Type") == nil
            //            {
            //                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //            }
            //            request.httpBody = query(parameters: qParams).data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        
        
        if let jParams = params
        {
            do{
                let data = try! JSONSerialization.data(withJSONObject: jParams, options: .prettyPrinted)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = data
            }catch _
            {
                //handle error
            }
        }
              Alamofire.SessionManager.default.request(request as URLRequestConvertible).validate().responseJSON(completionHandler: {
            (response) in
            switch (response.result) {
            case .success:
                if  let responseDict = self.parseResponseData(responseData: response.data as NSData?){
                    completionHandler(true ,responseDict as NSDictionary?,nil)
                }else{
                    let error = NSError(domain: "Invalid error", code: 0, userInfo: ["description": "invalid response"])
                    completionHandler(false,nil,error)
                }
            case .failure:
                if  let responseDict = self.parseResponseData(responseData: response.data as NSData?){
                    completionHandler(true ,responseDict as NSDictionary?,nil)
                }else{
                    let error = NSError(domain: "Invalid error", code: 0, userInfo: ["description": "invalid response"])
                    completionHandler(false,nil,error)
                }
            }
            
        })
        

    }
    
    /// Converting json type response data to dictionary representation
    ///
    /// - parameter responseData: jsop formata response data
    ///
    /// - returns: parsed json dictionary value or nil if json is not correct.
    func parseResponseData(responseData : NSData?) -> [String : AnyObject]? {
        if let rdata = responseData {
            if let jsonDict = JSON(data: rdata as Data).dictionaryObject{
                return jsonDict as [String : AnyObject]?
            }
        }
        return nil
    }
    

    
}
