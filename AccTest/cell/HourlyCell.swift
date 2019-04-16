//
//  HourlyCell.swift
//  AccTest
//
//  Created by Raja R on 13/4/19.
//  Copyright © 2019 r2r. All rights reserved.
//

import UIKit

class HourlyCell: UICollectionViewCell {
    
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    var weatherdata: weatherdata?
    static var nib: UINib {
        return UINib(nibName: "HourlyCell", bundle: Bundle(for: self))
    }
    
    class func viewFromNib() -> HourlyCell {
        return nib.instantiate(withOwner: nil, options: nil).first as! HourlyCell
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setWeatherdata(weatherData: weatherdata) {
        self.weatherdata = weatherData
        
        
        if (weatherData.temperatureInCelsius() != nil) {
            temperatureLabel.text = "\(weatherData.temperatureInCelsius()!) °C"
        }
        if (weatherData.minTemperatureInCelsius() != nil) {
            minTemperatureLabel.text = "\(weatherData.minTemperatureInCelsius()!) °C"
        }
        if (weatherData.maxTemperatureInCelsius() != nil) {
            maxTemperatureLabel.text = "\(weatherData.maxTemperatureInCelsius()!) °C"
        }
        DescriptionLabel.text = weatherData.weatherDesc
        hourLabel.text = weatherData.dateString(format: "HH:mm")
    }
    
    
}
