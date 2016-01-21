//
//  REvent.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/5/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import Foundation

protocol MyREventDelegate {
    func displayMyEvents(events:[PFObject])
}

class MyREvent {
    
    var delegate:MyREventDelegate?
    
    static let sharedInstance = MyREvent()
    
    var myEvents = [PFObject]()
    
    func retrieveMyEvents() {
        let query = PFQuery(className: "event")
        query.orderByDescending("starts")
        query.findObjectsInBackgroundWithBlock {
            (results, error) -> Void in
            if results != nil {
                self.myEvents = results!
            }
            self.updateEvents()
        }
    }
    
    func retrieveEvents(store:PFObject) {
        let query = PFQuery(className: "event").whereKey("store", equalTo: store)
        query.findObjectsInBackgroundWithBlock {
            (results, error) -> Void in
            if results != nil {
                self.myEvents = results!
            }
            self.updateEvents()
        }
    }
    
    func updateEvents() {
        print(myEvents.count)
        self.delegate?.displayMyEvents(myEvents)
    }
    
}