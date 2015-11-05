//
//  RStore.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/3/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import Foundation

public enum Department: String {
    case Mens = "mens"
    case Womens = "womens"
    case Kids = "kids"
    case Misc = "misc"
}

protocol RStoreDelegate{
    func displayStores(stores:[String])
}

class RStore {
    
    var delegate:RStoreDelegate?
    
    static let sharedInstance = RStore()
    
    var selectedDepartment:Department.RawValue!
    
    var mensStores:[String] = []
    var womensStores:[String] = []
    var kidsStores:[String] = []
    var miscStores:[String] = []
    
    func resetStores() {
        mensStores = []
        womensStores = []
        kidsStores = []
        miscStores = []
    }
    
    func updateStores() {
        
        if self.delegate != nil && self.selectedDepartment != nil {
            
            switch self.selectedDepartment {
                
            case Department.Mens.rawValue: self.delegate?.displayStores(self.mensStores); break
            case Department.Womens.rawValue: self.delegate?.displayStores(self.womensStores); break
            case Department.Kids.rawValue: self.delegate?.displayStores(self.kidsStores); break
            case Department.Misc.rawValue: self.delegate?.displayStores(self.miscStores); break
            default: break
                
            }
            
        }
        
    }
    
    func retrieveStores() {
        let query = PFQuery(className: "store")
        query.findObjectsInBackgroundWithBlock {
            (results, error) -> Void in
            
            if results != nil {
                
                self.resetStores()
                
                for result in results! {
                    
                    if let departments = result["department"] as? [String], name = result["name"] as? String {
                        for dept in departments {
                            
                            switch dept {
                            case Department.Mens.rawValue: self.mensStores = self.mensStores + [name]; break
                            case Department.Womens.rawValue: self.womensStores = self.womensStores + [name]; break
                            case Department.Kids.rawValue: self.kidsStores = self.kidsStores + [name]; break
                            case Department.Misc.rawValue: self.miscStores = self.miscStores + [name]; break
                            default: break
                            }
                            
                        }
                    }
                }
            }
            
            self.updateStores()
            
        }
    }
    
}
