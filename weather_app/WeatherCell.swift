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
    
    var forecast : WeatherForecast
    let identifier = "row"
    
    init(forecast : WeatherForecast) {
        self.forecast = forecast
        super.init(style: getStyle(), reuseIdentifier: self.identifier)
        setText()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getStyle () -> UITableViewCellStyle {
        return UITableViewCellStyle.default
    }
    
    func setText () {
        self.textLabel?.text = forecast.weather_description
    }
    
    
    //https://openweathermap.org/weather-conditions
    func getIconType () -> String {
        switch (forecast.weather_tag) {
        case "Thunderstorm":
            return "Thunderstorm"
        case "Drizzle":
            return "Drizzle"
        case "Rain":
            return "rain"
        case "Snow":
            return "Snow"
        case "Clouds":
            return "clouds"
        case "Snow":
            return "snow"
        case "Clear":
            return "Clear"
        default:
            return "Clear"
        }
    }
}
