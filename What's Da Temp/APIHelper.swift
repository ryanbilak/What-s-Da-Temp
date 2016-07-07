//
//  APIHelper.swift
//  What's Da Temp
//
//  Created by Ryan Bilak on 5/18/16.
//  Copyright © 2016 beachambilak. All rights reserved.
//

import Foundation

class APIHelper {
    
    func getTemp(tempAquired:(temp:String, success:Bool) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let weatherURL = NSURL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")!
        
        session.dataTaskWithURL(weatherURL) { (data, response, error) in
            
            if error == nil && data != nil {
                
                do {
                    
                    let weatherDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [String:AnyObject]
                    
                    if let query = weatherDictionary["query"] as? [String:AnyObject]{
                        
                        if let results = query["results"] as? [String:AnyObject]{
                            
                            if let channel = results["channel"] as? [String:AnyObject]{
                                
                                if let item = channel["item"] as? [String:AnyObject]{
                                    if let condition = item["condition"] as? [String:AnyObject]{
                                        if let temp = condition["temp"] as? String{
                                            tempAquired(temp: temp, success: true)
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                } catch {
                    
                    tempAquired(temp: "", success: false)
                    
                }
                
                
            } else {
                
                tempAquired(temp: "", success: false)
            }
            
            }.resume()
    }
}