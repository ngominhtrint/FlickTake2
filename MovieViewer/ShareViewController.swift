//
//  ShareViewController.swift
//  MovieViewer
//
//  Created by TriNgo on 7/11/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import Social

class ShareViewController: UIViewController {
    
    
    @IBOutlet weak var shareTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initShareMenu()
        configureShareTextView()
    }
    
    func configureShareTextView() {
        shareTextView.contentInset = UIEdgeInsetsMake(-64.0,0.0,0.0,0.0);
        shareTextView.layer.cornerRadius = 8.0
        shareTextView.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).CGColor
        shareTextView.layer.borderWidth = 1.2
    }
    
    @IBAction func onPostTap(sender: UIBarButtonItem) {
        initShareMenu()
    }
    
    func initShareMenu() {
        if shareTextView.isFirstResponder() {
            shareTextView.resignFirstResponder()
        }
        
        let shareMenu = UIAlertController(title: "Share your note", message: nil, preferredStyle: .ActionSheet)
        
        let shareOnTwitter = UIAlertAction(title: "Share on Twitter", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.shareViaTwitter()
        })
        let shareOnFacebook = UIAlertAction(title: "Share on Facebook", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.shareViaFacebook()
        })
        let moreAction = UIAlertAction(title: "More", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.shareViaMore()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        shareMenu.addAction(shareOnTwitter)
        shareMenu.addAction(shareOnFacebook)
        shareMenu.addAction(moreAction)
        shareMenu.addAction(cancelAction)
    
        self.presentViewController(shareMenu, animated: true, completion: nil)
    }

    func shareViaTwitter() {
        // Check if sharing to Twitter is possible.
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            // Initialize the default view controller for sharing the post.
            let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            // Set the note text as the default post message.
            if self.shareTextView.text.characters.count <= 140 {
                twitterComposeVC.setInitialText("\(self.shareTextView.text)")
            } else {
                let index = self.shareTextView.text.startIndex.advancedBy(140)
                let subText = self.shareTextView.text.substringToIndex(index)
                twitterComposeVC.setInitialText("\(subText)")
            }
        }
        else {
            self.showAlertMessage("You are not logged in to your Twitter account.")
        }
    }
    
    func shareViaFacebook() {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookComposeVC.setInitialText("\(self.shareTextView.text)")
            
            self.presentViewController(facebookComposeVC, animated: true, completion: nil)
        } else {
            self.showAlertMessage("You are not connected to your Facebook account.")
        }
    }
    
    func shareViaMore() {
        let activityViewController = UIActivityViewController(activityItems: [self.shareTextView.text], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
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
