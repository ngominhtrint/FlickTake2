//
//  ShareViewController.swift
//  MovieViewer
//
//  Created by TriNgo on 7/11/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var shareTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initShareMenu()
    }
    
    @IBAction func onPostTap(sender: UIBarButtonItem) {
        initShareMenu()
    }
    
    func initShareMenu() {
        let shareMenu = UIAlertController(title: "Share your note", message: nil, preferredStyle: .ActionSheet)
        
        let shareOnTwitter = UIAlertAction(title: "Share on Twitter", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Share on Twitter")
        })
        let shareOnFacebook = UIAlertAction(title: "Share on Facebook", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Share on Facebook")
        })
        let moreAction = UIAlertAction(title: "More", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("More")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        shareMenu.addAction(shareOnTwitter)
        shareMenu.addAction(shareOnFacebook)
        shareMenu.addAction(moreAction)
        shareMenu.addAction(cancelAction)
    
        self.presentViewController(shareMenu, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
