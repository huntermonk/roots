//
//  HMInt.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 1/20/16.
//  Copyright © 2016 Hunter Maximillion Monk. All rights reserved.
//

extension Int {
    
    var ordinal:String {
        
        get {
            
            if self == 0 {
                return "0"
            }
            
            switch self {
            case 11:
                return "11th"
            case 12:
                return "12th"
            case 13:
                return "13th"
            default: break
            }
            
            let characters = String(self).characters
            let lastDigit = Int(String(characters.last!))!
            
            let suffix:String
            
            switch lastDigit {
            case 0:
                suffix = "th"
            case 1:
                suffix = "st"
            case 2:
                suffix = "nd"
            case 3:
                suffix = "rd"
            case 4, 5, 6, 7, 8, 9:
                suffix = "th"
            default:
                suffix = ""
            }
            
            return "\(self)\(suffix)"
            
        }
    }
}