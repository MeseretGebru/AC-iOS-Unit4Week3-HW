//
//  DetailedWeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class DetailedWeatherViewController: UIViewController {

    var myWeather: Weather!
    var cityName = ""
    var newPict: Favorite!
   
    lazy var weatherForcasttitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forcast for: "
        label.textAlignment = .center
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let dimageV = UIImageView()
        dimageV.contentMode = .scaleAspectFit
        return dimageV
    }()
    
    lazy var weatherDisplayLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .center
        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .left
        return label
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .left
        return label
    }()
    
    lazy var sunRiseLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .left
        return label
    }()
    lazy var sunSetLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .left
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .left
        return label
    }()
    
    lazy var precipationLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textAlignment = .left
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2.0
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subView()
        displaySubview()
        navigationItem.title = "Forecast"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveToFavorite))
        subView()
        displaySubview()
        loadData()
        subViewsConstraints()
        loadPicture()
    }
    
    func loadData(){
        weatherForcasttitleLabel.text = "The forecast for: \(self.cityName)"
        detailImageView.image = UIImage(named: myWeather.icon)
        weatherDisplayLabel.text = myWeather.weather
        highLabel.text = "Hight: \(myWeather.maxTempF) F"
        lowLabel.text = "Low: \(myWeather.minTempF )"
        let sunRise = getStringDate(ISODate: myWeather.sunriseISO, formart: "HH:mm")
        sunRiseLabel.text = "Sunrise: \(sunRise)"
        let sunSet = getStringDate(ISODate: myWeather.sunsetISO, formart: "HH:mm")
        sunSetLabel.text = "Sunset: \(sunSet)"
        windSpeedLabel.text = "Windspeed: \(myWeather.windSpeedMPH) MPH"
        precipationLabel.text = "Inches of Precipitation: \(myWeather.pressureIN)"
    }
    func getStringDate(ISODate: String, formart: String) -> String {
        let dateISO = ISO8601DateFormatter()
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = formart
        if let dateFromWeather = dateISO.date(from: ISODate) {
            let dateToCell = dateFormatted.string(from: dateFromWeather)
            return dateToCell
        }
        return "No Date"
    }
    
    func loadPicture(){
        cityName = cityName.replacingOccurrences(of: " ", with: "+")
        let url = "https://pixabay.com/api/?q=\(cityName)&image_type=photo&category=places"
        newPict = Favorite(cityName: cityName, pictureName: url)
        WeatherAPIClient.manager.getImagefromPixbay(from: url, completionHandler: {
            WeatherAPIClient.manager.getImage(from: $0.webformatURL, completionHandler: {self.detailImageView.image = $0}, errorHandler: {print($0)})
            }, errorHandler: {print($0)})
    }
    
    
    @objc func saveToFavorite(){
        FileManagerHelper.manager.addNew(newPicture: self.newPict)
        FileManagerHelper.manager.saveImage(with: newPict.cityName, image: detailImageView.image!)
        let message = UIAlertController(title: "Saved", message:"Image Saved to Favorite", preferredStyle: .alert)
        message.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        present(message, animated: true, completion: {self.navigationItem.rightBarButtonItem?.isEnabled = false})
    }
    
    func subView(){
        view.addSubview(weatherForcasttitleLabel)
        view.addSubview(detailImageView)
        view.addSubview(weatherDisplayLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(highLabel)
        stackView.addArrangedSubview(lowLabel)
        stackView.addArrangedSubview(sunRiseLabel)
        stackView.addArrangedSubview(sunSetLabel)
        stackView.addArrangedSubview(windSpeedLabel)
        stackView.addArrangedSubview(precipationLabel)
    }

    
    func displaySubview() {
        weatherForcasttitleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherDisplayLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        sunRiseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunSetLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        precipationLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func subViewsConstraints() {
        weatherForcasttitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        weatherForcasttitleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        weatherForcasttitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        detailImageView.topAnchor.constraint(equalTo: weatherForcasttitleLabel.bottomAnchor, constant: 20).isActive = true
        detailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        detailImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
        
        weatherDisplayLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 8).isActive = true
        weatherDisplayLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        weatherDisplayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: weatherDisplayLabel.bottomAnchor, constant: 30).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
