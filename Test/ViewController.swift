//
//  ViewController.swift
//  Test
//
//  Created by Biswadeep Mondal on 26/07/22.
//

import UIKit
import CleverTapSDK
class ViewController: UIViewController {
    
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var identity: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var event: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      
        
    }


    @IBAction func onUserLogin(_ sender: UIButton) {
        
        print("Email: \(email.text!)")
        print("Identity: \(identity.text!)")
        print("Phone: \(phone.text!)")
        
        let profile: Dictionary<String,String> = [
            //Update pre-defined profile properties
            "Name": "Biswa",
            "Email": email.text!,
            "Identity":  identity.text!,
            "Phone": phone.text!,
            //Update custom profile properties
            "Plan type": "Silver",
            "Favorite Food": "Pizza"
        ]
        CleverTap.sharedInstance()?.onUserLogin(profile)
        //CleverTap.sharedInstance()?.recordEvent(profile)
      
    }
    
    @IBAction func pushEvent(_ sender: Any) {
        CleverTap.sharedInstance()?.recordEvent( (event.text!))
    }
    
}

