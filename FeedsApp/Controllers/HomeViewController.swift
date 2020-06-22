//
//  ViewController.swift
//  FeedsApp
//
//  Created by Vishal on 20/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableFeedList: UITableView!
    fileprivate var arrayInfoList = [FeedsInfoViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableFeedList.dequeueReusableCell(withIdentifier: CellIdentifier.feedsCell) as! FeedTableViewCell
        let obj = arrayInfoList[indexPath.row]
        cell.dataInfoModel = obj
        return cell
    }
    
    
}

