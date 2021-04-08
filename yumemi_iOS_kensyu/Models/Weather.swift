//
//  Weather.swift
//  yumemi_iOS_kensyu
//
//  Created by takatoshi.ichige on 2021/04/07.
//

import UIKit

enum WeatherPattern: String {
    case sunny,cloudy,rainy
}

struct Weather: Codable {
    let weather: String
    let maxTemp: Int
    let minTemp: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case date
    }
    
    var weatherPattern: WeatherPattern {
        if let weatherPattern = WeatherPattern(rawValue: weather) {
            return weatherPattern
        } else { fatalError("WeatherPatternへの変換で失敗しました。") }
    }
    
    var image: UIImage {
        switch weatherPattern {
        case .sunny:
            return UIImage(named: "iconmonstr-weather-1.pdf")!.withTintColor(.systemRed)
        case .cloudy:
            return UIImage(named: "iconmonstr-weather-11.pdf")!.withTintColor(.systemGray)
        case .rainy:
            return UIImage(named: "iconmonstr-umbrella-1.pdf")!.withTintColor(.systemBlue)
        }
    }
    
}

struct WetherRequest: Codable {
    let area: String
    var date: Date
}
