//
//  ViewController.swift
//  VolvoTestTask
//
//  Created by Victor Rosas on 10/19/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class ViewController: UITableViewController,WebServiceProtocol {
    
    
    @IBOutlet var weatherTableView: UITableView!
    
    var citiesArray = ["Gothenburg","Stockholm","Mountain View","London","New York","Berlin"] //We can init this in plist or NSUserDefaults also
    var woeIds = [String]() // We could have hardcoded the ids but this allow us to add new cities as needed
    var forecastsArray = [WeatherModel]()
    let webService = WebService()
    let HUDMessage = "Loading" // We can also load our message from plist.
    
    lazy var pullToRefresh: UIRefreshControl = { //Pull to refresh may never be used so only load it when needed
        let pullToRefresh = UIRefreshControl()
        pullToRefresh.addTarget(self, action: #selector(ViewController.refreshHandler(_:)), for: .valueChanged)
        pullToRefresh.tintColor = UIColor.purple
        
        return pullToRefresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        webService.delegate = self
        weatherTableView.allowsSelection = false
        weatherTableView.addSubview(pullToRefresh)
        loadData()
    }
    
    func loadData(){
        showHUD(HUDMessage)
        for city in citiesArray{
            webService.getWoeIdForCity(cityName: city)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = forecastsArray[indexPath.row]
        let weatherViewModel = WeatherViewModel(weather)
        return weatherViewModel.getCell(tableView,indexPath:indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //Handle Refresh
    @objc func refreshHandler(_ pullToRefresh: UIRefreshControl){
        loadData()
        weatherTableView.reloadData()
        pullToRefresh.endRefreshing()
        hideHUD()
    }
    
    
    func finishedWoeIdWithError(data: Any?, error: NSError?) {
        
        if error != nil{
            print("Failed with error \(error!)")
        }
        
        guard let data = data else{ //Check for nil JSON
            print("Empty JSON")
            return
        }
        
        let json = JSON(data)
        
        let woeId = JSONParser.JSONtoWoeId(json: json)
        woeIds.append(woeId)
        if(woeIds.count == citiesArray.count){ //Once we get the same count of ids as cities
            for woeid in woeIds {
                webService.getWeatherforWoeId(woeid: woeid)
            }
        }
    }
    
    func finishedWeatherWithError(data: Any?, error: NSError?) {
        
        if error != nil{
            print("Failed with error \(error!)")
        }
        
        guard let data = data else{ //Check for nil JSON
            print("Empty JSON")
            return
        }
        
        
        let json = JSON(data)
        
        let forecast = JSONParser.JSONtoWeatherModel(json: json)
        forecastsArray.append(forecast)
        if(forecastsArray.count == citiesArray.count){
            for index in 0..<citiesArray.count{
                forecastsArray[index].cityName = citiesArray[index]
            }
        weatherTableView.reloadData()
            hideHUD()
        }
    }
    
}

//Extension for hiding and showing the HUD
extension UITableViewController{
    func showHUD(_ message:String){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
    }
    
    func hideHUD(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
}

