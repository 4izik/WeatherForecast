//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Анастасия Чупова on 24.07.2021.
//

import UIKit

class ViewController: UIViewController {
    var lat:Double?
    var lon:Double?
    var weather:WeatherAPI?
    @IBOutlet weak var backView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let lm=LocationManager.shared
        lm.requestAccess { isSucces in
            if isSucces {
                lm.getLocation { [self] location in
                    lat=location?.latitude
                    lon=location?.longitude
                    WeatherLoader().loaderWeather(lat: lat!, lon: lon!, completion: {weather in
                        self.weather=weather
                        print(weather.hourly.count)
                        self.setup()})
    
                }
            }
        }
        
    }

    func setup() {
        let scrollView=UIScrollView()
        scrollView.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1500)
        backView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints=false
        let topAnchor = scrollView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0)
        let bottomAnchor = scrollView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0)
        let leftAnchor = scrollView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 0)
        let rightAnchor = scrollView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: 0)
        NSLayoutConstraint.activate([topAnchor, bottomAnchor, leftAnchor, rightAnchor])
        
        let backImageView=UIImageView()
        backImageView.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        backImageView.image=UIImage(named: "back")
        scrollView.addSubview(backImageView)
        
        let currentView=UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        currentView.alpha=1
        scrollView.addSubview(currentView)
        
        let nameTownLabel=UILabel(frame: CGRect(x: currentView.layer.bounds.width/2-150, y: currentView.layer.bounds.height/4, width: 300, height: 20))
        nameTownLabel.font=nameTownLabel.font.withSize(20)
        nameTownLabel.textColor=UIColor.white
        nameTownLabel.text=weather?.timezone
        nameTownLabel.textAlignment = .center
        nameTownLabel.font = UIFont.boldSystemFont(ofSize: nameTownLabel.font.pointSize)
        currentView.addSubview(nameTownLabel)
    
        
        let tempCurrentLabel=UILabel(frame: CGRect(x: currentView.layer.bounds.width/2-100, y: currentView.layer.bounds.height/2, width: 200, height: 40))
        tempCurrentLabel.font=tempCurrentLabel.font.withSize(55)
        tempCurrentLabel.textColor=UIColor.white
        tempCurrentLabel.text="\(Int(weather?.current.temp ?? 0))°"
        tempCurrentLabel.textAlignment = .center
        tempCurrentLabel.font = UIFont.boldSystemFont(ofSize: tempCurrentLabel.font.pointSize)
        currentView.addSubview(tempCurrentLabel)
        
        let mainLabel=UILabel(frame: CGRect(x: currentView.layer.bounds.width/2-100, y: currentView.layer.bounds.height/3, width: 200, height: 20))
        mainLabel.font=tempCurrentLabel.font.withSize(18)
        mainLabel.textColor=UIColor.white
        mainLabel.text=weather?.current.weather[0].main
        mainLabel.textAlignment = .center
        mainLabel.font = UIFont.boldSystemFont(ofSize: mainLabel.font.pointSize)
        currentView.addSubview(mainLabel)
        
        let maxMinTempLabel=UILabel(frame: CGRect(x: currentView.layer.bounds.width/2-100, y: currentView.layer.bounds.height/2+50, width: 200, height: 20))
        maxMinTempLabel.font=tempCurrentLabel.font.withSize(15)
        maxMinTempLabel.textColor=UIColor.white
        maxMinTempLabel.text="Max \(Int((weather?.daily[0].temp.max)!))°," + " min \(Int((weather?.daily[0].temp.min)!))°"
        maxMinTempLabel.textAlignment = .center
        currentView.addSubview(maxMinTempLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView=UICollectionView(frame: CGRect(x: 0, y: currentView.layer.bounds.height-65, width: UIScreen.main.bounds.width, height: 60), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .none
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.white.cgColor
        collectionView.register(HourWeatherCell.self, forCellWithReuseIdentifier: "HourWeatherCell")
        backView.addSubview(collectionView)
        
        let tableView=UITableView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
        tableView.backgroundColor = .clear
        tableView.delegate=self
        tableView.dataSource=self
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: "DailyWeatherCell")
        tableView.tableFooterView = UIView()
        scrollView.addSubview(tableView)
        
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyWeatherCell
        let epochTime = weather?.daily[indexPath.row+1].dt
        let newTime = Date(timeIntervalSince1970: TimeInterval(epochTime!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        let dateObj = dateFormatter.date(from: "\(newTime)")
        dateFormatter.dateFormat = "dd.MM"
        cell.dataLabel.text="\(dateFormatter.string(from: dateObj!))"
        cell.backgroundColor = .clear
        switch (weather?.daily[indexPath.row+1].weather[0].id)! {
        case 200...235:
            cell.mainImageView.image=UIImage(named: "thunderstorm")
        case 300...322:
            cell.mainImageView.image=UIImage(named: "drizzle")
        case 500...504:
            cell.mainImageView.image=UIImage(named: "rain")
        case 511:
            cell.mainImageView.image=UIImage(named: "rain511")
        case 520...531:
            cell.mainImageView.image=UIImage(named: "rain520")
        case 600...622:
            cell.mainImageView.image=UIImage(named: "snow")
        case 701...781:
            cell.mainImageView.image=UIImage(named: "atmosphere")
        case 800:
            cell.mainImageView.image=UIImage(named: "clear")
        case 801:
            cell.mainImageView.image=UIImage(named: "801")
        case 802:
            cell.mainImageView.image=UIImage(named: "802")
        case 803:
            cell.mainImageView.image=UIImage(named: "803")
        case 804:
            cell.mainImageView.image=UIImage(named: "804")
        default:
            break
        }
        
        cell.dayTempLabel.text="\(Int((weather?.daily[indexPath.row+1].temp.day)!))"
        cell.nightTempLabel.text="\(Int((weather?.daily[indexPath.row+1].temp.night)!))"
        if weather?.daily[indexPath.row+1].pop==0 {cell.popLabel.text=""}
        else {
            cell.popLabel.text="\(Int((weather?.daily[indexPath.row+1].pop)!*100))%"
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 48
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourWeatherCell", for: indexPath) as! HourWeatherCell
        let epochTime = weather?.hourly[indexPath.row].dt
        let newTime = Date(timeIntervalSince1970: TimeInterval(epochTime!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        let dateObj = dateFormatter.date(from: "\(newTime)")
        dateFormatter.dateFormat = "HH:mm"
        cell.tempLabel.text="\(Int((weather?.hourly[indexPath.row].temp)!)) °"
        cell.textlabel.text="\(dateFormatter.string(from: dateObj!))"
        switch (weather?.hourly[indexPath.row].weather[0].id)! {
        case 200...235:
            cell.imageView.image=UIImage(named: "thunderstorm")
        case 300...322:
            cell.imageView.image=UIImage(named: "drizzle")
        case 500...504:
            cell.imageView.image=UIImage(named: "rain")
        case 511:
            cell.imageView.image=UIImage(named: "rain511")
        case 520...531:
            cell.imageView.image=UIImage(named: "rain520")
        case 600...622:
            cell.imageView.image=UIImage(named: "snow")
        case 701...781:
            cell.imageView.image=UIImage(named: "atmosphere")
        case 800:
            cell.imageView.image=UIImage(named: "clear")
        case 801:
            cell.imageView.image=UIImage(named: "801")
        case 802:
            cell.imageView.image=UIImage(named: "802")
        case 803:
            cell.imageView.image=UIImage(named: "803")
        case 804:
            cell.imageView.image=UIImage(named: "804")
        default:
            break
        }
        
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height:60)
    }
    
}

