//
//  TwitterModel.swift
//  TWTRStars
//
//  Created by Nick McCrory on 2/27/17.
//  Copyright © 2017 binslashnick. All rights reserved.
//

import Foundation
import SwifteriOS

class TwitterModel {
    
    init() {}
    
    public func getTweetByScreenName(screenName: String){
        guard let url = URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=realDonaldTrump&count=1") else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        
        get(request: request, completion: {success, object in
            print("API Request Success: ", success)
            print(object)
        })
    }
    
    private func encodeConsumerKeyAndSecret() {
        
    }
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
            }.resume()
    }
    
    private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    private func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }
    
    private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
}
