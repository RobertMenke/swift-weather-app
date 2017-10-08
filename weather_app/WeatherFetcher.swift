//
//  WeatherFetcher.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/6/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherFetcher : NSObject {
    
    var location = "Raleigh"
    let api_key : String = "163858925dc41b12dce74dd7b3c1fc05"
    var callback : (JSON) -> Void
    
    init(callback : @escaping (JSON) -> Void) {
        self.callback = callback
    }
    
    func fetchWeather () -> Void {
        let task = URLSession.shared.dataTask(with: buildUrl()) {
            (data, response, error) in
            if(data != nil) {
                self.callback(JSON(data!))
            }
            else {
                print(error!)
            }
        }
        
        task.resume()
    }
    
    func setLocation (location : String) -> Void {
        self.location = location
        fetchWeather()
    }
    
    func buildUrl () -> URL {
        let encoded = location.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL(string : "https://api.openweathermap.org/data/2.5/forecast?q=\(encoded)&appid=\(api_key)")!
    }
}
