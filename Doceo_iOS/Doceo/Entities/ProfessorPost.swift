//
//  ProfessorPost.swift
//  Doceo
//
//  Created by Juan David Cruz on 14/09/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import Foundation

class ProfessorPost: NSObject {
    var professorId: NSString?
    var postId: NSString?
    var createdAt: NSString?
    var postDescription: NSString?
    var postKeywords: NSArray?
    var postMedia: NSDictionary?
    var postTitle: NSString?
    
    override init () {
        super.init()
    }
    
    convenience init(_ dictionary: Dictionary<NSString, AnyObject>) {
        self.init()
        
        professorId = dictionary["professorId"] as? NSString
        postId = dictionary["postId"] as? NSString
        createdAt = dictionary["createdAt"] as? NSString
        postDescription = dictionary["postDescription"] as? NSString
        postKeywords = dictionary["postKeywords"] as? NSArray
        postMedia = dictionary["postMedia"] as? NSDictionary
        postTitle = dictionary["postTitle"] as? NSString 
        
    }
    
}
