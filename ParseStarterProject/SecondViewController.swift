//
//  SecondViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Amy on 9/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

var choreList = [String]()

var roomieList = [String]()

class SecondViewController: UIViewController, UITableViewDelegate {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    @IBOutlet var roomieTextField: UITextField!
    
    @IBAction func roomieSubmit(sender: AnyObject) {
        
        roomieList.append(roomieTextField.text!)
        roomieTextField.text = ""
        NSUserDefaults.standardUserDefaults().setObject(roomieList, forKey: "roomieList")
    }
    
    @IBOutlet var choreTextField: UITextField!
    
    
    @IBAction func choreSubmit(sender: AnyObject) {
        
        choreList.append(choreTextField.text!)
        choreTextField.text = ""
        NSUserDefaults.standardUserDefaults().setObject(choreList, forKey: "roomieList")
    }

    @IBOutlet var roomieTable: UITableView!
    
    @IBOutlet var choreTable: UITableView!
    
    // public in front??
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // ADD STUFF LATER
        
        return(choreList.count)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // ADD STUFF LATER
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = choreList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            choreList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(choreList, forKey: "choreList")
            choreTable.reloadData()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if NSUserDefaults.standardUserDefaults().objectForKey("choreList") != nil {
            
            choreList = NSUserDefaults.standardUserDefaults().objectForKey("choreList") as! [String]
            
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("roomieList") != nil {
            
            roomieList = NSUserDefaults.standardUserDefaults().objectForKey("roomieList") as! [String]
            
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool){
        choreTable.reloadData()
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        choreTextField.resignFirstResponder()
        
        roomieTextField.resignFirstResponder()
        
        return true
    }
    
    
}
