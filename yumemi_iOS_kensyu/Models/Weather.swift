//
//  Weather.swift
//  yumemi_iOS_kensyu
//
//  Created by takatoshi.ichige on 2021/04/07.
//

import UIKit

enum Weather: String {
    case sunny,cloudy,rainy
}

extension Weather {
    var image: UIImage {
        if let weather = Weather.init(rawValue: rawValue) {
            switch weather {
            case .sunny:
                return UIImage(named: "iconmonstr-weather-1.pdf")!.withTintColor(.systemRed)
            case .cloudy:
                return UIImage(named: "iconmonstr-weather-11.pdf")!.withTintColor(.systemGray)
            case .rainy:
                return UIImage(named: "iconmonstr-umbrella-1.pdf")!.withTintColor(.systemBlue)
            }
        } else {
            // 空を返却
            return UIImage.init()
        }
    }
}

