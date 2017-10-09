//
//  ViewController.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/6/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var fetcher : WeatherFetcher?
    var weather : Array<WeatherForecast> = Array()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search_input: UITextField!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "row", for: indexPath) as! WeatherCell
        cell.applyForecast(forecast: weather[indexPath.row])
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_details" {
//            let detail = segue.destination as! ForecastDetail
//            print(sender)
//            detail.forecast = (sender as AnyObject).forecast
        }
    }

    func onWeatherFetch (response : JSON) -> Void {
        if(response["list"] != JSON.null) {
            print(response["list"])
            let raw_data : Array<JSON> = response["list"].array!
            weather = raw_data.map { WeatherForecast(json: $0) }
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    @IBAction func onSearchTapped(_ sender: UIButton!) {
        performSearch()
    }
    
    func performSearch() -> Void {
        let text = search_input.text!
        self.fetcher?.setLocation(location: text)
    }
}
