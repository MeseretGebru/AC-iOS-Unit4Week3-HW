//
//  ViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q  on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let cellSpacing: CGFloat = 5.0
    
    var weatherArr = [Weather]() {
        didSet{
            collectionview.reloadData()
        }
    }
    
    var cityName = ""
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forcast for: "
        label.textAlignment = .center
        return label
    }()
    

    
    lazy var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8.0
        return stackView
    }()
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        return collectionView
    }()
    
    lazy var zipCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Zip Code"
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var enterZipCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Zip Code"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zipCodeTextField.delegate = self
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        
        view.backgroundColor = .white
        collectionview.backgroundColor = .white
        navigationItem.title = "Search"
        if let zipCode = UserDefaultsHelper.manager.getLastSearch() {
            getWeatherFromOnline(from: zipCode)
        }
        
        
        subView()
        displaySubview()
        stackViewConstraints()
        collectionViewConstraints()
        zipCodeTextFieldConstraints()
        
    }

    func subView(){
       view.addSubview(rootStackView)
       rootStackView.addArrangedSubview(titleLabel)
       rootStackView.addArrangedSubview(collectionview)
       rootStackView.addArrangedSubview(zipCodeTextField)
       rootStackView.addArrangedSubview(enterZipCodeLabel)
    }
    
    func displaySubview() {
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        enterZipCodeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func stackViewConstraints(){
        rootStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        rootStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        rootStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        rootStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
    }
    
    func zipCodeTextFieldConstraints(){
        zipCodeTextField.widthAnchor.constraint(equalTo: enterZipCodeLabel.widthAnchor).isActive = true
    }
 
    
    func collectionViewConstraints(){
        collectionview.heightAnchor.constraint(equalTo: rootStackView.heightAnchor, multiplier: 0.7).isActive = true
        collectionview.widthAnchor.constraint(equalTo: rootStackView.widthAnchor).isActive = true
    }
}
extension WeatherViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let validNumbers = "0123456789"
        guard let text = textField.text else {
            return true
        }
        
        let counter = text.count + string.count - range.length
        if validNumbers.contains(string) && counter <= 5 {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let zipcode = textField.text {
            getWeatherFromOnline(from: zipcode)
            UserDefaultsHelper.manager.save(name: zipcode)
        }
        return true
        
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let weather = weatherArr[indexPath.row]
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 10
            //"yyyy-MM-dd"
            //"EEE d, yyyy"
            //"EEE d, MMM"
            cell.dateLabel.text = "\(getStringDate(ISODate: weather.dateTimeISO, formart: "yyyy-MM-dd"))"
            cell.weatherImageView.image = UIImage(named: weather.icon)
            cell.lowLabel.text = "Low: \(weather.minTempF)"
            cell.highLabel.text = "High: \(weather.maxTempF)"
            return cell
        }
        return UICollectionViewCell()
    }
}
extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weather = weatherArr[indexPath.row]
        let detailVC = DetailedWeatherViewController()
        detailVC.myWeather = weather
        detailVC.cityName = self.cityName
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK:- Functions
extension WeatherViewController {
    func getWeatherFromOnline(from zipcode: String) {
        let url = "https://api.aerisapi.com/forecasts/\(zipcode)?"
        WeatherAPIClient.manager.getWeather(from: url, completionHandler: {self.weatherArr = $0}, errorHandler: {print($0)})
        ZipCodeHelper.manager.getLocationName(from: zipcode, completionHandler: {self.titleLabel.text = "Weather Forcast for: \($0)"; self.cityName = $0}, errorHandler: {print($0)})
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
}

