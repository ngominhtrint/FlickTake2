//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Dang Quoc Huy on 6/30/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterView.layer.cornerRadius = 5
        posterView.clipsToBounds = true
    }

    func setData(movie: Movie) {
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        if let posterUrl = movie.getPosterURLBySize(PosterSize.W154) {
            
            let request = NSURLRequest(URL: posterUrl)
            posterView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) in
                
                // image come frome cache
                if response == nil {
                    self.posterView.image = image
                    // image come frome network
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
        
        titleLabel.textColor = UIColor.whiteColor()
        overviewLabel.textColor = UIColor.whiteColor()
        
        // clear cell background to get rid of WHITE background by default
        backgroundColor = UIColor.clearColor()
        // config cell selected background
        let customSelectionView = UIView(frame: frame)
        customSelectionView.backgroundColor = themeColor
        selectedBackgroundView = customSelectionView
    }
}
