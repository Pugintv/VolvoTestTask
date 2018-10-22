//
//  WebService.swift
//  VolvoTestTask
//
//  Created by Victor Rosas on 10/19/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import Foundation
import Alamofire

class WebService: NSObject {
    let baseURL:String = "https://www.metaweather.com/api/"
    var delegate: WebServiceProtocol?
    
    //We can also just do an enum with all woeIds but this is more flexible
    
    func getWoeIdForCity(cityName: String){ //Return the woeid for the selected city
        
        let encodedCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let requestURL = "\(baseURL)location/search/?query=\(encodedCity ?? "")"
        Alamofire.request(requestURL).responseJSON{(response) in
            switch response.result{
            case .success:
                let json = response.result.value
                self.delegate?.finishedWoeIdWithError(data:json,error:nil)
                
            case .failure(let error):
                self.delegate?.finishedWoeIdWithError(data: nil, error: error as NSError)
                
            }
        }
    }
    
    func getWeatherforWoeId(woeid: String){
        let tomorrow = DateUtilities.getTomorrowsDate()
        let requestURL = "\(baseURL)location/\(woeid)/\(tomorrow)/"
        print(requestURL)
        Alamofire.request(requestURL).responseJSON{(response) in
            switch response.result{
            case .success:
                let json = response.result.value
                self.delegate?.finishedWeatherWithError(data: json, error: nil)
                
            case .failure(let error):
                self.delegate?.finishedWeatherWithError(data: nil, error: error as NSError)
            }
        }
    }

    
}

protocol WebServiceProtocol {
    func finishedWoeIdWithError(data: Any?, error: NSError?)
    func finishedWeatherWithError(data: Any?, error: NSError?)
}
