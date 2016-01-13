//
//  DepartmentTableViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/3/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DepartmentTableViewController: UITableViewController {
    
    let departments = ["MENS", "WOMENS", "KIDS", "MISC"]

    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = true
        tableView.reloadData()
        RStore.sharedInstance.retrieveStores()

        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
        } catch {
            print("active error")
        }
        
        session.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "outputVolume" {
            addEvent()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBarHidden = true
    }
    
    class func instantiateFromStoryboard() -> UINavigationController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
    }
    
    func addEvent() {
        let controller = EventEntryViewController.instantiateFromStoryboard()
        controller.title = "EVENT ENTRY"
        self.navigationController!.pushViewController(controller, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //___ Equally divides the screen
        return tableView.frame.height / CGFloat(departments.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! RSCenteredTableViewCell
        cell.title.text = departments[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                
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
        self.navigationController!.pushViewController(controller, animated: true)
    }

}
