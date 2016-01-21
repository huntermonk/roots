//
//  MyStoreTableViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 1/20/16.
//  Copyright © 2016 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

struct DateStart {
    let day:Int
    let month:Int
    let year:Int
    
    init(day:Int, month:Int, year:Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
}

extension DateStart: Equatable {}

func ==(lhs:DateStart, rhs:DateStart) -> Bool {
    
    if lhs.day != rhs.day {
        return false
    }
    
    if lhs.month != rhs.month {
        return false
    }
    
    if lhs.year != rhs.year {
        return false
    }
    
    return true
    
}

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
        return "Day \(date.day) of Month \(date.month)"
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let event = events[indexPath.row]
        
        cell.textLabel?.text = event["title"] as? String
        cell.detailTextLabel?.text = event["description"] as? String
        
        return cell
    }
    
    func convertToDateStart(events:[PFObject]) -> [DateStart] {
        var returnArray = [DateStart]()
        for event in events {
            print(event["starts"])
            if let start = event["starts"] as? NSDate {
                let components = NSCalendar.currentCalendar().components([NSCalendarUnit.Month,NSCalendarUnit.Day, NSCalendarUnit.Year], fromDate: start)

                let start = DateStart(day: components.day, month: components.month, year: components.year)
                
                if !returnArray.contains(start) {
                    print("doesn't")
                    returnArray.append(start)
                }
                
                
            }
        }
        return returnArray
        
    }

}

extension MyStoreTableViewController: MyREventDelegate {
    
    func displayMyEvents(events:[PFObject]) {
        self.events = events
        dateStarts = convertToDateStart(events)
        tableView.reloadData()
        
    }
}
