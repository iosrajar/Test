//
//  weatherdata.swift
//  AccTest
//
//  Created by Raja R on 13/4/19.
//  Copyright © 2019 r2r. All rights reserved.
//

import Foundation
class weatherdata {
    var dt: Int?
    var Tempr:Float?
    var minTemp: Float?
    var maxTemp: Float?
    var weatherDesc: String?
    


    func temperatureInCelsius() -> Float? {
        if (Tempr == nil) {
            return nil
        }
        return round(Tempr! - 273.15)
    }
    
    func minTemperatureInCelsius() -> Float? {
        if (minTemp == nil) {
            return nil
        }
        return round(minTemp! - 273.15)
    }
    
    func maxTemperatureInCelsius() -> Float? {
        if (maxTemp == nil) {
            return nil
        }
        return round(maxTemp! - 273.15)
    }
    
func date() -> Date? {
    if (dt == nil) {
        return nil
    }
    let ti = TimeInterval(dt!)
    return Date(timeIntervalSince1970: ti)
}

func dateString(format: String) -> String {
    if let date = date() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    return ""
}
}
