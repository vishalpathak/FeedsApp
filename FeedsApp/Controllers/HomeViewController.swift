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
    @IBOutlet weak var labelPageNumber: UILabel!
    var activity = UIActivityIndicatorView()
    //MARK:- Data Variables
    fileprivate var arrayInfoList = [FeedsInfoViewModel]()
    fileprivate var pageCount: Int = 1
    let objFetch = FeedDataInfoVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = navigationTitle
        objFetch.dataReceivedDelegate = self
        getData(page: pageCount, limit: pageLimit)
    }
    
    //MARK:- Get Data from API
    func getData(page: Int, limit: Int){
        self.showActivityIndicator()
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 10.0 {
            pageCount =  pageCount + 1
            getData(page: pageCount, limit: pageLimit)
        }
    }
}

extension HomeViewController: DataReceivedDelegate{
    func didGetDataFromAPI(rowViewModel: [FeedsInfoViewModel]?, error: String?) {
        if let error = error{
            DispatchQueue.main.async {
                self.hideActivity()
            }
            print("Error:\(error)")
            return
        }
        if let rowModel = rowViewModel{
            arrayInfoList = rowModel
            DispatchQueue.main.async {
                self.hideActivity()
                self.labelPageNumber.text = "Page:\(self.pageCount)"
                self.tableFeedList.reloadData()
            }
        }
    }
}

//MARK:- For showing Activity Indicator
extension HomeViewController{
    func showActivityIndicator() {
        if #available(iOS 13.0, *) {
            activity = UIActivityIndicatorView(style: .large)
        } else {
            activity = UIActivityIndicatorView(style: .whiteLarge)
        }
        activity.center = view.center
        activity.color = .red
        activity.hidesWhenStopped = true
        view.addSubview(activity)
        activity.startAnimating()
    }
    
    func hideActivity() {
        activity.stopAnimating()
    }
}

