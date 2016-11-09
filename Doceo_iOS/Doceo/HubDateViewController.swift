//
//  HubDateViewController.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 9/4/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import UIKit


protocol HubDateViewControllerDelegate {
    func didSelectedMedia(mediaType: String, urlString: String, mediaTitle: String?)
    
}

class HubDateViewController: UIViewController {
    
    var delegate: HubDateViewControllerDelegate?
    
    

    @IBOutlet weak var hubCollectionView: UICollectionView!
    var postList: NSMutableArray = NSMutableArray()
    var selectedPost: ProfessorPost? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpHubCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setUpHubCollectionView() {
        
        hubCollectionView.delegate = self
        hubCollectionView.dataSource = self
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout = hubCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.bounds.width - 42, height: 80)
        layout.minimumLineSpacing = 20.0
        layout.scrollDirection = .vertical
        
        hubCollectionView.setCollectionViewLayout(layout, animated: false)
        
        hubCollectionView.reloadData()
        
    }
    
    func showPostList (arrayPosts: NSMutableArray) {
        
        postList = arrayPosts
        hubCollectionView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowPostFromDate" {
            
            let professorPostViewController: PostViewController = segue.destination as! PostViewController
            professorPostViewController.currentPost = selectedPost
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}




extension HubDateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedPost = postList.object(at: indexPath.row) as? ProfessorPost
        self.performSegue(withIdentifier: "ShowPostFromDate", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = hubCollectionView.dequeueReusableCell(withReuseIdentifier: "CellMiniPost", for: indexPath as IndexPath)
        cell.contentView.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.08).cgColor
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.cornerRadius = 10.0
        
        let currentPost: ProfessorPost = postList.object(at: indexPath.item) as! ProfessorPost
        
        let postTitleLabel: UILabel = cell.viewWithTag(1)! as! UILabel
        postTitleLabel.text = currentPost.postTitle as String?
        
        let postDescriptionView: UITextView = cell.viewWithTag(2)! as! UITextView
        postDescriptionView.text = currentPost.postDescription as String!
        postDescriptionView.textColor = UIColor.lightGray
        
        let authorImageView: UIImageView = cell.viewWithTag(3)! as! UIImageView
        authorImageView.layer.cornerRadius = authorImageView.frame.size.height/2
        authorImageView.layer.masksToBounds = true
        
        let authorNameLabel: UILabel = cell.viewWithTag(4)! as! UILabel
        authorNameLabel.text = "Loading..."
        
        
        let stringId: String! = String(currentPost.professorId!)
        getProfessorInfoWith(professorId: stringId) { (professor:Professor?, error:NSError?) in
            if error == nil {
                DispatchQueue.main.async {
                    authorImageView.setImageWith(NSURL(string: professor!.profilePicUrl as! String)! as URL)
                    authorNameLabel.text = professor!.publicName! as String
                }
            }
        }
                
        let mediaView: UIView = cell.viewWithTag(50)! as UIView
        mediaView.layer.cornerRadius = 10.0
        mediaView.layer.masksToBounds = true
        
        let mediaThumbnailView: UIImageView = mediaView.viewWithTag(5)! as! UIImageView
        mediaThumbnailView.image = UIImage()
        
        //let postMedia: String = currentPost.postMedia!.makeIterator().next()
        
        //let mediaArray = postMedia.characters.split{$0 == " "}.map(String.init)
        
        //let mediaType = mediaArray[0]
        //let mediaURL:NSURL = NSURL(string:mediaArray[1])!
        //print(mediaURL)
        
        
//        if mediaType == SupportedMediaTypes.Video {
//            
////            if mediaURL.absoluteString.containsString("youtu.be"){
////                
////                let thumbnailURL = "http://img.youtube.com/vi/" + mediaURL.lastPathComponent!  + "/default.jpg"
////                mediaThumbnailView.setImageWith(NSURL(string: thumbnailURL)! as URL)
////            } else if mediaURL.absoluteString.containsString("youtube.com") {
////                let thumbnailURL = "http://img.youtube.com/vi/" + getQueryStringParameter(mediaURL.absoluteString, param: "v")!  + "/default.jpg"
////                mediaThumbnailView.setImageWithURL(NSURL(string: thumbnailURL)!)
////            }
////            
//        } else if mediaType == SupportedMediaTypes.Image {
//            
//        } else if mediaType == SupportedMediaTypes.Audio {
//            
//        }
        
        
        //http://img.youtube.com/vi/lY2yjAdbvdQ/default.jpg
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if (indexPath.section == 0) {
                
                let profileView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CellProfileHeader", for: indexPath)
                
                return profileView
                
            } else {
                
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CellProfileHeader", for: indexPath)
                
                return headerView
                
            }
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CellFooter", for: indexPath)
            if (indexPath.section != hubCollectionView.numberOfSections - 1) {
                footerView.frame = CGRect(x: footerView.frame.origin.x, y: footerView.frame.origin.y, width: footerView.frame.size.width, height: 0)
                
            }
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    
    @IBAction func mediaButtonTapped(sender: AnyObject) {
        
//        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: hubCollectionView)
//        let indexPath: NSIndexPath = hubCollectionView.indexPathForItem(at: buttonPosition)! as NSIndexPath
//        
        //let cell:UICollectionViewCell = hubCollectionView.cellForRowAtIndexPath(indexPath)!
//        
//        let selectedPost: ProfessorPost = postList.object(at: indexPath.item) as! ProfessorPost
//        let postMedia: String = selectedPost.postMedia!.first
//        
//        let mediaArray = postMedia.characters.split{$0 == " "}.map(String.init)
//        
//        let mediaType = mediaArray[0]
//        let mediaURL = mediaArray[1]
//        
//        if mediaType == SupportedMediaTypes.Video {
//            
//            self.delegate?.didSelectedMedia(mediaType: SupportedMediaTypes.Video, urlString: mediaURL, mediaTitle: selectedPost.postTitle)
//            
//        } else if mediaType == SupportedMediaTypes.Image {
//            
//            self.delegate?.didSelectedMedia(mediaType: SupportedMediaTypes.Image, urlString: mediaURL, mediaTitle: selectedPost.postTitle)
//            
//        } else if mediaType == SupportedMediaTypes.Audio {
//            
//            self.delegate?.didSelectedMedia(mediaType: SupportedMediaTypes.Audio, urlString: mediaURL, mediaTitle: selectedPost.postTitle)
//            
//        }
        
        
        
    }
    
}
