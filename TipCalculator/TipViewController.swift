//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ezgi Kaysı on 10.11.2015.
//  Copyright © 2015 Ezgi Kaysı. All rights reserved.
//

import UIKit

class TipViewController: UIViewController,UITextFieldDelegate  {
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var twoPeople: UILabel!
    
    @IBOutlet weak var threePeople: UILabel!
    
    @IBOutlet weak var fourPeople: UILabel!
    
    @IBOutlet weak var fivePeople: UILabel!
    
    @IBOutlet weak var resultsView: UIView!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var BillView: UIView!
    
    let defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationWillResignActive",
            name: UIApplicationWillResignActiveNotification,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "ApplicationDidBecomeActive",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil
        )
        
        self.billTextField.delegate = self;
        self.billTextField.becomeFirstResponder();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.LoadDefaultSettings();
        
        if((billTextField.text! as NSString).doubleValue == 0 ){
            ShowInputOnlyView()
        }
        
    }

    
    @IBAction func onBillValueChanged(sender: AnyObject) {
        
        CalculateValue();
        updateViewWithAnimation(true);
    }
    
    @IBAction func onTipValueChanged(sender: AnyObject) {
        
        CalculateValue();
    }
    
    func CalculateValue(){
        
        let billAmount = (billTextField.text! as NSString).floatValue;
        let tip = billAmount * ( Float(tipSlider.value) / 100);
        let total = billAmount + tip;
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        twoPeople.text = currencyFormatter.stringFromNumber(total / 2)
        threePeople.text = currencyFormatter.stringFromNumber(total / 3)
        fourPeople.text = currencyFormatter.stringFromNumber(total / 4)
        fivePeople.text = currencyFormatter.stringFromNumber(total / 5)
    }
    
    func updateViewWithAnimation(animated: Bool){
      
        let billAmount = (billTextField.text! as NSString).doubleValue
        
        if (billAmount == 0) {
           showInputOnlyViewWithAnimation()
        } else {
           showResultsView()
        }
    }

    func showInputOnlyViewWithAnimation(){
        UIView.animateWithDuration(0.7, delay:0.0,
                    options: UIViewAnimationOptions.TransitionFlipFromTop,
                    animations:{
                      self.ShowInputOnlyView();
                    },
                    completion:nil
                    )
    }
    
    func showResultsView(){
        UIView.animateWithDuration(0.7, delay:0.0,
            options: UIViewAnimationOptions.TransitionFlipFromBottom,
            animations:{
                self.tipSlider.hidden = false
                self.resultsView.hidden = false
                self.tipLabel.hidden = false
                
                self.tipSlider.alpha = 1;
                
                var textFrame:CGRect = self.billTextField.frame;
                textFrame.origin.y = 10;
                self.billTextField.frame = textFrame;
                
                var tipLabelFrame:CGRect = self.tipLabel.frame;
                tipLabelFrame.origin.y = 150;
                self.tipLabel.frame = tipLabelFrame;
                
                var tipControlFrame:CGRect = self.tipSlider.frame;
                tipControlFrame.origin.y = 180;
                self.tipSlider.frame = tipControlFrame;
                
                var resultFrame:CGRect = self.resultsView.frame;
                resultFrame.origin.y = 220;
                self.resultsView.frame = resultFrame;

            },
            completion: { _ in  }
        )
    }
    
    
    func ShowInputOnlyView()
    {
        self.tipSlider.alpha = 0;
        
        var tipControlFrame:CGRect = self.tipSlider.frame;
        tipControlFrame.origin.y = 250;
        tipSlider.frame = tipControlFrame;
        
        var resultFrame:CGRect = resultsView.frame;
        resultFrame.origin.y = 300;
        resultsView.frame = resultFrame;
        
        var textFrame:CGRect = self.billTextField.frame;
        textFrame.origin.y = 110;
        self.billTextField.frame = textFrame;
        
        tipSlider.hidden = true
        resultsView.hidden = true
        tipLabel.hidden = true
        
    }
    func LoadDefaultSettings()
    {
        
        if(defaults.boolForKey("Theme"))
        {
            setDarkTheme()
            
        }else{
            
            setLightTheme()
        }
        
        if( defaults.floatForKey("maximum")  == Float(0) )
        {
            tipSlider.value = Float(20)
            tipSlider.minimumValue = Float(0)
            tipSlider.maximumValue  = Float(100)
            
        }else{
            
            tipSlider.minimumValue = defaults.floatForKey("minimum");
            tipSlider.maximumValue = defaults.floatForKey("maximum");
            tipSlider.value = defaults.floatForKey("default");
            
        }        
      
    }
    
    func applicationWillResignActive()
    {
        
        defaults.setFloat((billTextField.text! as NSString).floatValue , forKey: "LastBillValue")
        defaults.setFloat(Float(tipSlider.value) , forKey: "LastTipSliderValue")
        defaults.setObject(NSDate() , forKey: "LastAccesedTime")
        defaults.synchronize()
    }
    
    func ApplicationDidBecomeActive()
    {
        
        let lastTime = defaults.objectForKey("LastAccesedTime") as! NSDate
        
        let timeDiff = NSDate().timeIntervalSinceDate(lastTime)
        if(timeDiff < 5) //I set 5 second for quick test
        {
          
            billTextField.text = String(defaults.floatForKey("LastBillValue"));
            tipSlider.value = defaults.floatForKey("LastTipSliderValue");
            tipSlider.minimumValue = defaults.floatForKey("minimum");
            tipSlider.maximumValue = defaults.floatForKey("maximum");
            
            
            CalculateValue()
            showResultsView()
        }
        else{
            billTextField.text = ""
            ShowInputOnlyView();
        }
    }
    
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    func setLightTheme(){
        
        resultsView.backgroundColor = UIColor(red: 10.0/255.0, green: 25.0/255.0, blue: 88.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 102.0/255.0, green: 204.0/255.0, blue: 255.0, alpha: 1.0)
        billTextField.backgroundColor = UIColor(red: 102.0/255.0, green: 204.0/255.0, blue: 255.0, alpha: 1.0)
    }
    
    func setDarkTheme(){
        
        view.backgroundColor = UIColor.grayColor()
        billTextField.backgroundColor = UIColor.grayColor()
        resultsView.backgroundColor = UIColor.blackColor()
    }

}

