//
//  RUser.swift
//  
//
//  Created by Hunter Maximillion Monk on 12/21/15.
//
//

import Foundation
import DigitsKit

class RUser:NSObject {
    
    let password = "thisIsTheParsePassword"
    
    func createUser(session:DGTSession) {
        
        let user = PFUser()
        user.username = session.phoneNumber
        user.password = password
        user.signUpInBackgroundWithBlock({
            (success, error) -> Void in
            if error != nil {
                
                //___ Error code 202 means they're already signed up
                if error?.code == 202 {
                    self.logIn(session)
                } else {
                    print("error \(error?.localizedDescription)")
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.receiveSignupNotification.rawValue, object: nil, userInfo: ["success":false])
                }
                
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.receiveSignupNotification.rawValue, object: nil, userInfo: ["success":true])
            }
        })
        
    }
    
    func logIn(session:DGTSession) {
        
        PFUser.logInWithUsernameInBackground(session.phoneNumber, password: password) {
            (user, error) -> Void in
            if error != nil {
                print("error \(error?.localizedDescription)")
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.receiveSignupNotification.rawValue, object: nil,  userInfo: ["success":false])
            } else {
               NSNotificationCenter.defaultCenter().postNotificationName(Notification.receiveSignupNotification.rawValue, object: nil, userInfo: ["success":true]) 
            }
        }
    }
    
}