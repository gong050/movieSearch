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

    @IBOutlet weak var bookmarkIcon: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    
    var movie : Movie! {
        // Задаем сеттер для записи информации в аутлеты
        didSet {
            movieTitle.text = movie.title
            movieOverview.numberOfLines = 10 // если бы я знал, чем это заменить - я бы это заменил.
            movieOverview.text = movie.overview
            if let moviePosterPath = movie.poster {
                moviePoster.af_setImage(withURL: URL(string: moviePosterPath)!)
            }
            if movie.bookmark == "NO" {
                bookmarkIcon.image = nil
            } else {
                bookmarkIcon.image = UIImage(named: "favourites")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
