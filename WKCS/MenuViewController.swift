//
//  MenuViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/3/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func itemSelected(controller:MenuViewController, menuItem:Step)
}


class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var delegate:MenuViewControllerDelegate?
    lazy var menuItems:[Step] = {
        [unowned self] in
        
        var tempMenuItems = [Step]()
        for step in FlowController.instance.steps {
            if step.menuTitle != nil {
                tempMenuItems.append(step)
            }
        }
        
        return tempMenuItems
    }()
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = UIView()
        
        self.view.layer.masksToBounds = false
        
        self.view.layer.shadowColor = UIColor.blackColor().CGColor
        self.view.layer.shadowOpacity = 0.8
        self.view.layer.shadowRadius = 5
        self.view.layer.shadowOffset = CGSizeMake(1.0, 1.0)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuTableViewCell
        
        let menuItem:Step = menuItems[indexPath.row]
        
        cell.menuText = menuItem.menuTitle
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let delegate = self.delegate {
            let menuItem = menuItems[indexPath.row]
            delegate.itemSelected(self, menuItem: menuItem)
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }


}
