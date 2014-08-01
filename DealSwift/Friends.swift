//
//  Friends.swift
//  DealSwift
//
//  Created by Developer on 8/1/14.
//  Copyright (c) 2014 Osciciol. All rights reserved.
//
import UIKit
import AddressBook

class Friends: UIViewController {
    
    @IBOutlet var friendsTable: UITableView
    
    var friendsArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // #pragma mark - ABUI
    
    func getContactNames()
    {
        var errorRef: Unmanaged<CFError>?
        var addressBook: ABAddressBookRef? = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
        var contactList: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue()
        
        for record:ABRecordRef in contactList {
            var contactName: String = ABRecordCopyCompositeName(record).takeRetainedValue() as NSString
            friendsArray.append(contactName)
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
        return friendsArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        cell.textLabel.text = friendsArray[indexPath.row]
        
        return cell
    }
    
    // #pragma mark UITableViewDelegate
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        NSUserDefaults.standardUserDefaults().setObject(friendsArray[indexPath.row], forKey:"friend")

        performSegueWithIdentifier("Back", sender: nil)
    }
}