//
//  MyHubViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 9/4/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

protocol MyHubViewControllerDelegate {
    func userDidLoggedOutFromHubView()
}

class MyHubViewController: UIViewController {
    
    var loadingView: LoadingViewController!
    @IBOutlet weak var loadingViewContainer: UIView!
    
    var datePostViewController: HubDateViewController!
    
    var selectedIndex = 0
    var delegate: MyHubViewControllerDelegate?
    
    @IBOutlet weak var buttonsToolbar: UIToolbar!
    @IBOutlet weak var professorsButton: UIButton!
    @IBOutlet weak var areasButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var professorsContainer: UIView!
    @IBOutlet weak var areasContainer: UIView!
    @IBOutlet weak var dateContainer: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    var savedPostsList: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUIUX()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                //self.changeUserInfo()
                self.setUpUserInfo(user: user)
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    func setUpUIUX (){
        
        
        
        
        buttonsToolbar.clipsToBounds = true
    }
    
    
    func setUpUserInfo(user: FIRUser) {
        
        if let user = FIRAuth.auth()?.currentUser {
            nameLabel.text = user.displayName
            emailLabel.text = user.email
            
            if let imageURL = user.photoURL {
                profilePicImageView.setImageWith(imageURL)
                profilePicImageView.layer.cornerRadius = profilePicImageView.frame.size.height/2
                profilePicImageView.layer.masksToBounds = true
                profilePicImageView.layer.borderWidth = 0.8
                profilePicImageView.layer.borderColor = AppColors.StrawberryColor.cgColor
            }
            
            //let uid = user.uid;
        }
        
    }
    
    func changeUserInfo() {
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            let changeRequest = user.profileChangeRequest()
            
            changeRequest.displayName = "Juan David Cruz"
            changeRequest.photoURL =
                NSURL(string: "https://d1qb2nb5cznatu.cloudfront.net/users/605206-large?1405747411") as URL?
    
            changeRequest.commitChanges { error in
                if let error = error {
                    print(error)
                } else {
                    print("Profile Updated")
                    self.setUpUserInfo(user: user)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ShowLoadingViewFromHub" {
            
            loadingView = segue.destination as! LoadingViewController
            loadingView.loadingLabelText = "loading knowledge hub"
            
        } else if segue.identifier == "ShowDatePostList" {
            
            datePostViewController = segue.destination as! HubDateViewController
            datePostViewController.delegate = self
            if (FIRAuth.auth()?.currentUser) != nil {
                getSavedHub()
            }

            
        }
        
    }
    
    
    func getSavedHub() {
        
        if let user = FIRAuth.auth()?.currentUser {
            let ref = FIRDatabase.database().reference().child("users").child(user.uid).child("savedPosts")
            ref.queryOrdered(byChild: "createdAt").observe(FIRDataEventType.value, with: { (snapshot: FIRDataSnapshot) in
                
                let totalPosts: Int = Int(snapshot.childrenCount)
                var processedPosts: Int = 0
                
                for data in snapshot.children {
                    let currentPost = data as! FIRDataSnapshot
                    
                    self.getProfessorPostInfoWith(professorPostId: currentPost.value! as! String, completion: { (professorPost:ProfessorPost?, error:NSError?) in
                        if professorPost != nil {
                            self.savedPostsList.add(professorPost)
                        }
                        processedPosts = processedPosts + 1
                        
                        if processedPosts == totalPosts {
                            DispatchQueue.main.async {
                                self.loadingView.stopAnimation()
                                self.loadingViewContainer.isHidden = true
                                self.datePostViewController.showPostList(arrayPosts: self.savedPostsList)
                            }
                        }
                    })
                }
                
            })
            
        } else {
            // No user is signed in.
        }

    }
    
    
    @IBAction func changedTab(sender: AnyObject) {
        
        let selectedButton: UIButton = sender as! UIButton
        selectedIndex = selectedButton.tag
        
        if selectedIndex == HubTabs.DateTab {
            
            dateButton.setTitleColor(AppColors.StrawberryColor, for: .normal)
            areasButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            professorsButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            searchButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            animateChangeTab(hideContainer1: areasContainer, hideContainer2: professorsContainer, hideContainer3: searchContainer, showContainer: dateContainer)
            
        } else if selectedIndex == HubTabs.AreasTab {
            
            dateButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            areasButton.setTitleColor(AppColors.StrawberryColor, for: .normal)
            professorsButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            searchButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            animateChangeTab(hideContainer1: professorsContainer, hideContainer2: searchContainer, hideContainer3: dateContainer, showContainer: areasContainer)
            
        } else if selectedIndex == HubTabs.ProfessorsTab {
            
            dateButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            areasButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            professorsButton.setTitleColor(AppColors.StrawberryColor, for: .normal)
            searchButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            animateChangeTab(hideContainer1: areasContainer, hideContainer2: searchContainer, hideContainer3: dateContainer, showContainer: professorsContainer)
            
        } else if selectedIndex == HubTabs.SearchTab {
            
            dateButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            areasButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            professorsButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            searchButton.setTitleColor(AppColors.StrawberryColor, for: .normal)
            animateChangeTab(hideContainer1: areasContainer, hideContainer2: professorsContainer, hideContainer3: dateContainer, showContainer: searchContainer)
        }
    }
    
    func animateChangeTab (hideContainer1: UIView, hideContainer2: UIView, hideContainer3: UIView , showContainer: UIView) {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            hideContainer1.alpha = 0.0
            hideContainer2.alpha = 0.0
            hideContainer3.alpha = 0.0
            
        }) { (completed:Bool) in
            
            hideContainer1.isHidden = true
            hideContainer2.isHidden = true
            hideContainer3.isHidden = true
            showContainer.isHidden = false
            
            UIView.animate(withDuration: 0.2, animations: {
                
                showContainer.alpha = 1.0
                
            }) { (completed:Bool) in
                
            }
            
        }
        
    }

    
    
    
    @IBAction func logOut(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension MyHubViewController: HubDateViewControllerDelegate {
    
    func didSelectedMedia(mediaType: String, urlString: String, mediaTitle: String?) {
        
        if mediaType == SupportedMediaTypes.Video {
            
        }
        
        
    }
    
}
