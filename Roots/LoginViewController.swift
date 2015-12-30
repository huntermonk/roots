//
//  LoginViewController.swift
//  Roots
//
//  Created by Hunter Monk on 12/11/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import UIKit
import DigitsKit

public enum Notification: String {
    case receiveSignupNotification
}


class LoginViewController: UIViewController {

    class func instantiateFromStoryboard() -> LoginViewController {
        return UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as! LoginViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedSignupNotification:", name: Notification.receiveSignupNotification.rawValue, object: nil)
        
        let completion = ({
            (session: DGTSession?, error: NSError?) in
            if session != nil {
                RUser().createUser(session!)
            } else {
                print("Authentication error: \(error!.localizedDescription)")
            }
        })
        
        let authButton = DGTAuthenticateButton(authenticationCompletion: completion)
        authButton.setTitle("Login with Phone Number 📞", forState: .Normal)
        authButton.center = self.view.center
        self.view.addSubview(authButton)
    }
    
    func receivedSignupNotification(notification:NSNotification) {
        if let info = notification.userInfo, success = info["success"] as? Bool {
            
            if success == true {
                presentViewController(DepartmentTableViewController.instantiateFromStoryboard(), animated: true, completion: nil)
            } else if success == false {
                let alert = UIAlertController(title: nil, message: "There was an error logging in, try again.", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(action)
                presentViewController(alert, animated: true, completion: nil)
            }
            
        }
    }

}
