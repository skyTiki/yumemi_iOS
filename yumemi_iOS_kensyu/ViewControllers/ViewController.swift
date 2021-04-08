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
    
    private let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // reloadボタンタップ
    @IBAction func tappedReloadButton(_ sender: Any) {
        
        let exampleArea: WetherRequest = .init(area: "tokyo", date: Date())
        
        switch fetchWether(wetherRequest: exampleArea) {
        case let .success(weather):
            setUIWeatherData(weather: weather)
            
        case let .failure(error):
            presentYumemiWeatherAPIAleart(message: error.description)
        }
    }
    
    // 天気データ取得
    private func fetchWether(wetherRequest: WetherRequest) -> Result<Weather, FetchWeatherError> {
        
        // リクエスト用Jsonエンコード
        let requestJson: Data
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .formatted(dateformatter)
        
        // 構造体→JSON形式
        do {
            requestJson = try jsonEncoder.encode(wetherRequest)
        } catch {
            return .failure(FetchWeatherError.WeatherAppError(.JSONEncodeError))
        }
        // JSON→文字列
        guard let requestJsonString = String(data: requestJson, encoding: .utf8) else { return .failure(FetchWeatherError.WeatherAppError(.JSONEncodeError))}
        
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
        } catch let error as YumemiWeatherError {
            return .failure(.apiError(error))
        } catch {
            return .failure(.unkownError)
        }
        
    }
    
    private func setUIWeatherData(weather: Weather) {
        weatherImageView.image = weather.image
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

