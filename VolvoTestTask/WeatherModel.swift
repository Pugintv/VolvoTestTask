//
//  WeatherModel.swift
//  VolvoTestTask
//
//  Created by Victor Rosas on 10/19/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import Foundation

class WeatherModel:NSObject{
    
    var cityName: String
    var minTemp: Double
    var maxTemp: Double
    var currentTemp: Double
    var weatherImage: URL
    
    init(cityName:String, minTemp:Double,maxTemp:Double,currentTemp:Double,weatherImage:URL){
        self.cityName = cityName
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.currentTemp = currentTemp
        self.weatherImage = weatherImage
    }
    
}
