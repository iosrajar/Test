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
    
    func getWeather(lat: Double, lon:Double,completionHandler: @escaping (Int?, Error?) -> Void) {
        
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
                        let weatherdatas = ServerAPI.parseWeatherData(json: weather)
                        WeatherState.sharedInstance.weatherdatas = weatherdatas
                        completionHandler(200, nil)
                        //print("Date and time: \(listarr["dt_txt"]!)")
                    } catch {
                        completionHandler(-1, error)
                    }
                }
            }
        }
        
        task.resume()
    }
    

    
    
    class func parseWeatherData(json: Any) -> [weatherdata] {
        var weatherDataPoints: [weatherdata] = []
        
        if let dict = json as? NSDictionary {
            
            if let list = dict["list"] as? [[String:AnyObject]] {
                
                for a in list {
                    let weather = weatherdata()
                    
                    let main = a["main"] as? [String:AnyObject]
                    let weatherInfo = a["weather"] as? [[String:AnyObject]]
                    
                    weather.dt = a["dt"] as? Int
                    weather.Tempr = Float(main!["temp"] as! Double)
                    weather.minTemp = Float(main!["temp_min"] as! Double)
                    weather.maxTemp = Float(main!["temp_max"] as! Double) 
                    if (weatherInfo != nil && weatherInfo!.count > 0) {
                        weather.weatherDesc = weatherInfo?[0]["description"] as? String
                    }
                    weatherDataPoints.append(weather)
                }
            }
            
        }
        
        return weatherDataPoints
    }
    
}
