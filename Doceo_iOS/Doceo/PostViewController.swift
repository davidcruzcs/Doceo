//
//  PostViewController.swift
//  Doceo
//
//  Created by Juan David Cruz on 19/09/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit
import FirebaseStorage

class PostViewController: UIViewController {

    var currentPost: ProfessorPost? = nil
    let storage = FIRStorage.storage()
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPost()
        
        
    }
    
    func setUpUIUX () {
        
        closeButton.layer.cornerRadius = closeButton.frame.size.height/2
        closeButton.layer.masksToBounds = true
        closeButton.layer.borderWidth = 0.8
        closeButton.layer.borderColor = UIColor.white.cgColor

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        setUpUIUX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    func loadPost() {
        
        
        
    }
    
    
    
    @IBAction func hideProfessorPost(sender: AnyObject) {
        
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func downEdgePanGestureAction(_ sender: AnyObject) {
        hideProfessorPost(sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
