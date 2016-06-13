//
//  EvaluationViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/1/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit
import Alamofire

class EvaluationViewController: ScenarioExplanationViewController, UITableViewDelegate, UITableViewDataSource, UIToggleButtonGroupDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIShadowedButton!
    var responseData:EvaluationResponseData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let evaluationQuestions = self.step.questions![0]["items"] as! [String]
        let participationQuestions = self.step.questions![1]["items"] as! [String]
        responseData = EvaluationResponseData(evaluationResponseCount: evaluationQuestions.count, participationResponseCount: participationQuestions.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var nextButton: UIButton? {
        get {
            return self.submitButton
        }
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
    
    
    override func next(sender:AnyObject) {
        
        let params:[String:AnyObject] = [
            "event_id":AppController.instance.eventId,
            "username":AppController.instance.location!["store_number"]!,
            "challenge_id":self.step.backendUUID!,
            "response_data":self.responseData.asDictionary()
        ]
        
        
        Alamofire.request(.POST, Constants.API_ENDPOINT + "postChallengeResult", parameters:params, encoding: .JSON)
            .validate()
            .responseJSON { response in
                debugPrint(response)
                
                if let JSON = response.result.value {
                    let status = JSON["status"] as! Bool
                    if status {
                        super.next(sender) // Let the super class move us on
                    } else {
                        self.showError(JSON["error"] as! String, handler: nil)
                    }
                }
                
        }
    }
    
    
    // MARK: - UITableView DataSource and Delegate
    
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
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.whiteColor()
        } else {
            cell.backgroundColor = Theme.AlternateRowColor
        }
    }
    
    func configureCell(cell:QuestionTableViewCell, indexPath:NSIndexPath) {
        let obj = self.step.questions![indexPath.section]
        let items = obj["items"] as! [String]
        cell.question = items[indexPath.row]
        cell.toggleButtonGroup.delegate = self
        
        if indexPath.section == 0 {
            cell.toggleButtonGroup.selectedIndex = self.responseData.evaluationResponses[indexPath.row] - 1
        } else {
            cell.toggleButtonGroup.selectedIndex = self.responseData.participationResponses[indexPath.row] - 1
        }
    }
    
    func buttonGroup(group: UIToggleButtonGroup, didSelectIndex newIndex: Int, previousIndex: Int) {
        
        // Get index path of row with tapped button
        let center:CGPoint = group.center
        let rootViewPoint:CGPoint = group.superview!.convertPoint(center, toView: self.tableView)
        let indexPath:NSIndexPath = self.tableView.indexPathForRowAtPoint(rootViewPoint)!

        if indexPath.section == 0 {
            self.responseData.evaluationResponses[indexPath.row] = newIndex + 1
        } else {
            self.responseData.participationResponses[indexPath.row] = newIndex + 1
        }
        
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
    }
    
}
