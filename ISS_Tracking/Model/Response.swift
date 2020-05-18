//
//  Response.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import Foundation

class Response {
    var risetime : Date
    var duration : Int
    
    init(risetime : Double, duration : Int) {
        self.risetime = Date(timeIntervalSince1970: risetime)
        self.duration = duration
    }
}
