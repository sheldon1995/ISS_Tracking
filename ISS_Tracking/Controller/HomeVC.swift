//
//  HomeVC.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//

import Foundation
import GoogleMaps
class HomeVC: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var mapView: GMSMapView!
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        observeISSCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureMapView()
    }
    
    //MARK: - Help Functions
    
    func configureMapView(){

        mapView.layer.cornerRadius = mapView.frame.width / 2
    }
    
    func observeISSCurrentLocation(){
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            APIService.shared.fetchISSCurrentLocation { (iss) in
                self.mapView.clear()
                let lat = iss.latitude
                let long = iss.longitude
                
                let camero = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 4)
                self.mapView.camera = camero
                
                let currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                
                CATransaction.begin()
                CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
                self.mapView.animate(to: GMSCameraPosition.camera(withTarget: currentLocation, zoom: 4))
                
                CATransaction.commit()
                
                let marker = GMSMarker(position: currentLocation)
                marker.icon = UIImage(named: "satellite")
                marker.map = self.mapView
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CurrentLocationToResult"{
            
            let resultVC = segue.destination as! ResultVC
            resultVC.shouldUseCurrentLocation = true
            
        }
        
    }
    
    @IBAction func currentLocationTapped(_ sender: Any) {
        performSegue(withIdentifier: "CurrentLocationToResult", sender: nil)
    }
    
    
}
