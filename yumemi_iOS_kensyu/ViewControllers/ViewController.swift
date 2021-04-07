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
        
        do {
            let nowWeather = try YumemiWeather.fetchWeather(at: "")
            if let weather = Weather.init(rawValue: nowWeather) {
                weatherImageView.image = weather.image
            }
        } catch YumemiWeatherError.invalidParameterError {
            presentYumemiWeatherAPIAleart(message: "パラメータが誤っております。")
        } catch YumemiWeatherError.jsonDecodeError {
            presentYumemiWeatherAPIAleart(message: "JSONの変換に失敗しました。")
        } catch YumemiWeatherError.unknownError {
            presentYumemiWeatherAPIAleart(message: "天気情報取得で予期せぬエラーが発生しました。")
        } catch {
            presentYumemiWeatherAPIAleart(message: "予期せぬエラーが発生しました。")
        }
    }
    
    private func presentYumemiWeatherAPIAleart(message: String) {
        let aleart = UIAlertController(title: "天気取得エラー", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        aleart.addAction(okAction)
        
        present(aleart, animated: true, completion: nil)
    }
}

