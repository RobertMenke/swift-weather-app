//
//  ViewController.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/6/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
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
        return WeatherCell(forecast : weather[indexPath.row])
//        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "row")
//        cell.textLabel?.text = weather[indexPath.row].weather_description
//
//        cell.addSubview(createWeatherIcon())
//        return cell
    }
    
    func createWeatherIcon () -> UIButton {
        let button = UIButton()
        let sunnyImage = UIImage(named:"ic_wb_sunny")?.withRenderingMode(
            UIImageRenderingMode.alwaysTemplate)
        button.tintColor = UIColor(white:0, alpha:0.54)
        button.setImage(sunnyImage, for: UIControlState.normal)
        
        return button
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
