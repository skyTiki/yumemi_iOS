//
//  FetchWeatherError.swift
//  yumemi_iOS_kensyu
//
//  Created by takatoshi.ichige on 2021/04/07.
//

import Foundation
import YumemiWeather

enum FetchWeatherError: Error {
    case apiError(YumemiWeatherError)
    case unkownError
    
    var description: String {
        switch self {
        case .apiError(.invalidParameterError):
            return "パラメータに不正があります。"
        case .apiError(.jsonDecodeError):
            return "JSONデータの変換に失敗しました。"
        case .apiError(.unknownError), .unkownError:
            return "予期せぬエラーが発生しました。"
        }
    }
}
