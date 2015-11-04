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
    case Misc = "miscellaneous"
}

struct RStore {
    
    static let mensStores:[String] = ["GUCCI", "HERMES", "BURBERRY"]
    static let womensStores:[String] = ["NASTY GAL", "URBAN O", "FREE-PEOPLE", "B. REPUBLIC", "ZARA"]
    
    static let kidsStores:[String] = mensStores + womensStores
    
    static let miscStores:[String] = ["LOUIS VUITTON"] + kidsStores
    
}