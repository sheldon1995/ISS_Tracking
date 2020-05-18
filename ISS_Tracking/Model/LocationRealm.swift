//
//  LocationRealm.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import Foundation
import RealmSwift


class LocationRealm : Object  {
    @objc dynamic var latitude : Double = 0.0
    @objc dynamic var longitude : Double = 0.0
}

