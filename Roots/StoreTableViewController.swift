//
//  StoreTableViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/3/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {
    
    var stores:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
        tableView.reloadData()
    }
    
    class func instantiateFromStoryboard(dept:[String]) -> StoreTableViewController {
        let controller = UIStoryboard(name: "StoreTableViewController", bundle: nil).instantiateInitialViewController() as! StoreTableViewController
        controller.stores = dept
        return controller
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //___ Equally divides the screen
        
        if navigationController?.navigationBarHidden == true {
            return tableView.frame.height / CGFloat(stores.count)
        } else {
            let navigationHeight = self.navigationController!.navigationBar.frame.height
            return (tableView.frame.height - navigationHeight) / CGFloat(stores.count)
        }
        
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = stores[indexPath.row]
        
        return cell
    }

}
