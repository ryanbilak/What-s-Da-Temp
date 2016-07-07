//
//  ViewController.swift
//  What's Da Temp
//
//  Created by Ryan Bilak on 5/18/16.
//  Copyright © 2016 beachambilak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getDaTempTapped(sender: AnyObject) {
        
        let helper = APIHelper()
        
        helper.getTemp { (temp, success) -> Void in
            
            if success {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tempLabel.text = temp
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tempLabel.text = "We have a problem"
                })
            }
            
        }
        
    }
    
}