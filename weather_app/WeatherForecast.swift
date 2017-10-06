//
//  WeatherForecast.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/6/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import Foundation

import SwiftyJSON

class WeatherForecast : NSObject {
    
    var json : JSON
    var humidity : Int
    var low_temperature : Float
    var high_temperature : Float
    var weather_description: String
    var weather_tag : String
    
    init(json : JSON) {
        self.json                   = json
        self.humidity               = json["main"]["humidity"].int!
        self.low_temperature        = json["main"]["temp_min"].float!
        self.high_temperature       = json["main"]["temp_max"].float!
        self.weather_description    = json["weather"][0]["description"].string!
        self.weather_tag            = json["weather"][0]["main"].string!
        
        super.init()
    }
}
