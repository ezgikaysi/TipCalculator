//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Ezgi Kaysı on 10.11.2015.
//  Copyright © 2015 Ezgi Kaysı. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController,UITextFieldDelegate {
   
    
    @IBOutlet weak var defaultField: UITextField!
    @IBOutlet weak var minimumField: UITextField!
    @IBOutlet weak var maximumField: UITextField!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if( defaults.floatForKey("maximum")  == Float(0) )
        {
            self.defaultField.text = "20"
            self.minimumField.text = "0"
            self.maximumField.text = "100"
            
        }else{
        
            self.defaultField.text = String(defaults.floatForKey("default"))
            self.minimumField.text = String(defaults.floatForKey("minimum"))
            self.maximumField.text = String(defaults.floatForKey("maximum"))
            
        }
        self.themeSwitch.on = defaults.boolForKey("Theme");
    }    
    
    @IBAction func DefaultEditEnd(sender: AnyObject) {
        validateInputValue();
    }
    
    @IBAction func minimumEditEnd(sender: AnyObject) {
        validateInputValue();
    }
    
    @IBAction func MaximumEditEnd(sender: AnyObject) {
        validateInputValue();
    }
    
    func validateInputValue()
    {
        let defaultValue = (defaultField.text! as NSString).floatValue;
        let minimumValue = (minimumField.text! as NSString).floatValue;
        let maximumValue = (maximumField.text! as NSString).floatValue;
        
        if(defaultValue < minimumValue){
            self.minimumField.text = String(defaultValue);
        } else if(maximumValue < defaultValue)
        {
            self.maximumField.text = String(defaultValue);
        }else if(maximumValue < minimumValue){
            self.maximumField.text = String(minimumValue);
        }
    }
    
    
    @IBAction func onBackClick(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setFloat((defaultField.text! as NSString).floatValue , forKey: "default")
        defaults.setFloat((minimumField.text! as NSString).floatValue , forKey: "minimum")
        defaults.setFloat((maximumField.text! as NSString).floatValue , forKey: "maximum")
       
        defaults.setBool(themeSwitch.on, forKey: "Theme")
        
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func themeSwitchPressed(sender: AnyObject) {
    
      
    }
    
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
