//
//  AddContactViewController.swift
//  Birthdays
//
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit
import Contacts

protocol AddContactViewControllerDelegate {
  func didFetchContacts(_ contacts: [CNContact])
}

class AddContactViewController: UIViewController {
  
  @IBOutlet weak var txtLastName: UITextField!
  @IBOutlet weak var pickerMonth: UIPickerView!
  
  var delegate: AddContactViewControllerDelegate!
  
  let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  
  var currentlySelectedMonthIndex = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pickerMonth.delegate = self
    txtLastName.delegate = self
    
    let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(AddContactViewController.performDoneItemTap))
    navigationItem.rightBarButtonItem = doneBarButtonItem
  }
  
  // MARK: IBAction functions
  
  @IBAction func showContacts(_ sender: AnyObject) {
    
  }
}
  
// MARK: UIPickerView Delegate and Datasource functions
extension AddContactViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return months.count
  }
  
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return months[row]
  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    currentlySelectedMonthIndex = row + 1
  }
}

// MARK: UITextFieldDelegate functions
extension AddContactViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    AppDelegate.appDelegate.requestForAccess { (accessGranted) -> Void in
      if accessGranted {
        let predicate = CNContact.predicateForContacts(matchingName: self.txtLastName.text!)
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey]
        var contacts = [CNContact]()
        var warningMessage: String!
        
        let contactsStore = AppDelegate.appDelegate.contactStore
        do {
          contacts = try contactsStore.unifiedContacts(matching: predicate, keysToFetch: keys as [CNKeyDescriptor])
          
          if contacts.count == 0 {
            warningMessage = "No contacts were found matching the given name."
          }
        }
        catch {
          warningMessage = "Unable to fetch contacts."
        }
        
        
        if warningMessage != nil {
          DispatchQueue.main.async {
            AppDelegate.appDelegate.showMessage(warningMessage)
          }
        }
        else {
          DispatchQueue.main.async {
            self.delegate.didFetchContacts(contacts)
            self.navigationController?.popViewController(animated: true)
          }
        }
      }
    }
    
    return true
  }
  
  // MARK: Custom functions
  
  func performDoneItemTap() {
    
  }
}
