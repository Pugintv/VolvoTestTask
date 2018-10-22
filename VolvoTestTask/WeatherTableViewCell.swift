//
//  WeatherTableViewCell.swift
//  VolvoTestTask
//
//  Created by Victor Rosas on 10/19/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import UIKit
import AlamofireImage

class WeatherTableViewCell: UITableViewCell {
    
    
   
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblCurrentCity: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ viewModel: WeatherModel){
    
        lblMinTemp.text = String(format:"Low: %.0f ºC",viewModel.minTemp)
        lblMaxTemp.text = String(format:"High: %.0f ºC",viewModel.maxTemp)
        lblCurrentCity.text = String(viewModel.cityName)
        lblCurrentTemp.text = String(format:"Current: %.0f ºC",viewModel.currentTemp)
        imgWeather.af_setImage(withURL: viewModel.weatherImage)
    }
    

}

