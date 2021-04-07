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
        
        let exampleArea = "tokyo"
        
        switch fetchWether(at: exampleArea) {
        case let .success(weather):
            weatherImageView.image = weather.image
            
        case let .failure(error):
            presentYumemiWeatherAPIAleart(message: error.description)
        }
    }
    
    private func fetchWether(at area: String) -> Result<Weather, FetchWeatherError> {
        
        let weatherString: String
        
        do {
            weatherString = try YumemiWeather.fetchWeather(at: area)
        } catch let error as YumemiWeatherError {
            return .failure(.apiError(error))
        } catch {
            return .failure(.unkownError)
        }
        
        if let weather = Weather(rawValue: weatherString) {
            return .success(weather)
        } else {
            return .failure(.unkownError)
        }
        
    }
    
    private func presentYumemiWeatherAPIAleart(message: String) {
        let aleart = UIAlertController(title: "天気取得エラー", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        aleart.addAction(okAction)
        
        present(aleart, animated: true, completion: nil)
    }
}

