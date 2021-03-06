//
//  REvent.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/5/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import Foundation

protocol REventDelegate{
    func displayEvents(events:[Dictionary<String,AnyObject>])
}

class REvent {
    
    var delegate:REventDelegate?
    
    static let sharedInstance = REvent()
    
    var events = [Dictionary<String,AnyObject>]()
    
    func retrieveEvents(store:PFObject) {
        let query = PFQuery(className: "event").whereKey("store", equalTo: store)
        query.findObjectsInBackgroundWithBlock {
            (results, error) -> Void in
            if results != nil {
                self.events = []
                for result in results! {
                    
                    let event = ["title" : result["title"], "description" : result["description"], "starts" : result["starts"], "ends" : result["ends"]]
                    self.events.append(event)

                }
            }
            self.updateEvents()
        }
    }
    
    func updateEvents() {
        if self.delegate != nil {
            self.delegate?.displayEvents(events)
        }
    }

}