//
//  EventEntryViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 1/12/16.
//  Copyright © 2016 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

private struct CellNames {
    static let store = "store"
    static let allDay = "allDay"
    static let starts = "starts"
    static let ends = "ends"
    static let title = "title"
    static let description = "description"
    static let startsPicker = "startsPicker"
    static let endsPicker = "endsPicker"
    
    static let startsPickerPath = NSIndexPath(forRow: 2, inSection: 2)
    static let endsPickerPath = NSIndexPath(forRow: 4, inSection: 2)
}

class EventEntryViewController: UITableViewController {
    
    @IBOutlet weak var storeCell: UITableViewCell!
    
    @IBOutlet weak var startsCell: UITableViewCell!
    
    @IBOutlet weak var endsCell: UITableViewCell!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var startsPicker: UIDatePicker!
    @IBOutlet weak var endsPicker: UIDatePicker!
    
    var startsPickerActive = false
    var endsPickerActive = false
    
    var objectToAdd = PFObject(className: "event")
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        objectToAdd.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil {
                UIAlertController().displayMessage(error!.localizedDescription)
            }
        }
        
    }
    
    class func instantiateFromStoryboard() -> EventEntryViewController {
        return UIStoryboard(name: "EventEntry", bundle: nil).instantiateInitialViewController() as! EventEntryViewController
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBarHidden = false
    }
    
    func storeCellTapped() {
        let controller = StoreSelectorTableViewController.instantiateFromStoryboard()
        controller.delegate = self
        presentViewController(controller, animated: true, completion: nil)
    }
    
    func startCellTapped() {
        startsPickerActive = !startsPickerActive
        tableView.reloadData()
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        
        let date = formatter.stringFromDate(startsPicker.date)
        
        startsCell.detailTextLabel?.text = date
        
        objectToAdd["starts"] = startsPicker.date
        
        /*
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.tableView.reloadRowsAtIndexPaths([CellNames.startsPickerPath], withRowAnimation: UITableViewRowAnimation.Top)
            }) { (success) -> Void in
               // self.tableView.reloadData()
        }*/
        
    }
    
    func endCellTapped() {
        endsPickerActive = !endsPickerActive
        tableView.reloadData()
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        
        let date = formatter.stringFromDate(endsPicker.date)
        
        endsCell.detailTextLabel?.text = date
        
        objectToAdd["ends"] = endsPicker.date
    }
    
    func enableAddButton() {
        
        addButton.enabled = false
        
        guard let _ = objectToAdd["store"] else {
            return
        }
        guard let _ = objectToAdd["title"] else {
            return
        }
        guard let _ = objectToAdd["description"] else {
            return
        }
        guard let _ = objectToAdd["description"] else {
            return
        }
        guard let _ = objectToAdd["starts"] else {
            return
        }
        guard let _ = objectToAdd["ends"] else {
            return
        }
        
        addButton.enabled = true
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let identifier = cell?.reuseIdentifier
        
        if identifier == CellNames.store {
            storeCellTapped()
        } else if identifier == CellNames.starts {
            startCellTapped()
        } else if identifier == CellNames.ends {
            endCellTapped()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath == CellNames.startsPickerPath {
            
            if startsPickerActive == true {
                return 216
            } else {
                return 0
            }
            
        }
        
        if indexPath == CellNames.endsPickerPath {
            if endsPickerActive == true {
                return 216
            } else {
                return 0
            }
        }
        
        return tableView.rowHeight
        
    }

}

extension EventEntryViewController: StoreSelectorDelegate {
    func setSelectedStore(store: PFObject) {
        
        if let name = store["name"] as? String {
            storeCell.detailTextLabel?.text = name
        }
        
        objectToAdd["store"] = store
        
        enableAddButton()
    }
}

extension EventEntryViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print("shouldChangeCharacters \(string)")
        
        if textField == titleField {
            objectToAdd["title"] = textField.text!
        }
        
        if textField == descriptionField {
            objectToAdd["description"] = textField.text!
        }
        
        enableAddButton()
        
        return false
    }
}
/*
extension EventEntryViewController {
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
        switch indexPath.row {
        case 0: RStore.sharedInstance.selectedDepartment = Department.Mens.rawValue; break
        case 1: RStore.sharedInstance.selectedDepartment = Department.Womens.rawValue; break
        case 2: RStore.sharedInstance.selectedDepartment = Department.Kids.rawValue; break
        case 3: RStore.sharedInstance.selectedDepartment = Department.Misc.rawValue; break
        default: RStore.sharedInstance.selectedDepartment = Department.Mens.rawValue; break
        }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RSCenteredTableViewCell
        
        let controller = StoreTableViewController.instantiateFromStoryboard()
        controller.title = cell.title.text
        self.navigationController!.pushViewController(controller, animated: true)*/
    }
    
    
}

extension EventEntryViewController {
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}*/