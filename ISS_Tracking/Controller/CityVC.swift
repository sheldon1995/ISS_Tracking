//
//  CityVC.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit

class CityVC: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var cityTF: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CityToResult"{
            guard let cityName = cityTF.text else {return}
            let resultVC = segue.destination as! ResultVC
            
            resultVC.cityName = cityName
            resultVC.shouldUseCurrentLocation = false
            
        }
    }
    
    //MARK: - Help Function
    @IBAction func goTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "CityToResult", sender: nil)
    }
}
