//
//  Theme.swift
//  TipCalculator
//
//  Created by Ezgi Kaysı on 13.11.2015.
//  Copyright © 2015 Ezgi Kaysı. All rights reserved.
//

import Foundation
import UIKit

enum Theme: Int {
    case Default, Dark, Graphical
    
    var mainColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .Graphical:
            return UIColor(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0)
        }
    }
    
    
    var backgroundColor: UIColor {
        switch self {
        case .Default, .Graphical:
            return UIColor(white: 0.9, alpha: 1.0)
        case .Dark:
            return UIColor(white: 0.8, alpha: 1.0)
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .Default:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        case .Dark:
            return UIColor(red: 34.0/255.0, green: 128.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        case .Graphical:
            return UIColor(red: 140.0/255.0, green: 50.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        }
    }
}


struct ThemeManager {

static func applyTheme(theme: Theme) {

    //let sharedApplication = UIApplication.sharedApplication()
   // sharedApplication.delegate?.window??.tintColor = theme.mainColor
    
    
    
    //UISwitch.appearance().onTintColor = UIColor.blackColor()
   // UISwitch.appearance().thumbTintColor = theme.mainColor
    
  
    
 
    
}


}