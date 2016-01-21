//
//  REvent.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/5/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import Foundation

struct DateStart {
    let day:Int
    let month:Int
    let year:Int
    
    let weekday:Int
    
    var weekdayName:String {
        get {
            switch weekday {
            case 1:
                return "Monday"
            case 2:
                return "Tuesday"
            case 3:
                return "Wednesday"
            case 4:
                return "Thursday"
            case 5:
                return "Friday"
            case 6:
                return "Saturday"
            case 7:
                return "Sunday"
            default:
                return ""
            }
        }
    }
    
    // TODO: - Make this so it appends year if it's not this year
    var formatted:String {
        get {
            
            let text = self.weekdayName + " the " + self.day.ordinal
            return text
        }
    }
    
    init(day:Int, month:Int, year:Int, weekday:Int) {
        self.day = day
        self.month = month
        self.year = year
        self.weekday = weekday
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

protocol MyREventDelegate {
    func displayMyEvents(events:[PFObject], starts:[DateStart])
}

class MyREvent {
    
    var delegate:MyREventDelegate?
    
    static let sharedInstance = MyREvent()
    
    var myEvents = [PFObject]()
    
    func retrieveMyEvents() {
        let query = PFQuery(className: "event")
        query.orderByAscending("starts")
        query.findObjectsInBackgroundWithBlock {
            (results, error) -> Void in
            if results != nil {
                self.myEvents = results!
            }
            self.updateEvents()
        }
    }
    
    func updateEvents() {
        self.delegate?.displayMyEvents(myEvents, starts: convertToDateStart(myEvents))
    }
    
    func convertToDateStart(events:[PFObject]) -> [DateStart] {
        var returnArray = [DateStart]()
        for event in events {
            print(event["starts"])
            
            if let starts = event["starts"] as? NSDate {
                let components = NSCalendar.currentCalendar().components([.Month,.Day, .Year, .Weekday], fromDate: starts)
                
                let start = DateStart(day: components.day, month: components.month, year: components.year, weekday: components.weekday)
                
                if !returnArray.contains(start) {
                    returnArray.append(start)
                }
                
                
            }
        }
        return returnArray
        
    }
    
}