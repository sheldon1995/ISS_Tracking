//
//  APIService.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIService{
    
    static let shared = APIService()
    
    func fetchISSPassTimes(withLatitude latitude:Double, withLongitude longitude:Double, completion:@escaping(ISS)->Void){
        
        let parameters : [String:String] = [
            "lat" : "\(latitude)",
            "lon" : "\(longitude)",
        ]
        
        Alamofire.request(ISS_PASS_TIMES,method: .get, parameters: parameters).responseJSON { (response) in
            // DataResponse is not JSON Format, need to convert it
            if response.result.isSuccess {
                var responses = [Response]()
                
                let json: JSON = JSON(response.result.value!)
                let ISSLaitude = json["request"]["latitude"].doubleValue
                let ISSLongitude = json["request"]["longitude"].doubleValue
                let passes = json["request"]["passes"].intValue
                let datetime = json["request"]["datetime"].doubleValue
                
                if json["response"].count>0{
                    for i in 0...json["response"].count - 1{
                        let duration = json["response"][i]["duration"].intValue
                        let risetime = json["response"][i]["risetime"].doubleValue
                        let response = Response(risetime: risetime, duration: duration)
                        responses.append(response)
                    }
                }
                
                let iss = ISS(latitude: ISSLaitude, longitude: ISSLongitude, passes: passes, datetime: datetime, responses: responses)
                completion(iss)
                
            }
        }
    }
    
    func fetchISSCurrentLocation(completion:@escaping(ISS)->Void){
    
        Alamofire.request(ISS_CURRENT_LOCATION,method: .get, parameters: [:]).responseJSON { (response) in
            // DataResponse is not JSON Format, need to convert it
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                
                let laitude = json["iss_position"]["latitude"].doubleValue
                let longitude = json["iss_position"]["longitude"].doubleValue
                let datetime = json["timestamp"].doubleValue
                
                let iss = ISS(latitude: laitude, longitude: longitude, passes: nil, datetime: datetime, responses: nil)
                completion(iss)
            }
        }
    }
    
}
