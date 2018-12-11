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
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movie : Movie! {
        didSet {
            movieTitle.text = movie.title
            movieOverview.text = movie.overview
            if let moviePosterPath = movie.poster {
                moviePoster.af_setImage(withURL: URL(string: moviePosterPath)!)
            }
        }
    }
    
}
