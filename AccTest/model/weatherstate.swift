//
//  weatherstate.swift
//  AccTest
//
//  Created by Raja R on 13/4/19.
//  Copyright © 2019 r2r. All rights reserved.
//

import Foundation
class WeatherState {
    
    static let sharedInstance = WeatherState()
    
    var weatherdatas: [weatherdata]?
    
    // This function is to group the samples by their date
    
    
    func groupedWeatherDatas() -> [[weatherdata]] {
        
        if (weatherdatas == nil || weatherdatas!.count < 1) {
            return [[]]
        }
        
        // Helper variable to map the samples by their date
        var dict: [String:[weatherdata]] = [:]
        
        for ws in weatherdatas! {
            let dateKey = ws.dateString(format: "YYYYMMdd")
            if (dict[dateKey] == nil || dict[dateKey]!.count < 1) {
                dict[dateKey] = []
            }
            dict[dateKey]?.append(ws)
        }
        
        var retval: [[weatherdata]] = []
        
        let sortedKeys = Array(dict.keys).sorted()
        for key in sortedKeys {
            retval.append(dict[key]!)
        }
        
        return retval
    }
    
}
