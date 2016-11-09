//
//  Constants.swift
//  Doceo
//
//  Created by Juan David Cruz Serrano on 8/15/16.
//  Copyright © 2016 Juan David Cruz. All rights reserved.
//

import Foundation
import UIKit

struct AppKeys {

    static let AWSIdentityPoolId = "us-east-1:5a5ad151-a03d-4cac-b418-a9f661370566"
    static let AWSUserPoolId = "us-east-1_zhOWxO4mK"
    static let AWSUserPoolClientId = "74lkcb76kclouh0ur3ro20o175"
    static let AWSUserPoolClientSecret = "lk774kr1f5lrt83ihj1g7r8bsrneg03qlb1039dgatnsdg2iv46"
    
}

struct AppColors {
    
    static let StrawberryColor: UIColor = UIColor(colorLiteralRed: 255.0/255.0, green: 0.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    
}

struct LoginProviders {
    
    static let FaceBookProvider = "FBProvider"
    static let UserPoolProvider = "UPProvider"
    
}

struct ProfessorTabs {
    static let FollowingTab = 0
    static let DiscoverTab = 1
    static let SearchTab = 2
    
    static let OffColor = UIColor(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
}

struct HubTabs {
    static let DateTab = 0
    static let AreasTab = 1
    static let ProfessorsTab = 2
    static let SearchTab = 3
    
    static let OffColor = UIColor(colorLiteralRed: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
}

struct FollowingStatus {
    static let Following = "Following"
    static let NotFollowing = "NotFollowing"
    
}

struct SupportedMediaTypes {
    
    static let Video = "VIDEO"
    static let Image = "IMAGE"
    static let Audio = "AUDIO"
    static let PDF = "PDF"
    
}

struct ProfessorDefaults {
    static let AvatarUrl = "https://firebasestorage.googleapis.com/v0/b/socialboxpro.appspot.com/o/Professors%2FDefault%2FAvatarTeacher.jpg?alt=media&token=2fb99ddd-ac7a-42b6-824d-d02ec8315fc2"
}
