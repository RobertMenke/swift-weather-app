//
//  WeatherForecast.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/6/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import Foundation

import SwiftyJSON
import SwiftDate

class WeatherForecast : NSObject {
    
    var json : JSON
    var humidity : Int
    var low_temperature : Float
    var high_temperature : Float
    var weather_description: String
    var weather_tag : String
    var date : String
    let dates : Array<String> = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    init(json : JSON) {
        self.json                   = json
        self.humidity               = json["main"]["humidity"].int!
        self.low_temperature        = json["main"]["temp_min"].float!
        self.high_temperature       = json["main"]["temp_max"].float!
        self.weather_description    = json["weather"][0]["description"].string!
        self.weather_tag            = json["weather"][0]["main"].string!
        self.date                   = json["dt_txt"].string!
        super.init()
    }
    
    func getDateTime () -> DateInRegion {
        let region = Region(tz: TimeZoneName.americaNewYork, cal: CalendarName.gregorian, loc: LocaleName.englishUnitedStates)
        // Parse a string which a custom format
        return DateInRegion(string: self.date, format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: region)!
    }
    
    //Get a formatted time, like 3PM
    func getDateString () -> String {
        let date = getDateTime()
        print(date.weekday)
        return dates[date.weekday - 1] + ", " + date.string(dateStyle: .none, timeStyle: .short)
    }

    //Download the image from openweatherapi
    func downloadImage(callback : @escaping (UIImage) -> Void) {
        let url = getImageURL()
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                callback(UIImage(data : data)!)
            }
        }
    }

    func getFormattedTemperature () -> String {
        let low = formatTemperature(temp: low_temperature)
        let high = formatTemperature(temp: high_temperature)
        return low + "/" + high
    }

    private func getImageURL () -> URL {
        return URL(string : "https://openweathermap.org/img/w/" + getImageString())!
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
    
    private func formatTemperature (temp : Float) -> String {
        let temp = String(Int(9 / 5 * (temp - 273) + 32))
        return temp + "\u{00B0}"
    }
    
    //https://openweathermap.org/weather-conditions
    private func getImageString () -> String {
        switch (weather_tag) {
        case "Thunderstorm":
            return "11d.png"
        case "Drizzle":
            return "09d.png"
        case "Rain":
            return "10d.png"
        case "Snow":
            return "13d.png"
        case "Atmosphere":
            return "50d.png"
        case "Clear":
            return "01d.png"
        case "Clouds":
            return "03d.png"
        case "Extreme":
            return "11d.png"
        default:
            return "11d.png"
        }
    }
}
