//
//  LeaderboardViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/8/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit
import Alamofire

class LeaderboardViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let STORE_HEADERS = ["Store", "Region", "Zone", "Score"]
    var data:[[String:AnyObject]] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refreshData), forControlEvents: .ValueChanged)
        self.tableView.addSubview(self.refreshControl)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshData()
    }

    func refreshData() {
        self.refreshControl.beginRefreshing()
        let url = Constants.API_ENDPOINT + "leaderboard/" + String(AppController.instance.eventId)
        Alamofire.request(.GET, url)
            .validate()
            .responseJSON { response in
                debugPrint(response)
                
                if let JSON = response.result.value {
                    let status = JSON["status"] as! Bool
                    if status {
                        self.data = JSON["result"] as! [[String:AnyObject]]
                    } else {
                        self.showError(JSON["error"] as! String, handler: nil)
                    }
                    self.refreshControl.endRefreshing()
                }
                
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UITableView DataSource and Delegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! LeaderboardTableViewCell
        cell.isHeaderCell = true
        cell.labelText = STORE_HEADERS
        return cell
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LeaderboardTableViewCell
        self.configureCell(cell, indexPath: indexPath)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let (location, _) = self.dataAtIndexPath(indexPath)
        if let store_number = location["store_number"] as? String {
            if store_number == AppController.instance.location!["store_number"] as! String {
                cell.layer.borderColor = Theme.OrangeColor.CGColor
                cell.layer.borderWidth = 1.0
            } else {
                cell.layer.borderWidth = 0.0
            }
        }
    }
    
    func configureCell(cell:LeaderboardTableViewCell, indexPath:NSIndexPath) {
        let (location, score) = self.dataAtIndexPath(indexPath)
        
        cell.labelText = [location["store_number"] as! String, location["region"] as! String, location["zone"] as! String, String(score)]
    }
    
    func dataAtIndexPath(indexPath:NSIndexPath) -> ([String:AnyObject], Int) {
        let item = data[indexPath.row]
        let location = item["location"] as! [String:AnyObject]
        let score = item["score"] as! Int
        
        return (location, score)
    }

}
