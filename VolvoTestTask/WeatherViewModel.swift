//
//  WeatherViewModel.swift
//  VolvoTestTask
//
//  Created by Victor Rosas on 10/19/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel{
    
    var weatherModel: WeatherModel
    
    var minTemp: Int?
    var maxTemp: Int?
    var currentTemp: Int?
    var currentCity: String?
    var imgURL: URL?
    
    init(_ weatherModel: WeatherModel){
        self.weatherModel = weatherModel
        
        minTemp = Int(weatherModel.minTemp)
        maxTemp = Int(weatherModel.maxTemp)
        currentTemp = Int(weatherModel.currentTemp)
        currentCity = weatherModel.cityName
        imgURL = weatherModel.weatherImage
    }
    
    func addCity(cityName: String){
        currentCity = cityName
    }
    
    func getCell(_ tableView: UITableView,indexPath:IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
        cell.setup(weatherModel)
        return cell
    }
    
    
}
