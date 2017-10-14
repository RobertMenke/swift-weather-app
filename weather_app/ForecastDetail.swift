//
//  ForecastDetail.swift
//  weather_app
//
//  Created by Robert B. Menke on 10/9/17.
//  Copyright © 2017 Robert. All rights reserved.
//

import UIKit

class ForecastDetail: UIViewController {

    @IBOutlet weak var high_view: UIView!
    @IBOutlet weak var low_view: UIView!
    @IBOutlet weak var humidity_view: UIView!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var high_label: UILabel!
    @IBOutlet weak var low_label: UILabel!
    @IBOutlet weak var humidity_label: UILabel!
    @IBOutlet weak var image_view: UIImageView!
    
    var forecast : WeatherForecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add borders
        let border_color = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        addBottomBorder(view: high_view, color: border_color, width: 1)
        addBottomBorder(view: low_view, color: border_color, width: 1)
        //Add labels
        date_label.text = forecast?.getVerboseDateString()
        high_label.text = forecast?.getHighTemperature()
        low_label.text = forecast?.getLowTemperature()
        humidity_label.text = forecast?.getFormattedHumidity()
        self.title = forecast?.getVerboseWeekday()
        forecast?.downloadImage(callback: {image in
            self.image_view.image = image
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addBottomBorder(view : UIView, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: view.frame.size.height - width, width: view.frame.size.width, height: width)
        view.layer.addSublayer(border)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
