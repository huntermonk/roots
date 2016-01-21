//
//  MyStoreTableViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 1/20/16.
//  Copyright © 2016 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

class MyStoreTableViewController: UITableViewController {

    var events = [PFObject]()
    
    var dateStarts = [DateStart]()
    
    override func viewDidLoad() {
        MyREvent.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
        MyREvent.sharedInstance.retrieveMyEvents()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dateStarts.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = dateStarts[section]
        return date.formatted
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let event = events[indexPath.row]
        
        cell.textLabel?.text = event["title"] as? String
        cell.detailTextLabel?.text = event["description"] as? String
        
        return cell
    }
    
    

}

extension MyStoreTableViewController: MyREventDelegate {
    
    func displayMyEvents(events:[PFObject], starts:[DateStart]) {
        self.events = events
        dateStarts = starts
        tableView.reloadData()
        
    }
}
