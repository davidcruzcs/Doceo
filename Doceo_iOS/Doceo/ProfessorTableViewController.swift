//
//  ProfessorTableViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/21/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit
import AFNetworking
import FirebaseStorage

class ProfessorTableViewController: UIViewController {
    
    var professorList = NSMutableArray()
    var selectedProfessor: Professor? = nil
    var selectedFollowButton: UIButton? = nil
    var selectedFollowSpinner: UIActivityIndicatorView? = nil
    let storage = FIRStorage.storage()
    let bucketRef = FIRStorage.storage().reference(forURL: "gs://socialboxpro.appspot.com")

    @IBOutlet weak var tableViewProfessors: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableViewProfessors.delegate = self
        tableViewProfessors.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProfessorList (arrayProfessors: NSMutableArray) {
        
        professorList = arrayProfessors
        tableViewProfessors.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProfessorInfoFromTable" {
            let professorInfoViewController: ProfileProfessorViewController = segue.destination as! ProfileProfessorViewController
            professorInfoViewController.currentProfessor = selectedProfessor
            
        }

    }
    
}

extension ProfessorTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        selectedProfessor = professorList.object(at: indexPath.row) as? Professor
        self.performSegue(withIdentifier: "ShowProfessorInfoFromTable", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professorList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellProfessorHor", for: indexPath as IndexPath)
        
        let currentProfessor: Professor = professorList.object(at: indexPath.row) as! Professor
        
        
        let imageViewProfessor: UIImageView = cell.viewWithTag(1) as! UIImageView
        imageViewProfessor.layer.cornerRadius = imageViewProfessor.frame.size.height/2
        imageViewProfessor.layer.masksToBounds = true
        imageViewProfessor.layer.borderWidth = 0.8
        imageViewProfessor.layer.borderColor = AppColors.StrawberryColor.cgColor
        
        // Create a reference to the file you want to download
        let stringId: String! = String(currentProfessor.professorId!)
        
        let avatarRef = bucketRef.child("Professors/" + stringId + "/Avatar.jpg")
        avatarRef.downloadURL { (URL, error) -> Void in
            if (error != nil) {
                print("Error while getting Image URL: \(error)")
            } else {
                DispatchQueue.main.async {
                    imageViewProfessor.setImageWith(URL!)
                    
                }
            }
        }
        
       
        
        
        let publicNameLabel: UILabel = cell.viewWithTag(2) as! UILabel
        publicNameLabel.text = currentProfessor.publicName as String?
        
        let buttonFollow:UIButton = cell.viewWithTag(4) as! UIButton
        buttonFollow.setTitle("", for: .normal)
        
        let followSpinner = cell.viewWithTag(90) as! UIActivityIndicatorView
        followSpinner.startAnimating()
        //
        //        getFollowingStatusWithId(currentProfessor._userId!) { (status, error, exception) in
        //
        //            if error == nil && exception == nil {
        //
        //                if status == FollowingStatus.Following {
        //
        //                    dispatch_async(dispatch_get_main_queue(),{
        //                        followSpinner.stopAnimation()
        //                        buttonFollow.setTitle("Unfollow", forState: .Normal)
        //                    })
        //                } else if status == FollowingStatus.NotFollowing {
        //
        //                    dispatch_async(dispatch_get_main_queue(),{
        //                        followSpinner.stopAnimation()
        //                        buttonFollow.setTitle("Follow", forState: .Normal)
        //                    })
        //                }
        //                
        //            }
        //        }
        //
        //    
        return cell
    }
  
    
    @IBAction func changeFollowStatus(sender: AnyObject) {
        
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: tableViewProfessors)
        let indexPath: NSIndexPath = tableViewProfessors.indexPathForRow(at: buttonPosition)! as NSIndexPath
        
        let cell:UITableViewCell = tableViewProfessors.cellForRow(at: indexPath as IndexPath)!
        
        selectedFollowButton = cell.viewWithTag(4) as? UIButton
        selectedFollowButton!.setTitle("", for: .normal)
        
        selectedFollowSpinner = cell.viewWithTag(90) as? UIActivityIndicatorView
        selectedFollowSpinner!.startAnimating()
        
        selectedProfessor = professorList.object(at: indexPath.row) as? Professor
        
//        getFollowingStatusWithId((selectedProfessor?._userId)!) { (status, error, exception) in
//            
//            if error == nil && exception == nil {
//                
//                if status == FollowingStatus.Following {
//                    
//                    self.unfollowProfessorWithId((self.selectedProfessor?._userId)!, completion: { (removedUserFollowingProfessor, error, exception) in
//                        
//                        if error == nil && exception == nil {
//                            dispatch_async(dispatch_get_main_queue(),{
//                                self.selectedFollowSpinner!.stopAnimation()
//                                self.selectedFollowButton!.setTitle("Follow", forState: .Normal)
//                            })
//                        }
//                        
//                    })
//                    
//                } else if status == FollowingStatus.NotFollowing {
//                    
//                    self.followProfessorWithId((self.selectedProfessor?._userId)!, completion: { (newUserFollowingProfessor, error, exception) in
//                        
//                        if error == nil && exception == nil {
//                            
//                            dispatch_async(dispatch_get_main_queue(),{
//                                self.selectedFollowSpinner!.stopAnimation()
//                                self.selectedFollowButton!.setTitle("Unfollow", forState: .Normal)
//                            })
//                        }
//                        
//                    })
//                    
//                }
//                
//            }
//        }
        
    }
    
    

}
