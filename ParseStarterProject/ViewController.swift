/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse


class ViewController: UIViewController {
    
    var signUpActive = true
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var submit1: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var submit2: UIButton!
    
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        if signUpActive == true{
            
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            
            var errorMessage = "Please try again later"
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                
                print(error)
                
                if error == nil {
                    
                    // signed up!!!!
                    // work here!!!!!
                    
                    self.performSegueWithIdentifier("login", sender: self)
                    
                } else {
                    
                    if let errorString = error!.userInfo["error"] as? String {
                        
                        errorMessage = errorString
                        
                    }
                    //self.displayAlert("Failed SignUp", message: errorMessage)
                }
                
            })
            
        } else {
            
            PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                self.activityIndicator.startAnimating()
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()

                if user != nil{
                    //logged in
                    
                    self.performSegueWithIdentifier("login", sender: self)
                    
                }
                else{

                    // figure out later!!
                    
                    
                    self.performSegueWithIdentifier("login", sender: self)
                    print("you messed up")
                }
                
                
            })
        }
        
        
    }
    
    
    @IBAction func logIn(sender: AnyObject) {
        
        if signUpActive == true{
            
            submit1.setTitle("Log in", forState: UIControlState.Normal)
            
            registeredText.text = "Not registered?"
            
            submit2.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signUpActive = false
            
            
        }
        else{
            submit1.setTitle("Sign up", forState: UIControlState.Normal)
            
            registeredText.text = "Already registered?"
            
            submit2.setTitle("Log in", forState: UIControlState.Normal)
            
            signUpActive = true
            
            
            
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        let chores = PFObject(className: "Chores")
        
        chores["name"] = "Bathroom"
        
        chores["description"] = "clean floor, shower, toilet, etc."
        
        chores.saveInBackgroundWithBlock{ (success, error) -> Void in
            
            if success == true {
                
                print("Object saved with ID \(chores.objectId)")
                
                
            } else{
                
                print("fail :(")
                
                print(error)
                
            }
            
        }

        
        // retrieving data with particular ID
        
        let query = PFQuery(className: "Chores")
        
        query.getObjectInBackgroundWithId("6W3ij4Vtrw") { (object: PFObject?, error: NSError?) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else if let chores = object {
                
                chores["description"] = "something new"
                
                chores.saveInBackground()
                
                //print(object!.objectForKey("description"))
                
            }
            
        } */
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
