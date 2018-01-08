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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoninit()
    }
    
    func commoninit(){
        addSubViews()
        displaySubViews()
        subViewConstraints()
    }
    
    func addSubViews() {
        addSubview(dateLabel)
    }
    
    func displaySubViews() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func subViewConstraints() {
        dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
    }
}
