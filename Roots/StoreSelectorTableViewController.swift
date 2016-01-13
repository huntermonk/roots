//
//  StoreSelectorTableViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 1/12/16.
//  Copyright © 2016 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

protocol StoreSelectorDelegate {
    func setSelectedStore(store:PFObject)
}

class StoreSelectorTableViewController: UITableViewController {
    
    var delegate:StoreSelectorDelegate?
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RStore.sharedInstance.allStores().count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }

}
