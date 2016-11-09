//
//  HubViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/15/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HubViewController: UIViewController {

    @IBOutlet weak var containerMyHubView: UIView!
    @IBOutlet weak var containerSignInView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentAdecuateViewController()
    }
    
    func presentAdecuateViewController () {
        
        containerSignInView.isHidden = true
        containerMyHubView.isHidden = true

        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil {
                
                self.containerMyHubView.isHidden = false
            } else {
                print("No User Logged In")
                self.containerSignInView.isHidden = false
            }
        })

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationViewController = segue.destination as? LoginViewController {
            destinationViewController.delegate = self
        }
        
        if let destinationViewController = segue.destination as? MyHubViewController {
            destinationViewController.delegate = self
        }
        
        
    }
    
}

extension HubViewController: LoginViewControllerDelegate {
    func userDidLoggedInFromLoginView() {
        presentAdecuateViewController()
    }
}

extension HubViewController: MyHubViewControllerDelegate {
    func userDidLoggedOutFromHubView() {
        presentAdecuateViewController()
    }
}
