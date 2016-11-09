//
//  ProfileProfessorViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/24/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit
import FirebaseStorage

class ProfileProfessorViewController: UIViewController {
    
    var currentProfessor: Professor? = nil
    let storage = FIRStorage.storage()
    let bucketRef = FIRStorage.storage().reference(forURL: "gs://socialboxpro.appspot.com")

    
    @IBOutlet weak var professorMainImageView: UIImageView!
    @IBOutlet weak var publicNameLabel: UILabel!
    @IBOutlet weak var mainAreaLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfessorDetails()
        // Do any additional setup after loading the view.
    }
    
    func loadProfessorDetails () {
        if currentProfessor != nil {
            
            professorMainImageView.layer.cornerRadius = professorMainImageView.frame.size.height/2
            professorMainImageView.layer.masksToBounds = true
            professorMainImageView.layer.borderWidth = 0.8
            professorMainImageView.layer.borderColor = AppColors.StrawberryColor.cgColor
            
            
            let stringId: String! = String(currentProfessor!.professorId!)
            
            let avatarRef = bucketRef.child("Professors/" + stringId + "/Avatar.jpg")
            // Download in memory with a maximum allowed size of 3MB (3 * 1024 * 1024 bytes)
            avatarRef.downloadURL { (URL, error) -> Void in
                if (error != nil) {
                    print("Error while getting Image URL: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.professorMainImageView.setImageWith(URL!)
                    }
                }
            }

            publicNameLabel.text = currentProfessor?.publicName as String?
            
            mainAreaLabel.text = "Arquitectura Empresarial"

            
        }
    }
    
    

    @IBAction func hideProfessorProfile(sender: AnyObject) {
    
        self.dismiss(animated: true) {
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
