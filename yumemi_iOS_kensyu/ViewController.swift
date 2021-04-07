//
//  ViewController.swift
//  yumemi_iOS_kensyu
//
//  Created by takatoshi.ichige on 2021/04/07.
//

import UIKit
import YumemiWeather

enum weather: String {
    case sunny,cloudy,rainy
}

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func tappedReloadButton(_ sender: Any) {
        
        let nowWeather =  YumemiWeather.fetchWeather()
        if let weather = weather.init(rawValue: nowWeather) {
            switch weather {
            case .sunny:
                weatherImageView.image = UIImage(named: "iconmonstr-weather-1.pdf")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
                weatherImageView.tintColor = .orange
            case .cloudy:
                weatherImageView.image = UIImage(named: "iconmonstr-weather-11.pdf")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
                weatherImageView.tintColor = .lightGray
            case .rainy:
                weatherImageView.image = UIImage(named: "iconmonstr-umbrella-1.pdf")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
                weatherImageView.tintColor = .cyan
            }
        }
    }
    
    
    
}

