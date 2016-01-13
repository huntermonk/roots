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
    
    let stores = RStore.sharedInstance.allStores()
    
    class func instantiateFromStoryboard() -> StoreSelectorTableViewController {
        return UIStoryboard(name: "StoreSelector", bundle: nil).instantiateInitialViewController() as! StoreSelectorTableViewController
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! RSCenteredTableViewCell
        
        cell.title.text = stores[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let name = stores[indexPath.row]
        
        if let store = RStore.sharedInstance.parseObject(name) {
            delegate?.setSelectedStore(store)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

}
