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
    optional func onReleaseYearPick(sender: FiltersViewController, value: String)
    optional func onPrimaryYearPick(sender: FiltersViewController, value: String)
    optional func onResetFilters(sender: FiltersViewController, adultShowContent: String, releaseYear: String, primaryYear: String)
}

class FiltersViewController: UITableViewController {

    weak var delegate: FiltersDelegate?
    @IBOutlet weak var releaseYearPicker: UIPickerView!
    @IBOutlet weak var primaryYearPicker: UIPickerView!
    @IBOutlet weak var showAdultContentSwitch: UISwitch!
    
    var includeAdult: String?
    var releaseYear: String?
    var primaryYear: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        releaseYearPicker.delegate = self
        primaryYearPicker.delegate = self
        
        initFilters()
    }

    func initFilters() {
        showAdultContentSwitch.setOn(NSString(string:includeAdult!).boolValue, animated: true)
        releaseYearPicker.selectRow(Int(releaseYear!)! - 1950, inComponent: 0, animated: true)
        primaryYearPicker.selectRow(Int(primaryYear!)! - 1950, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onResetTap(sender: UIBarButtonItem) {
        includeAdult = "true"
        releaseYear = "2016"
        primaryYear = "2016"
        
        initFilters()
        delegate?.onResetFilters!(self, adultShowContent: includeAdult!, releaseYear: releaseYear!, primaryYear: primaryYear!)
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
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(1950 + row);
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == releaseYearPicker {
            delegate?.onReleaseYearPick!(self, value: String(1950 + row))
        } else if pickerView == primaryYearPicker {
            delegate?.onPrimaryYearPick!(self, value: String(1950 + row))
        }
    }
}






