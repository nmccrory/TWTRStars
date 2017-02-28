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
    private var swifter: Swifter?
    private var bearer: String?
    
    init() {
        // Initiate Swifter with Consumer Key and Consumer Secret for TWTRStars App
        self.swifter = Swifter(consumerKey: "2XT17lSatBgtPN5lME7251Ks6", consumerSecret: "i6uxrPz0DPBtiho5TTWrTWC6i6ykKy52SZ4VBss4jdK0hMciEB", appOnly: true)
        // Exchange Consumer Credentials for Bearer token
        self.swifter!.postOAuth2BearerToken(success:  {token, response in
            self.bearer = token["access_token"].string
            print(self.bearer)
            self.getTweetByScreenName(screenName: "nickmccrory")
        }, failure: {error in
            print(error)
        })
    }
    
    public func getTweetByScreenName(screenName: String){
        let str = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + screenName + "&count=1"
        guard let url = URL(string: str) else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        
        let token = "Bearer " + bearer!
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        get(request: request, completion: {success, object in
            print("API Request Success: ", success)
            print(object)
            
            let data = object as! [Dictionary<String, Any>]
            let user = data[0]["user"] as! Dictionary<String, Any>
            print("User: ", user["name"])
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
