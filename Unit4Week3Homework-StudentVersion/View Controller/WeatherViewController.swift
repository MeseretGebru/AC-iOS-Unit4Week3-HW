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
        collectionView.backgroundColor = .yellow
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
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zipCodeTextField.delegate = self
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        view.backgroundColor = .orange
        navigationItem.title = "Search"
        subView()
        displaySubview()
        StackViewConstraints()
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
    
    func StackViewConstraints(){
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
        let counter = text.count + string.count
        if validNumbers.contains(string) && counter <= 5 {
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //TODO:-
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
        return 7 // self.weatherDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let weather = self.weatherDays[indexPath.row]
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? WeatherCVCell {
//            let dateFormatterGet = ISO8601DateFormatter()
//            let dateFormatterPrint = DateFormatter()
//            dateFormatterPrint.dateFormat = "EEEE, d"
//            let date = dateFormatterGet.date(from: weather.dateTimeISO)
//            var stringFromDate = dateFormatterPrint.string(from: date!)
//            if stringFromDate == dateFormatterPrint.string(from: Date()) {
//                stringFromDate = "Today"
//            }
//            cell.dateLabel.text = "\(stringFromDate)"
//            cell.weatherImageView.image = UIImage(named: weather.icon)
//            cell.highLabel.text = "High: \(weather.maxTempF)ºF"
//            cell.lowLabel.text = "Low: \(weather.minTempF)ºF"
//            return cell
//        }
        //return UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
        cell.backgroundColor = .orange
         cell.dateLabel.text = "\(Date())"
        return cell
        }
        return UICollectionViewCell()
    }
}
extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailedWeatherViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

