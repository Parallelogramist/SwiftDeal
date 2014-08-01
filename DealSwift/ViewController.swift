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
        label.text = "Welcome\n\(textField.text)!" //something funny going on here
    }
    
    @IBAction func friendsButton(sender: UIButton) {
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.NotDetermined){
            var emptyDictionary: CFDictionaryRef?
            var addressBook = !ABAddressBookCreateWithOptions(emptyDictionary, nil)
            
            ABAddressBookRequestAccessWithCompletion(addressBook,{success, error in
                if success {self.getContactNames();}
            })
        }
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized) {
            getContactNames()
        }
    }
    
    // #pragma mark - ABUI

    func getContactNames()
    {
        var errorRef: Unmanaged<CFError>?
        var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
        var contactList: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        
        for record:ABRecordRef in contactList {
            var contactName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
            NSLog("contactName: \(contactName)")
        }
    }
    
    func extractABAddressBookRef(abRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let ab = abRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
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
        
        let data = betTableArray[indexPath.row]
        betLabel.text = "Selected Item:\n\(data)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //label.text = "Welcome "
        //let name:String = (NSUserDefaults.standardUserDefaults().objectForKey("name") as String!)
        //label.text = " " + name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}