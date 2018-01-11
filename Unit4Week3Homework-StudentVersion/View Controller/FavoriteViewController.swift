//
//  FavoriteViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
        lazy var tableView: UITableView = {
            let tv = UITableView(frame: UIScreen.main.bounds)
         // bounds here is the MainView's bounds which is UIScreen.main.bounds (entire screen)
            //tv.register(PictureTableViewCell.self, forCellReuseIdentifier: "PictureCell")
            return tv
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .yellow
        
        self.view.backgroundColor = .blue
        tableView.dataSource = self
        tableView.delegate = self
    
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints =  false
        
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
