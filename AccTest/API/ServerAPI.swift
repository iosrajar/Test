//
//  ServerAPI.swift
//  AccTest
//
//  Created by Raja R on 12/4/19.
//  Copyright © 2019 r2r. All rights reserved.
//

import Foundation


class ServerAPI {
    private let openWeatherURL = "http://api.openweathermap.org/data/2.5/forecast"
    //lat=35&lon=139&APPID=f40583ca2a0d75901cc196ae9e5f9e01"
    private let APIKey = "f40583ca2a0d75901cc196ae9e5f9e01"
    private var info:Any = ""
    
    func getWeather(lat: Double, lon:Double) {
        
        let session = URLSession.shared
        let weatherRequestURL = URL(string: "\(openWeatherURL)?lat=\(lat)&lon=\(lon)&APPID=\(APIKey)")!
//        let task = URLSession.shared.dataTask(with: weatherRequestURL, completionHandler:    {(data, response, error) in
        let task = session.dataTask(with: weatherRequestURL) { (data, response, error) in
            if error != nil {
                print(error ?? "Error")
            } else {
                if let usableData = data {
                    print("USEDATA \(usableData)") //JSONSerialization
                    do {
                        let weather = try JSONSerialization.jsonObject(
                            with: usableData,
                            options: .mutableContainers) as! [String: AnyObject]
                        let listarr:NSDictionary = weather["list"]![0]! as! NSDictionary
                        print("Date and time: \(listarr["dt_txt"]!)")
                        
//                        let jsonSerialized = try JSONSerialization.jsonObject(with: usableData, options: []) as? [String : Any]
//                        self.info = jsonSerialized
//                        //completion(info)
//                        let dicjson = jsonSerialized!
//                        let listarr:NSArray = dicjson["list"]! as! NSArray
//                        let firarr = listarr[0]
//                        print(firarr["dt_txt"]! as String)
                    } catch {
                        print("didnt work")
                    }
                }
            }
        }
        
        task.resume()
    }
}
