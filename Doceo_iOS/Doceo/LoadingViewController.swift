//
//  LoadingViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/21/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView?
    @IBOutlet weak var loadingTextLabel: UILabel!
    var loadingLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSpinner()
        setLoadingText(text: loadingLabelText)
        // Do any additional setup after loading the view.
    }

    func setUpSpinner() {
     
        startAnimation()
        
    }
    
    func startAnimation () {
        spinner?.startAnimating()
    }
    
    func stopAnimation () {
        spinner?.stopAnimating()
    }
    
    func setLoadingText(text: String?) {
        
        if text != nil {
            loadingTextLabel.text = text!
        } else {
            loadingTextLabel.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
