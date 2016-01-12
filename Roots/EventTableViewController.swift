//
//  EventTableViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/5/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController, REventDelegate {
    
    var events = [Dictionary<String, AnyObject>()]
    
    override func viewDidLoad() {
        REvent.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
        RStore.sharedInstance.updateStores()
    }
    
    class func instantiateFromStoryboard() -> EventTableViewController {
        return UIStoryboard(name: "EventTableViewController", bundle: nil).instantiateInitialViewController() as! EventTableViewController
    }
    
    // MARK: - REvent Delegate Methods
    
    func displayEvents(argumentEvents: [Dictionary<String, AnyObject>]) {
        events = argumentEvents
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //___ Equally divides the screen
        
        var cellHeight:CGFloat!
        
        if navigationController?.navigationBarHidden == true {
            cellHeight = tableView.frame.height / CGFloat(events.count)
        } else {
            let navigationHeight = self.navigationController!.navigationBar.frame.height
            cellHeight = (tableView.frame.height - navigationHeight) / CGFloat(events.count)
        }
        
        if cellHeight < 66 { cellHeight = 66 }
        
        if cellHeight > 198 { cellHeight = 198 }
        
        return cellHeight
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let event = events[indexPath.row]
        
        cell.textLabel?.text = event["title"] as? String
        cell.detailTextLabel?.text = event["description"] as? String
        
        return cell
    }
    


}
