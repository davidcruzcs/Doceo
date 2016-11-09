//
//  GlobalMethods.swift
//  Doceo
//
//  Created by Juan David Cruz on 18/09/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//
import UIKit
import Foundation
import Firebase

class GlobalMethods: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    
}

extension UIViewController {
    
   
    /*
     // MARK: - Professor Methods
     */
    
    func createProfessorWith(professorInfo: [String: AnyObject], completion: @escaping (_ resultProfessor:Professor?, _ error: NSError?) -> Void) {
        
        
        let ref = FIRDatabase.database().reference()
        let key = ref.child("professors").childByAutoId().key
        
        let professorDict: NSDictionary = NSDictionary(objects: [key,ProfessorDefaults.AvatarUrl,professorInfo["publicName"]], forKeys: ["professorId" as NSCopying,"profilePicUrl" as NSCopying,"publicName" as NSCopying])
        let newProfessor: Professor = Professor.init(professorDict as! Dictionary<String, AnyObject>)
        print(newProfessor)
        
        let professor = ["professorId": newProfessor.professorId! as NSString,
                    "profilePicUrl": newProfessor.profilePicUrl! as NSString,
                    "publicName": "Juan Teacher"]
        let childUpdates = ["/professors/\(key)": professor]

        ref.updateChildValues(childUpdates) { (error:Error?, ref:FIRDatabaseReference) in
            if (error == nil) {
                completion(newProfessor, nil)
            } else {
                completion(nil, error as NSError?)
            }
        }
        
    }
    
    func getProfessorsFollowedBy(userId: String, completion: @escaping (_ response:String?, _ error: NSError?) -> Void) {
        let ref = FIRDatabase.database().reference()
        let userRef = ref.child("users").child(userId)
        let followingProfessorsRef = userRef.child("following")
        
        followingProfessorsRef.observeSingleEvent(of: FIRDataEventType.value) { (snapshot: FIRDataSnapshot) in
            print(snapshot)
            completion("qwe", nil)
            
        }
    }
    
    func getProfessorInfoWith(professorId: String, completion: @escaping (_ professor:Professor?, _ error: NSError?) -> Void) {
        let ref = FIRDatabase.database().reference()
        let professorRef = ref.child("professors").child(professorId)
        
        professorRef.observeSingleEvent(of: FIRDataEventType.value) { (snapshot:FIRDataSnapshot) in
            if snapshot.value != nil {
                
                let professorDict: NSDictionary = snapshot.value! as! NSDictionary
                
                let newProfessor: Professor = Professor()
                newProfessor.professorId = professorDict.object(forKey: "professorId") as! NSString?
                newProfessor.profilePicUrl = professorDict.object(forKey: "profilePicUrl") as! NSString?
                newProfessor.publicName = professorDict.object(forKey: "publicName") as! NSString?
                completion(newProfessor,nil)
            }
        }
        
        
    }
    
}

extension UIViewController {
    /*
    // MARK: - ProfessorPost Methods
    */
    
    func createProfessorPost(professorPostInfo:[NSString: AnyObject],professorId: String, completion: @escaping (_ resultProfessorPost:ProfessorPost?, _ error: NSError?) -> Void) {
        
        let ref = FIRDatabase.database().reference()
        let key = ref.child("professorPosts").childByAutoId().key
        
        let professorPostDict: NSDictionary = NSDictionary(objects: [professorId,key, professorPostInfo["postTitle"] as! NSString, professorPostInfo["postDescription"] as! NSString, professorPostInfo["createdAt"] as! NSString, professorPostInfo["postKeywords"] as! NSArray, professorPostInfo["postMedia"] as! NSDictionary], forKeys: ["professorId" as NSCopying,"postId" as NSCopying,"postTitle" as NSCopying, "postDescription" as NSCopying, "createdAt" as NSCopying, "postKeywords" as NSCopying, "postMedia" as NSCopying])
        
        let newProfessorPost: ProfessorPost = ProfessorPost.init(professorPostDict as! Dictionary<NSString, AnyObject>)
  
        
        let professorPost = ["professorId": newProfessorPost.professorId! as NSString,
                         "postId": newProfessorPost.postId! as NSString,
                         "postTitle": newProfessorPost.postTitle! as NSString,
                         "postDescription": newProfessorPost.postDescription! as NSString,
                         "createdAt": newProfessorPost.createdAt! as NSString,
                         "postKeywords": newProfessorPost.postKeywords! as NSArray,
                         "postMedia": newProfessorPost.postMedia! as NSDictionary]
        let childUpdates = ["/professorPosts/\(key)": professorPost]
        
        ref.updateChildValues(childUpdates) { (error:Error?, ref:FIRDatabaseReference) in
            if (error == nil) {
                completion(newProfessorPost, nil)
            } else {
                completion(nil, error as NSError?)
            }
        }
        

        
    }
    
}

extension UIViewController {
    
    func getUserSavedPosts(userId: String, completition: @escaping (_ arrayPosts: NSArray?, _ error: NSError?) -> Void) {
        
        let ref = FIRDatabase.database().reference()
        let userRef = ref.child("users").child(userId)
        let savedPostsRef = userRef.child("savedPosts")
        
        savedPostsRef.observeSingleEvent(of: FIRDataEventType.value) { (snapshot: FIRDataSnapshot) in
            print(snapshot)
            completition(NSArray(), nil)
            
        }
        
    }
    
    
    func getProfessorPostInfoWith(professorPostId: String, completion: @escaping (_ professorPost:ProfessorPost?, _ error: NSError?) -> Void) {
        let ref = FIRDatabase.database().reference()
        let professorPostRef = ref.child("professorPosts").child(professorPostId)
        
        professorPostRef.observeSingleEvent(of: FIRDataEventType.value) { (snapshot:FIRDataSnapshot) in
            if snapshot.value != nil {
                
                let professorPostDict: NSDictionary = snapshot.value! as! NSDictionary
                
                let newProfessorPost: ProfessorPost = ProfessorPost()
                
                newProfessorPost.postId = professorPostDict.object(forKey: "postId") as! NSString?
                newProfessorPost.professorId = professorPostDict.object(forKey: "professorId") as! NSString?
                newProfessorPost.postTitle = professorPostDict.object(forKey: "postTitle") as! NSString?
                newProfessorPost.postDescription = professorPostDict.object(forKey: "postDescription") as! NSString?
                newProfessorPost.createdAt = professorPostDict.object(forKey: "createdAt") as! NSString?
                newProfessorPost.postKeywords = professorPostDict.object(forKey: "postKeywords") as! NSArray?
                newProfessorPost.postMedia = professorPostDict.object(forKey: "postMedia") as! NSDictionary?
                
                completion(newProfessorPost,nil)
            }
        }
        
        
    }
    
}
