//
//  WeatherCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
      let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) // also it can be fatalError("init from code not implemented")
        commoninit()
    }
    
    func commoninit(){
        addSubViews()
        displaySubViews()
        subViewConstraints()
    }
    
    func addSubViews() {
        
        addSubview(dateLabel)
        addSubview(weatherImageView)
        addSubview(lowLabel)
        addSubview(highLabel)
    }
    
    func displaySubViews() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func subViewConstraints() {
        dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        weatherImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        highLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8).isActive = true
        highLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 8).isActive = true
        lowLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
}
