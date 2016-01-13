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
    
    var eventToAdd = PFObject(className: "event")
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        eventToAdd.saveInBackgroundWithBlock { (success, error) -> Void in
            if error != nil {
                UIAlertController().displayMessage(error!.localizedDescription)
            } else {
                let title = self.eventToAdd["title"] as! String
                UIAlertController().displayMessage("Added \(title)")
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
        formatter.dateStyle = .MediumStyle
        
        let date = formatter.stringFromDate(startsPicker.date)
        
        startsCell.detailTextLabel?.text = date
        
        eventToAdd["starts"] = startsPicker.date
        
        enableAddButton()
        
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
        formatter.dateStyle = .MediumStyle
        
        let date = formatter.stringFromDate(endsPicker.date)
        
        endsCell.detailTextLabel?.text = date
        
        eventToAdd["ends"] = endsPicker.date
        
        enableAddButton()
    }
    
    func enableAddButton() {
        
        addButton.enabled = false
        
        guard let _ = eventToAdd["store"] else {
            return
        }
        guard let _ = eventToAdd["title"] else {
            return
        }
        guard let _ = eventToAdd["description"] else {
            return
        }

        guard let _ = eventToAdd["starts"] else {
            return
        }
        guard let _ = eventToAdd["ends"] else {
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
        
        eventToAdd["store"] = store
        
        enableAddButton()
    }
}

extension EventEntryViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
                
        if textField == titleField {
            eventToAdd["title"] = textField.text!
        }
        
        if textField == descriptionField {
            eventToAdd["description"] = textField.text!
        }
        
        enableAddButton()
        
        return true
    }
}