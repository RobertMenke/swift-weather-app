//
//  WeatherCell.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/8/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell : UITableViewCell {
    
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var forecast_label: UILabel!
    @IBOutlet weak var weather_icon: UIImageView!
    @IBOutlet weak var low_high: UILabel!
    var forecast : WeatherForecast?
    
    
    func applyForecast (forecast : WeatherForecast) {
        self.forecast = forecast
        time_label.text = forecast.getDateString()
        forecast_label.text =  forecast.weather_description
        low_high.text = forecast.getFormattedTemperature()
        forecast.downloadImage(callback: {image in
            self.weather_icon.image = image
        })
    }
    

}
