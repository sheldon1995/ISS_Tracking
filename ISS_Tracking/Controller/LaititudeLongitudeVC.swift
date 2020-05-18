//
//  LaititudeLongitudeVC.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import UIKit
import RealmSwift

class LaititudeLongitudeVC: UIViewController {
    
    @IBOutlet weak var latitudeTF: UITextField!
    
    @IBOutlet weak var longitideTF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let historyCellID = "historyCell"
    
    var latAndLongResults : Results<LocationRealm>!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readDataFromRealm()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: historyCellID)
        tableView.backgroundColor = .clear
    }
    
    
    func readDataFromRealm(){
        latAndLongResults = REALM.objects(LocationRealm.self)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    //MARK: - Help Functions
    
    // Prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LLToResult"{
            
            let resultVC = segue.destination as! ResultVC
            
            guard let location = sender as? Location else {return}
            resultVC.location = location
            resultVC.shouldUseCurrentLocation = false
        }
    }
    
    
    @IBAction func goTapped(_ sender: Any) {
        
        let latitude = (latitudeTF.text! as NSString).doubleValue
        let longitude = (longitideTF.text! as NSString).doubleValue
        
        let location = Location(latitude: latitude, longitude: longitude)
        
        let locationRealm = LocationRealm()
        locationRealm.longitude = longitude
        locationRealm.latitude = latitude

        
        do{
            try REALM.write{
                REALM.add(locationRealm)
            }
        }
        catch{
            print("DEBUG: Failed to encode data \(error)")
        }
        
        performSegue(withIdentifier: "LLToResult", sender: location)
    }
    
}

extension LaititudeLongitudeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return latAndLongResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: historyCellID, for: indexPath) as! HistoryCell
        
        cell.locationRealm = latAndLongResults[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}




