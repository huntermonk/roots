//
//  EventEntryViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 1/12/16.
//  Copyright © 2016 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

class EventEntryViewController: UITableViewController {
    
    class func instantiateFromStoryboard() -> EventEntryViewController {
        return UIStoryboard(name: "EventEntry", bundle: nil).instantiateInitialViewController() as! EventEntryViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBarHidden = false
    }

}
/*
extension EventEntryViewController {
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        switch indexPath.row {
        case 0: RStore.sharedInstance.selectedDepartment = Department.Mens.rawValue; break
        case 1: RStore.sharedInstance.selectedDepartment = Department.Womens.rawValue; break
        case 2: RStore.sharedInstance.selectedDepartment = Department.Kids.rawValue; break
        case 3: RStore.sharedInstance.selectedDepartment = Department.Misc.rawValue; break
        default: RStore.sharedInstance.selectedDepartment = Department.Mens.rawValue; break
        }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RSCenteredTableViewCell
        
        let controller = StoreTableViewController.instantiateFromStoryboard()
        controller.title = cell.title.text
        self.navigationController!.pushViewController(controller, animated: true)*/
    }
    
    
}

extension EventEntryViewController {
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}*/