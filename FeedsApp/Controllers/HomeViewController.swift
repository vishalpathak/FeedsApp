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
    fileprivate var pageCount: Int = 1
    let objFetch = FeedDataInfoVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        objFetch.dataReceivedDelegate = self
        getData(page: pageCount, limit: pageLimit)
    }
    
    func getData(page: Int, limit: Int){
        objFetch.fetchDataFromApi(page: page, limit: pageLimit)
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
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
//        if indexPath.row == arrayInfoList.count - 1{
//            pageCount =  pageCount + 1
//            //getData(page: pageCount, limit: pageLimit)
//        }
//    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            pageCount =  pageCount + 1
            getData(page: pageCount, limit: pageLimit)
        }
    }
}

extension HomeViewController: DataReceivedDelegate{
    func didGetDataFromAPI(rowViewModel: [FeedsInfoViewModel]?, error: String?) {
        if let error = error{
            print("Error:\(error)")
            return
        }
        
        if let rowModel = rowViewModel{
            arrayInfoList = rowModel
            //print("arrayInfoList count \(arrayInfoList.count), \(arrayInfoList)")
            DispatchQueue.main.async {
                self.tableFeedList.reloadData()
            }
        }
    }
}

