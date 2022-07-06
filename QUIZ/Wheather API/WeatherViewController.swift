//
//  WeatherViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 23.03.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var table: UITableView!
    var models = [DailyWeatherEntry]()
    var hourlyModels = [HourlyWeatherEntry]()

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var current: CurrentWeather?

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Сегодня"
         
        // Register 2 cells
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self

        //table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        //view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }

    // Location

    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil  {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    

    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude

        let location = CLLocation(latitude: lat, longitude: long)
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            //print(city + ", " + country)  // Rio de Janeiro, Brazil
            
            let currentcity = self.defaults.set(city, forKey: "city")
            var currentcountry = self.defaults.set(country, forKey: "country")
            
           
            //print(currentcity)
            //print(currentcountry)
        }
        
        
        
        
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(lat),\(long)?exclude=[flags,minutely]"

        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in

            // Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }

            // Convert data to models/some object

            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch {
                print("error: \(error)")
            }

            guard let result = json else {
                return
            }

            let entries = result.daily.data

            self.models.append(contentsOf: entries)

            let current = result.currently
            self.current = current

            self.hourlyModels = result.hourly.data

            // Update user interface
            DispatchQueue.main.async {
                self.table.reloadData()

                self.table.tableHeaderView = self.createTableHeader()
            }

        }).resume()
    }


    func createTableHeader() -> UIView {
        
        let headerVIew = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))

        //headerVIew.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        headerVIew.isUserInteractionEnabled = true
        headerVIew.addGestureRecognizer(tap)
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/2))

        headerVIew.addSubview(locationLabel)
        headerVIew.addSubview(tempLabel)
        headerVIew.addSubview(summaryLabel)

        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center

        var city = defaults.object(forKey:"city") as? String
        let country = defaults.object(forKey: "country") as? String
        
        locationLabel.text = ("\(city ?? ""), \(country ?? "")")
        locationLabel.textColor = UIColor.white
        
       // navigationItem.title = city
        
        
        guard let currentWeather = self.current else {
            return UIView()
        }

        
        tempLabel.text = "\(currentWeather.temperature)°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        summaryLabel.text = self.current?.summary
        tempLabel.textColor = UIColor.white
        
        switch current?.summary {

        case "Clear":
            summaryLabel.text = "Ясно"
            //view.backgroundColor = UIColor(patternImage: UIImage(named: "clear.background.jpeg")!)
            //table.backgroundColor = UIColor(patternImage: UIImage(named: "clear.background.jpeg")!)
            headerVIew.backgroundColor = UIColor(patternImage: UIImage(named: "clear.background.jpeg")!)
            summaryLabel.textColor = UIColor.white
            
        case "Partly Cloudy":
            summaryLabel.text = "Переменная облачность"
            headerVIew.backgroundColor = UIColor(patternImage: UIImage(named: "cloud.background.jpeg")!)
            summaryLabel.textColor = UIColor.white
            
        case "Mostly Cloudy":
            summaryLabel.text = "В основном облачно"
            headerVIew.backgroundColor = UIColor(patternImage: UIImage(named: "cloud.background.jpeg")!)
            summaryLabel.textColor = UIColor.white
            
        case "Overcast":
            summaryLabel.text = "Пасмурно"
            headerVIew.backgroundColor = UIColor(patternImage: UIImage(named: "cloud.background.jpeg")!)
            summaryLabel.textColor = UIColor.white
        
        case "Possible Drizzle":
            summaryLabel.text = "Дождь со снегом"
            headerVIew.backgroundColor = UIColor(patternImage: UIImage(named: "rain.background.jpeg")!)
            summaryLabel.textColor = UIColor.white
            
        
         default:
            headerVIew.backgroundColor = UIColor.black
            summaryLabel.textColor = UIColor.white
            
        }
        
        
        return headerVIew
    }

    
    @objc func tapFunction() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
       }
    }

    // Table

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 1 cell that is collectiontableviewcell
            return 1
        }
        // return models count
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            //cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "clear.background.jpeg")!)
            return cell
        }

        // Continue
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: models[indexPath.row])
        //cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "clear.background.jpeg")!)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}

struct WeatherResponse: Codable {
    let latitude: Float
    let longitude: Float
    let timezone: String
    let currently: CurrentWeather?
    let hourly: HourlyWeather
    let daily: DailyWeather
    let offset: Float
}

struct CurrentWeather: Codable {
    let time: Int?
    let summary: String?
    let icon: String?
    let nearestStormDistance: Int?
    let nearestStormBearing: Int?
    //let precipIntensity: Int?
    //let precipProbability: Int?
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double
}
    
struct DailyWeather: Codable {
    let summary: String
    let icon: String
    let data: [DailyWeatherEntry]
}

struct DailyWeatherEntry: Codable {
    let time: Int
    let summary: String
    let icon: String
    let sunriseTime: Int
    let sunsetTime: Int
    let moonPhase: Double
    let precipIntensity: Float?
    let precipIntensityMax: Float?
    let precipIntensityMaxTime: Int?
    let precipProbability: Double?
    let precipType: String?
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windGustTime: Int
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let uvIndexTime: Int
    let visibility: Double
    let ozone: Double
    let temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}

struct HourlyWeather: Codable {
    let summary: String
    let icon: String
    let data: [HourlyWeatherEntry]
}

struct HourlyWeatherEntry: Codable {
    let time: Int
    let summary: String
    let icon: String
    let precipIntensity: Float?
    let precipProbability: Double?
    let precipType: String?
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
