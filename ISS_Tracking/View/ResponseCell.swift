//
//  ResponseCell.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class ResponseCell: UITableViewCell {
    //MARK: - Properties
    var response : Response?{
          didSet{
              let risetime = response?.risetime
              guard let duration = response?.duration else {return}
              riseTimeLabel.text = "Rise time is " + (risetime?.description)!
              durationLabel.text = "Duration time is \(duration) seconds"
            
          }
      }
    
    @IBOutlet weak var riseTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
}
