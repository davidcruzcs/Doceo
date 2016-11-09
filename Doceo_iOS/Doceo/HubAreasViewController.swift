//
//  HubAreasViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 9/4/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit

class HubAreasViewController: UIViewController {
    
    
    @IBOutlet weak var hubCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHubCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setUpHubCollectionView() {
        
        hubCollectionView.delegate = self
        hubCollectionView.dataSource = self
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

//SHORTCODE: Need to finish this


extension HubAreasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hubCollectionView.dequeueReusableCell(withReuseIdentifier: "CellMiniPost", for: indexPath as IndexPath)
        
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if (indexPath.section == 0) {
                
                let profileView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CellProfileHeader", for: indexPath as IndexPath)
                
                return profileView
                
            } else {
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CellProfileHeader", for: indexPath as IndexPath)
                
                return headerView
                
            }
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CellFooter", for: indexPath as IndexPath)
            if (indexPath.section != hubCollectionView.numberOfSections - 1) {
                footerView.frame = CGRect(x: footerView.frame.origin.x, y: footerView.frame.origin.y,width: footerView.frame.size.width,height: 0)
            }
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    
}
