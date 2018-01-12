//
//  FavoriteViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myFavPictures = [Favorite](){
        didSet {
            tableView.reloadData()
        }
    }
   
        lazy var tableView: UITableView = {
            let tv = UITableView(frame: UIScreen.main.bounds)
         // bounds here is the MainView's bounds which is UIScreen.main.bounds (entire screen)
            tv.register(PictureTableViewCell.self, forCellReuseIdentifier: "PictureCell")
            return tv
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        self.view.backgroundColor = .blue
        tableView.dataSource = self
        tableView.delegate = self
    
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myFavPictures = FileManagerHelper.manager.getAllPictures()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavPictures.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureTableViewCell
        let selectedPicture = myFavPictures[indexPath.row]
        cell.cityImage.image = FileManagerHelper.manager.getImage(with: selectedPicture.cityName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
}
