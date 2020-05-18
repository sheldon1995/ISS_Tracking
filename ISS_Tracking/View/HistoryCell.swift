//
//  HistoryCell.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    
    //MARK: - Properties
    var locationRealm : LocationRealm?{
        didSet{
            guard let lat = locationRealm?.latitude else {return}
            guard let long = locationRealm?.longitude else {return}
            
            latitudeLabel.text = "Latitude is \(lat)"
            longtitudeLabel.text = "Longitidue is \(long) "
            
        }
    }
    
    
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
