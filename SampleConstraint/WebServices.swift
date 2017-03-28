//
//  GlobalVariable.swift
//  SampleConstraint
//
//  Created by Saraschandra on 10/03/17.
//  Copyright © 2017 Mobiwareinc. All rights reserved.
//

import UIKit

class WebServices: NSObject
{
    class var sharedManager: WebServices
    {
        struct Singleton
        {
            static let instance = WebServices()
        }
        return Singleton.instance
    }
    
    func requestData()
    {
        let urlString = "\(commonURL)"
        let url : URL = URL(string: urlString)!;
        let accessToken = "FZBHMEoKFA1xNS6EkJ"
        
        //let accessToken : String? = "FZBHMEoKFA1xNS6EkJ"
        //let params :[String: String] = ["Access_Token":accessToken!];
        
        var request = URLRequest(url: url);
        request.httpMethod = "GET";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( accessToken, forHTTPHeaderField: "Access_Token")
        
        //request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: []);
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData;
        
        let session = URLSession.shared;
        let task = session.dataTask(with: request, completionHandler: {
                
                     (data, response, error) in
                
        guard let _:Data = data, let _:URLResponse = response , error == nil else
        {
            print("Service Error")
            return;
        }
                
        // Parse Response Data
        do
        {
            let resultDictionary : NSDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary;
                    
            // Success Response Data
            print("Response: \(resultDictionary)");
            
            let insideDictionary = resultDictionary.object(forKey: "GetItemSizesByProductIDResult") as! NSDictionary
            let success = insideDictionary.object(forKey: "Success") as! Bool
            
            if success == true
            {
                let resultsArray = insideDictionary.object(forKey: "Results") as! NSArray
                NotificationCenter.default.post(name: Notification.Name(rawValue: "JSONDATA"), object: resultsArray)
                
            }
        }
        catch let error as NSError
        {
            // Failure Response Data
            print("Failed to load: \(error.localizedDescription)");
        }
            
        })
        
        task.resume();
        
    }
    
}

