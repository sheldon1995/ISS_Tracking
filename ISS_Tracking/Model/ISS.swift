//
//  ISS.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import Foundation

class ISS {
    var latitude : Double
    var longitude : Double
    var passes : Int?
    var datetime : Date?
    var responses : [Response]?

    init(latitude : Double, longitude : Double, passes : Int?, datetime : Double?, responses : [Response]?) {
        self.longitude = longitude
        self.latitude = latitude
        self.passes = passes
        if let time = datetime{
            self.datetime = Date(timeIntervalSince1970: time)
        }
        
        self.responses = responses
    }
}

