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
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // reloadボタンタップ
    @IBAction func tappedReloadButton(_ sender: Any) {
        
        let exampleArea = """
            {"area": "tokyo", "date": "2020-04-01T12:00:00+09:00"}
            """
        
        switch fetchWether(at: exampleArea) {
        case let .success(weather):
            setUIWeatherData(weather: weather)
        case let .failure(error):
            presentYumemiWeatherAPIAleart(message: error.description)
        }
    }
    
    // 天気データ取得
    private func fetchWether(at requestJsonString: String) -> Result<Weather, FetchWeatherError> {
        
        // JSON取得
        let responseJsonString: String
        do {
            responseJsonString = try YumemiWeather.syncFetchWeather(requestJsonString)
        } catch let error as YumemiWeatherError {
            return .failure(.apiError(error))
        } catch {
            return .failure(.unkownError)
        }
        
        // JSONデコード
        let weather: Weather
        // データ化
        guard let weatherJsonData = responseJsonString.data(using: .utf8) else { return  .failure(.apiError(.jsonDecodeError))}
        
        do {
            weather = try JSONDecoder().decode(Weather.self, from: weatherJsonData)
            return .success(weather)
        } catch  {
            return .failure(.apiError(.jsonDecodeError))
        }
        
    }
    
    private func setUIWeatherData(weather: Weather) {
        weatherImageView.image = WeatherPattern(rawValue: weather.weather)?.image
        minTempLabel.text = "\(weather.minTemp)"
        maxTempLabel.text = "\(weather.maxTemp)"
        
    }
    
    
    // アラート出力処理
    private func presentYumemiWeatherAPIAleart(message: String) {
        let aleart = UIAlertController(title: "天気取得エラー", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        aleart.addAction(okAction)
        
        present(aleart, animated: true, completion: nil)
    }
}

