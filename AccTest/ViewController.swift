//
//  ViewController.swift
//  AccTest
//
//  Created by Raja R on 12/4/19.
//  Copyright © 2019 r2r. All rights reserved.
//

import UIKit
import CoreLocation

struct staticVariable { static let WeatherCellIdentifier = "WeatherFrameVC" }
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var weatherTBV: UITableView!
    var longitude:Double=139
    var latitude:Double=35
    var locationManager = CLLocationManager()
    
    var liststr:[[weatherdata]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        print(CLLocationManager.authorizationStatus())
        
        
        let nib = UINib(nibName: "WeatherFrameVC", bundle: nil)
        weatherTBV.register(nib, forCellReuseIdentifier:staticVariable.WeatherCellIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liststr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:WeatherFrameVC? = (tableView.dequeueReusableCell(
            withIdentifier: staticVariable.WeatherCellIdentifier) as? WeatherFrameVC)
        
        if cell == nil {
            cell = (UITableViewCell(style: .subtitle, reuseIdentifier: staticVariable.WeatherCellIdentifier) as? WeatherFrameVC)
        }
        
        cell?.setWeatherData(weatherdatas: liststr[indexPath.row])
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
        var currentLocation: CLLocation!
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locationManager.location
            if((currentLocation != nil)) {
            self.latitude = currentLocation.coordinate.latitude
            self.longitude = currentLocation.coordinate.longitude
            }
        }
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        let weather = ServerAPI();
        weather.getWeather(lat:self.latitude,lon:self.longitude) { (status, error) in
            //print("\(String(describing: status))")
            if(status!==200) {
                
                self.liststr = WeatherState.sharedInstance.groupedWeatherDatas()
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.weatherTBV.reloadData()
                }
                
            }
            
        }
        
    
    }
    
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

}

