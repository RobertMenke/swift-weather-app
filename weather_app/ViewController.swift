//
//  ViewController.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/6/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fetcher : WeatherFetcher?
    var weather : Array<WeatherForecast> = Array()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetcher = WeatherFetcher(callback : self.onWeatherFetch)
        fetcher?.fetchWeather()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "row")
        cell.textLabel?.text = weather[indexPath.row].weather_description
        return cell
    }

    func onWeatherFetch (response : JSON) -> Void {
        print(response)
        let raw_data : Array<JSON> = response["list"].array!
        weather = raw_data.map { WeatherForecast(json: $0) }
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
}
