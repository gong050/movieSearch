//
//  MovieTVCell.swift
//  movieSearch
//
//  Created by Alex Kustov on 25/11/2018.
//  Copyright © 2018 Alex Kustov. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieTVCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movie : Movie! {
        didSet {
            guard let title = movie.title else {
                return
            }
            movieTitle.text = title
            movieOverview.text = movie.overview
            if let moviePosterPath = movie.poster {
                moviePoster.af_setImage(withURL: URL(string: moviePosterPath)!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
