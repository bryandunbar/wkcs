//
//  EvaluationViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/1/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class EvaluationViewController: ScenarioExplanationViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func configureView() {
        super.configureView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! QuestionHeaderTableViewCell
        cell.title = self.tableView(tableView, titleForHeaderInSection: section)
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as! QuestionTableViewCell
        self.configureCell(cell, indexPath: indexPath)
        return cell
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let obj = self.step.questions![section]
        return obj["title"] as? String
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let obj = self.step.questions![section]["items"] as? [String] {
            return obj.count
        }
        
        return 0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let obj = self.step.questions {
            return obj.count
        }
        
        return 0
        
    }
    
    func configureCell(cell:QuestionTableViewCell, indexPath:NSIndexPath) {
        let obj = self.step.questions![indexPath.section]
        let items = obj["items"] as! [String]
        cell.question = items[indexPath.row]
        
    }
    
}
