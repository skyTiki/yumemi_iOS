//
//  ViewController.swift
//  yumemi_iOS_kensyu
//
//  Created by takatoshi.ichige on 2021/04/07.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // reloadボタンタップ
    @IBAction func tappedReloadButton(_ sender: Any) {
        
        let nowWeather =  YumemiWeather.fetchWeather()
        if let weather = Weather.init(rawValue: nowWeather) {
            weatherImageView.image = weather.image
        }
    }
}

