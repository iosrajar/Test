//
//  WeatherFrameVC.swift
//  AccTest
//
//  Created by Raja R on 12/4/19.
//  Copyright © 2019 r2r. All rights reserved.
//

import UIKit
class WeatherFrameVC: UITableViewCell {

    @IBOutlet weak var dttxt: UILabel!
    @IBOutlet weak var cview: UICollectionView!
    
    var weatherdatasHr: [weatherdata] = []
    
    var datetext = ""
    
    static var nib: UINib {
        return UINib(nibName: "WeatherFrameVC", bundle: Bundle(for: self))
    }
    
    class func viewFromNib() -> WeatherFrameVC {
        return nib.instantiate(withOwner: nil, options: nil).first as! WeatherFrameVC
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setDate(txtstr: String) {
        if !self.datetext.elementsEqual(txtstr) {
            self.datetext = txtstr
            self.dttxt.text = self.datetext
        }
    }
    func setup() {
        let nibName = UINib(nibName: "HourlyCell", bundle: nil)
        cview.register(nibName, forCellWithReuseIdentifier: "HourlyCell")
    }
    
    func setWeatherData(weatherdatas: [weatherdata]) {
        self.weatherdatasHr = weatherdatas
        cview.reloadData()
        
        if (weatherdatas.count > 0) {
            dttxt.text = weatherdatas[0].dateString(format: "EEEE, MMM d, yyyy")
        }
    }
    
}


extension WeatherFrameVC:UICollectionViewDelegate, UICollectionViewDataSource {



    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyCell
        
        let weatherHourly = self.weatherdatasHr[indexPath.row]
        cell.setWeatherdata(weatherData: weatherHourly)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherdatasHr.count
    }

}

