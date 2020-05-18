//
//  ResultVC.swift
//  ISS_Tracking
//
//  Created by Sheldon on 5/18/20.
//  Copyright © 2020 wentao. All rights reserved.
//


import UIKit
import GoogleMaps

class ResultVC: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    let responseCellID = "responseCell"
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var shouldUseCurrentLocation = false
    @IBOutlet weak var tableView: UITableView!
    var responeses = [Response]()
    
    var cityName : String?{
        didSet{
            
            guard let address = cityName else {return}
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                
                if let placemark = placemarks?.first {
                    let coordinates = placemark.location!.coordinate
                    let lat = coordinates.latitude
                    let long = coordinates.longitude
                    let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    APIService.shared.fetchISSPassTimes(withLatitude: lat, withLongitude: long) { (iss) in
                        guard let responses = iss.responses else {return}
                        self.responeses = responses
                        DispatchQueue.main.async {
                            self.setUpMapView()
                            let marker = GMSMarker(position: position)
                            self.mapView.camera = GMSCameraPosition.init(target: position, zoom: 5)
                            marker.map = self.mapView
                            marker.title = "\(address.capitalized)"
                            marker.snippet =  "Latitude is \(lat), longitude is \(long)"
                            self.tableView.reloadData()
                        }
                    }
                    
                    
                    
                }
            })
            
        }
    }
    
    var location : Location?{
        didSet{
            
            guard let location = self.location else {return}
            let lat = location.latitude
            let long = location.longitude
            let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            APIService.shared.fetchISSPassTimes(withLatitude: lat, withLongitude: long) { (iss) in
                guard let responses = iss.responses else {return}
                self.responeses = responses
                DispatchQueue.main.async {
                    self.setUpMapView()
                    let marker = GMSMarker(position: position)
                    self.mapView.camera = GMSCameraPosition.init(target: position, zoom: 5)
                    marker.map = self.mapView
                    marker.title = "Latitude is \(lat), longitude is \(long)"
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ResponseCell", bundle: nil), forCellReuseIdentifier: responseCellID)
        tableView.backgroundColor = .clear
        
        
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .white
        if CLLocationManager.locationServicesEnabled() {
            if shouldUseCurrentLocation{
                
                let coordinate = fetchCurrentCoordinate()
                guard let lat = coordinate?.latitude else {return}
                guard let long = coordinate?.longitude else {return}
                
                APIService.shared.fetchISSPassTimes(withLatitude: lat, withLongitude: long) { (iss) in
                    guard let responses = iss.responses else {return}
                    self.responeses = responses
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
        }
        
        
    }
    
    //MARK: - Help Functions
    func setUpMapView(){
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
        locationManager.requestLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
    }
    
    func fetchCurrentCoordinate() -> CLLocationCoordinate2D?{
        let currentLocation = locationManager.location
        guard let coordinate = currentLocation?.coordinate else {return nil}
        return coordinate
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension ResultVC : CLLocationManagerDelegate{
    func locationManager( _ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        if shouldUseCurrentLocation{
            
            setUpMapView()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        
        if shouldUseCurrentLocation{
            
            guard let location = locations.first else {return}
            
            DispatchQueue.main.async {
                self.mapView.camera = GMSCameraPosition.init(target: location.coordinate, zoom: 5)
            }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }
}


extension ResultVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return responeses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: responseCellID, for: indexPath) as! ResponseCell
        cell.response = self.responeses[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}
