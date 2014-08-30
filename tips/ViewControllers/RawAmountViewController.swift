//
//  RawAmountViewController.swift
//  tips
//
//  Created by Perry Zheng on 8/27/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class RawAmountViewController: UIViewController {

    @IBOutlet weak var rawAmountField: UITextField!
    let tipsNSUserDefaults: TipsNSUserDefaults = TipsNSUserDefaults()
    var rawAmount: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appResign:", name: UIApplicationWillResignActiveNotification, object: nil)
    }
    
    func appDidBecomeActive(notification: NSNotification) {
        println("in RawViewController appDidBecomeActive")
        rawAmount = tipsNSUserDefaults.getRawAmount()
        println(rawAmount)
        updateUI()
    }
    
    func appResign(notification: NSNotification) {
        println("in RawViewController appResign")
        tipsNSUserDefaults.setRawAmount(rawAmount)
    }
    
    func updateUI() {
        rawAmountField.becomeFirstResponder()
        rawAmount = tipsNSUserDefaults.getRawAmount()
        rawAmountField.text = "$" + rawAmount
        rawAmountField.textAlignment = NSTextAlignment.Right
        enterRawAmount(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enterRawAmount(sender: AnyObject) {
        let rawAmount = rawAmountField.text.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        tipsNSUserDefaults.setRawAmount(rawAmount)
        if (!rawAmount.isEmpty) {
            self.performSegueWithIdentifier("check_list_view", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "check_list_view") {
            if (segue.destinationViewController .isKindOfClass(ViewController)) {
                let vc: ViewController  = segue.destinationViewController as ViewController
                var text = rawAmountField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                text = text.substringFromIndex(text.startIndex.successor())
                vc.rawAmount = text
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
