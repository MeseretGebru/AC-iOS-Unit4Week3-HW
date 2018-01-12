//
//  PictureTableViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PictureTableViewCell: UITableViewCell {
    
    lazy var cityImage: UIImageView = {
        let cityImage = UIImageView()
        cityImage.contentMode = .scaleAspectFill
        return cityImage
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupCityView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCityView() {
        contentView.addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        cityImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cityImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cityImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cityImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
}
