//
//  FiltersViewController.swift
//  MovieViewer
//
//  Created by TriNgo on 7/10/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

@objc protocol FiltersDelegate: class {
    optional func onAdultShowContent(sender: FiltersViewController, state: String)
    optional func onReleaseYearPick(sender: FiltersViewController, row: Int)
    optional func onPrimaryYearPick(sender: FiltersViewController, row: Int)
    optional func onResetFilters(sender: FiltersViewController, adultShowContent: String, releaseYearRow: Int, primaryYearRow: Int)
}

class FiltersViewController: UITableViewController {

    weak var delegate: FiltersDelegate?
    @IBOutlet weak var releaseYearPicker: UIPickerView!
    @IBOutlet weak var primaryYearPicker: UIPickerView!
    @IBOutlet weak var showAdultContentSwitch: UISwitch!
    
    var includeAdult: String?
    var year = [String]()
    var releaseYearRow:Int = 0
    var primaryYearRow:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        releaseYearPicker.delegate = self
        primaryYearPicker.delegate = self
        
        initYearArray()
        initFilters()
    }

    func initYearArray() {
        year.append("Any")
        for index in 0...100 {
            year.append(String(1950 + index))
        }
    }
    
    func initFilters() {
        showAdultContentSwitch.setOn(NSString(string:includeAdult!).boolValue, animated: true)
        releaseYearPicker.selectRow(releaseYearRow, inComponent: 0, animated: true)
        primaryYearPicker.selectRow(primaryYearRow, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onResetTap(sender: UIBarButtonItem) {
        includeAdult = "true"
        releaseYearRow = 0
        primaryYearRow = 0
        
        delegate?.onResetFilters!(self, adultShowContent: includeAdult!, releaseYearRow: releaseYearRow, primaryYearRow: primaryYearRow)
        initFilters()
    }
    
    @IBAction func onSwitchChange(sender: UISwitch) {
        delegate?.onAdultShowContent!(self, state: String(sender.on))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Picker View
extension FiltersViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return year.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return year[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == releaseYearPicker {
            delegate?.onReleaseYearPick!(self, row: row)
        } else if pickerView == primaryYearPicker {
            delegate?.onPrimaryYearPick!(self, row: row)
        }
    }
}






