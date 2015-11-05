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
    
    override func viewDidLoad() {
        RStore.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = false
        
        updateStores()
    }
    
    func setStoresDepartment() {
        
        switch department {
        case Department.Mens.rawValue: stores = RStore.sharedInstance.mensStores; break
        case Department.Womens.rawValue: stores = RStore.sharedInstance.womensStores; break
        case Department.Kids.rawValue: stores = RStore.sharedInstance.kidsStores; break
        case Department.Misc.rawValue: stores = RStore.sharedInstance.miscStores; break
        default: break
        }
        
    }
    
    class func instantiateFromStoryboard(dept:String) -> StoreTableViewController {
        let controller = UIStoryboard(name: "StoreTableViewController", bundle: nil).instantiateInitialViewController() as! StoreTableViewController
        controller.department = dept
        return controller
    }
    
    // MARK: - RStore Delegate Methods
    
    func updateStores() {
        setStoresDepartment()
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
