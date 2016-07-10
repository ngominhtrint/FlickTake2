//
//  UIImageView.swift
//  MovieViewer
//
//  Created by Dang Quoc Huy on 7/2/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // Set image with fade in animation
    func setImageWithFadeIn(image: UIImage) {
        
        alpha = 0.0
        self.image = image
        UIView.animateWithDuration(1.5) {
            self.alpha = 1.0
        }
    }
    
    // Load thumbnail, then load full size image
    func setImageWithThumbnail(thumbnailURL: NSURL?, imageURL: NSURL?) {
        
        guard let thumbnailURLSafe = thumbnailURL else { return }
        guard let imageURLSafe = imageURL else { return }
        
        // load thumbnail first
        let request = NSURLRequest(URL: thumbnailURLSafe)
        self.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) in
            
            // load thumbnail image
            self.image = image
            // then, load full size image
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.setImageWithURL(imageURLSafe)
            })
        }, failure: { (request, response, error) in
            
            // process error here
            debugPrint(error.localizedDescription)
        })
    }
}
