//
//  ViewController.swift
//  DealSwift
//
//  Created by Developer on 7/28/14.
//  Copyright (c) 2014 Osciciol. All rights reserved.
//
import AddressBook
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var betTable: UITableView
    @IBOutlet var label: UILabel
    @IBOutlet var betLabel: UILabel
    @IBOutlet var textField: UITextField
    @IBOutlet var selectedFriendLabel: UILabel
    
    let betTableArray:[String] = ["Breakfast", "Ice Cream",
        "Soda", "Beer", "A Shot",
        "5 bucks"]
    
    var betImages:[UIImage] = [UIImage(named:"breakfast"),
        UIImage(named:"iceCream"),
        UIImage(named:"soda"),
        UIImage(named:"beer"),
        UIImage(named:"shot"),
        UIImage(named:"dollarBill")]
    
    @IBAction func saveButton(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().setObject(textField.text, forKey:"name")
        label.text = "Welcome\n\(textField.text)!"
    }
        
    // #pragma mark - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return betTableArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        cell.textLabel.text = betTableArray[indexPath.row]
        cell.imageView!.image = betImages[indexPath.row]
        
        return cell
    }
    
    // #pragma mark UITableViewDelegate
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        NSUserDefaults.standardUserDefaults().setObject(betTableArray[indexPath.row], forKey:"bet")

        betLabel.text = "Selected Item:\n\(betTableArray[indexPath.row])"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Welcome\n" + (NSUserDefaults.standardUserDefaults().objectForKey("name") as String!) + "!"
        betLabel.text = "Selected Item:\n" + (NSUserDefaults.standardUserDefaults().objectForKey("bet") as String!)
        selectedFriendLabel.text = "Selected Friend:\n" + (NSUserDefaults.standardUserDefaults().objectForKey("friend") as String!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}