//
//  Localization.swift
//  TipCalculator
//
//  Created by Ezgi Kaysı on 11.11.2015.
//  Copyright © 2015 Ezgi Kaysı. All rights reserved.
//

import Foundation

/*extension NSUserDefaults {
    
    class func setLanguage(languageName : String) -> Void {
        
        if let value = standardUserDefaults().objectForKey("AppleLanguages") as? [String] {
        
            var languages = value
            
            if contains(languages, languageName) == true {
                
                let index = find(languages, languageName)!
                let languageSelected = languages[index]
                languages.removeAtIndex(index)
                languages.insert(languageSelected, atIndex: 0)
            }
            else {
                languages.insert(languageName, atIndex: 0)
            }
            
            standardUserDefaults().setObject(languages, forKey: "AppleLanguages")
            
            standardUserDefaults().synchronize()
        }
    }
}

extension NSBundle {
    
    func kd_localizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        
        // default
        var valueToReturn : String = (value != nil && value != "") ? value! : key
        
        if let languages = NSUserDefaults.standardUserDefaults().objectForKey("AppleLanguages") as? [String] {
            
            let currentLanguage = languages[0]
            
            if let path = NSBundle.mainBundle().pathForResource(currentLanguage, ofType: "lproj") {
                
                if let currentLanguageBundle = NSBundle(path: path) {
                    
                    if let localizedStringsFilePath = currentLanguageBundle.pathForResource("Localizable", ofType: "strings") {
                        
                        let localizedStringDictionary = NSDictionary(contentsOfFile: localizedStringsFilePath)
                        
                        if let value = localizedStringDictionary?[key] as? String {
                            valueToReturn = value
                        }
                    }
                }
            }
        }
        return valueToReturn
    }
}*/