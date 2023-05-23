//
//  ViewController.swift
//  Test
//
//  Created by Biswadeep Mondal on 26/07/22.
//

import UIKit
import CleverTapSDK
import Adjust
class ViewController: UIViewController,CleverTapDisplayUnitDelegate {
    
   
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var identity: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var event: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
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
        //CleverTap.sharedInstance()?.recordEvent( (event.text!))
        CleverTap.sharedInstance()?.recordEvent( ("native 1"))
        CleverTap.sharedInstance()?.recordEvent( ("native 2"))
        var ctid1=CleverTap.sharedInstance()?.profileGetID()
     //   var ctid=CleverTap.profileGetAttributionIdentifier(CleverTap.)
     // var ctid =   CleverTap.sharedInstance()?.profileGetID()
        let event = ADJEvent(eventToken: "5j5kb2")
        event?.setCallbackId((ctid1 as? String)!)
        event?.addPartnerParameter("clevertap_id", value: (ctid1 as? String)!)
        Adjust.addSessionCallbackParameter("clevertap_id", value: (ctid1 as? String)!)
        //event?.addCallbackParameter("mykey", "myvalue");
        //print("clevertap ",ctid)
        event?.addPartnerParameter("clevertap_id", value: (ctid1 as? String)!)
       // print("hgf"+(ctid))
        Adjust.trackEvent(event)
        print("CTmyprofileGetID",ctid1 ?? "nodata")
        
    }
    
   
    
    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
           // you will get display units here
        var units:[CleverTapDisplayUnit] = displayUnits;
        
        print("native display",units);
                let jsonData = displayUnits[0].json
               
                
                for i in units{
                    print("native display contents",i.contents?.first?.title) //for displaying title
                    let a=i.contents?.first?.title;
                    let b=i.contents?.first?.message;
                    print("native display message",i.contents?.first?.message)
        //          nativedatapass.text=i.contents?.first?.title+","+i.contents?.first?.message;
                   // nativedatapass.text=a!+b!;
                    print("native display keys",i.customExtras?.keys)
                    print("native display contentskv",i.customExtras?.values) //for displaying key value
                    
                }
                CleverTap.sharedInstance()?.recordDisplayUnitViewedEvent(forID: (units.first!.unitID)!)
                //for native display add recordDisplayUnitViewedEvent and units.first
                
                CleverTap.sharedInstance()?.recordDisplayUnitViewedEvent(forID: (units.first!.unitID)!)
                //for notification clicked event
        
    }
}

