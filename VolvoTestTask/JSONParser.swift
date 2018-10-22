//
//  JSONParser.swift
//  VolvoTestTask
//
//  Created by Victor Rosas on 10/20/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONParser {
    
    class func JSONtoWoeId(json: JSON) -> String {
        let woeId = json[0]["woeid"].int ?? 0
        return String(woeId)
    }
    
    class func JSONtoWeatherModel(json: JSON) -> WeatherModel {
        
        let minTemp = json[0]["min_temp"].double ?? 0.0
        let maxTemp = json[0]["max_temp"].double ?? 0.0
        let currentTemp = json[0]["the_temp"].double ?? 0.0
        let imageURL = json[0]["weather_state_abbr"].string ?? ""
        let cityName = ""
        
        let weatherModel = WeatherModel(cityName: cityName, minTemp: minTemp, maxTemp: maxTemp,currentTemp: currentTemp, weatherImage: getWeatherIcon(weather: imageURL))
        return weatherModel
    }
    
    class func getWeatherIcon(weather:String)->URL{
        let weatherURL = URL(string:"https://www.metaweather.com/static/img/weather/png/64/\(weather).png")
        return weatherURL!
    }
}
