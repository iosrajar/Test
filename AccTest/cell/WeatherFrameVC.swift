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
    @IBOutlet weak var weasttxt: UILabel!
    @IBOutlet weak var collview: UICollectionView!
    
    
    var datetext = ""
    
    static var nib: UINib {
        return UINib(nibName: "WeatherFrameVC", bundle: Bundle(for: self))
    }
    
    class func viewFromNib() -> WeatherFrameVC {
        return nib.instantiate(withOwner: nil, options: nil).first as! WeatherFrameVC
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setDate(txtstr: String) {
        if !self.datetext.elementsEqual(txtstr) {
            self.datetext = txtstr
            self.dttxt.text = self.datetext
        }
    }
    
}


extension WeatherFrameVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleViewCell", for: indexPath) as! SampleViewCell
        
        let weatherSample = weatherSamples[indexPath.row]
        cell.setWeatherSample(weatherSample: weatherSample)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherSamples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
}

