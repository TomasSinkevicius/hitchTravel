//
//  SearchViewController.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-06.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView!
    
    var posts = [
        Post(id: "1", author: "Tomas Sinkevicius", startDestination: "Kaunas", endDestination: "Sakiai", time: "15:30"),
        Post(id: "2", author: "Romas Sinkevicius", startDestination: "Vilnius", endDestination: "Kaunas", time: "15:30"),
        Post(id: "3", author: "Lukas Kaminskas", startDestination: "Kaunas", endDestination: "Sakiai", time: "16:30"),
        Post(id: "4", author: "Audrius Ziurgzdys", startDestination: "Kaunas", endDestination: "Sakiai", time: "16:30"),
        Post(id: "5", author: "Alanas Chokas", startDestination: "Gelgaudiskis", endDestination: "Sakiai", time: "17:30")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        view.addSubview(tableView)
        
        var layoutGuide:UILayoutGuide!
        
        layoutGuide = view.safeAreaLayoutGuide
        
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
}
