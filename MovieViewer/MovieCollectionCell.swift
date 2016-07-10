//
//  MovieCollectionCell.swift
//  MovieViewer
//
//  Created by Dang Quoc Huy on 7/1/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var posterView: UIImageView!
    
    func setData(movie: Movie) {
        
        if let posterUrl = movie.getPosterURLBySize(PosterSize.W154) {
            
            let request = NSURLRequest(URL: posterUrl)
            posterView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) in
                
                // image come frome cache
                if response == nil {
                    self.posterView.image = image
                    // image come from network
                } else {
                    self.posterView.setImageWithFadeIn(image)
                }
                }, failure: { (request, response, error) in
                    
                    // process error here
                    debugPrint(error.localizedDescription)
            })
        }
    }
    
    func setTheme() {
        
        // clear cell background to get rid of WHITE background by default
        backgroundColor = UIColor.clearColor()
        // config cell selected background
        let customSelectionView = UIView(frame: frame)
        customSelectionView.backgroundColor = themeColor
        selectedBackgroundView = customSelectionView
    }
}
