//
//  Location.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import Foundation

class Location  {
    var latitude : Double
    var longitude : Double
    
    init(latitude lat : Double, longitude long:Double) {
        self.latitude = lat
        self.longitude = long
    }
}
