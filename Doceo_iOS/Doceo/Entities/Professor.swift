//
//  Professor.swift
//  Doceo
//
//  Created by Juan David Cruz on 14/09/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import Foundation

class Professor: NSObject {
    
    var professorId: NSString?
    var profilePicUrl: NSString?
    var publicName: NSString?
    
    override init () {
        super.init()
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        
        professorId = dictionary["professorId"] as? NSString
        profilePicUrl = dictionary["profilePicUrl"] as? NSString
        publicName = dictionary["publicName"] as? NSString
        
    }
    
}
