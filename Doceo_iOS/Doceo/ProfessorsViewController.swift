//
//  ProfessorsViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/15/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit


class ProfessorsViewController: UIViewController {
    
    var selectedIndex = 0

    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var discoverButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var followingContainer: UIView!
    @IBOutlet weak var discoverContainer: UIView!
    @IBOutlet weak var searchContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changedTab(sender: AnyObject) {
        
        let selectedButton: UIButton = sender as! UIButton
        selectedIndex = selectedButton.tag
        
        if selectedIndex == ProfessorTabs.FollowingTab {
            
            followingButton.setTitleColor(AppColors.StrawberryColor, for: .normal)
            discoverButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            searchButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            animateChangeTab(hideContainer1: discoverContainer, hideContainer2: searchContainer, showContainer: followingContainer)
            
        } else if selectedIndex == ProfessorTabs.DiscoverTab {
            
            followingButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            discoverButton.setTitleColor(AppColors.StrawberryColor, for: .normal)
            searchButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            animateChangeTab(hideContainer1: followingContainer, hideContainer2: searchContainer, showContainer: discoverContainer)
            
        } else if selectedIndex == ProfessorTabs.SearchTab {
            
            followingButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            discoverButton.setTitleColor(ProfessorTabs.OffColor, for: .normal)
            searchButton.setTitleColor(AppColors.StrawberryColor, for: .normal)
            animateChangeTab(hideContainer1: followingContainer, hideContainer2: discoverContainer, showContainer: searchContainer)
        }
    }
    
    func animateChangeTab (hideContainer1: UIView, hideContainer2: UIView, showContainer: UIView) {
    
        UIView.animate(withDuration: 0.2, animations: {
            
            hideContainer1.alpha = 0.0
            hideContainer2.alpha = 0.0
            
        }) { (completed:Bool) in
            
            hideContainer1.isHidden = true
            hideContainer2.isHidden = true
            showContainer.isHidden = false
            
            UIView.animate(withDuration: 0.2, animations: {
                
                showContainer.alpha = 1.0
                
            }) { (completed:Bool) in
                
            }
            
        }
        
    }


}
