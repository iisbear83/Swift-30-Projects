//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Yi Gu on 9/5/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherKit

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var weatherLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  
  var location = "San Francisco, U.S."
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = CGSize(width: UIScreen.main.applicationFrame.size.width, height: 37.0);
    displayCurrentWeather()
  }
  
  func displayCurrentWeather() -> Bool {
    // Update location
    cityLabel.text = location
    var isFetched = false

    // Invoke weather service to get the weather data
    WeatherService.sharedWeatherService().getCurrentWeather(location, completion: { (data) -> () in
      OperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        guard let weatherData = data else {
          isFetched = false
          return
        }

        self.weatherLabel.text = weatherData.weather.capitalizedString
        self.tempLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
        isFetched = true
      })
    })
    return isFetched
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    if displayCurrentWeather() {
      completionHandler(NCUpdateResult.newData)
    } else {
      completionHandler(NCUpdateResult.noData)
    }
  }
}
