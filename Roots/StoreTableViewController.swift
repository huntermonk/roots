//
//  StoreTableViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/3/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController, RStoreDelegate {
    
    @IBAction func pulledToRefresh(sender: UIRefreshControl) {
        RStore.sharedInstance.retrieveStores()
    }

    var stores:[String] = []
    var department:Department.RawValue!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        RStore.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
        RStore.sharedInstance.updateStores()
    }
    
    class func instantiateFromStoryboard() -> StoreTableViewController {
        return UIStoryboard(name: "StoreTableViewController", bundle: nil).instantiateInitialViewController() as! StoreTableViewController
    }
    
    // MARK: - RStore Delegate Methods
    
    func displayStores(argumentStores:[String]) {
        stores = argumentStores
        
        tableView.reloadData()
        if refreshControl != nil {
            refreshControl!.endRefreshing()
        }
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
            cellHeight = tableView.frame.height / CGFloat(stores.count)
        } else {
            let navigationHeight = self.navigationController!.navigationBar.frame.height
            cellHeight = (tableView.frame.height - navigationHeight) / CGFloat(stores.count)
        }
        
        if cellHeight < 44 {
            cellHeight = 44
        }
        
        return cellHeight
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = stores[indexPath.row].uppercaseString
        
        return cell
    }

}
