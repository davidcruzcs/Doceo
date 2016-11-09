//
//  FollowingViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/21/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit
import Firebase

class FollowingViewController: UIViewController {
    
    var loadingView: LoadingViewController!
    var professorTableView: ProfessorTableViewController!
    let professorList = NSMutableArray()
    
    

    @IBOutlet weak var loadingViewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowLoadingViewFromFollowing" {
            
            loadingView = segue.destination as! LoadingViewController
            loadingView.loadingLabelText = "loading follows"
            
        } else if segue.identifier == "ShowFollowingProfessorList" {
            
            professorTableView = segue.destination as! ProfessorTableViewController
            getAllProfessors()
        }
        
    }
    
    func getAllProfessors() {
        
        if let user = FIRAuth.auth()?.currentUser {
            let ref = FIRDatabase.database().reference().child("users").child(user.uid).child("following")
            ref.observe(FIRDataEventType.value, with: { (snapshot: FIRDataSnapshot) in
                
                let totalProfessors: Int = Int(snapshot.childrenCount)
                var processedProfessors: Int = 0
                
                for data in snapshot.children {
                    let currentProfessor = data as! FIRDataSnapshot
                   
                    self.getProfessorInfoWith(professorId: currentProfessor.value! as! String, completion: { (professor:Professor?, error:NSError?) in
                        if professor != nil {
                            self.professorList.add(professor)
                        }
                        processedProfessors = processedProfessors + 1
                        
                        if processedProfessors == totalProfessors {
                            DispatchQueue.main.async {
                                self.loadingView.stopAnimation()
                                self.loadingViewContainer.isHidden = true
                                
                                self.professorTableView.showProfessorList(arrayProfessors: self.professorList)
                            }
                        }
                    })
                }
                
            })
            
        } else {
            // No user is signed in.
        }
        
    }
    
    
   
    
    
    
}

