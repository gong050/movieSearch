//
//  MovieDetailVC.swift
//  movieSearch
//
//  Created by a.kustov on 12/12/2018.
//  Copyright © 2018 Alex Kustov. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MovieDetailVC: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movie: Movie?
    let realmObject = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Добавляем в навигацию кнопку .bookmarks. При нажатии срабатывает функция addToBookmarks
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addToBookmarks))
        
        if movie?.bookmark == "NO" {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        } else {
            navigationItem.rightBarButtonItem?.tintColor = UIColor.green
        }
        
        // Заполняем данными поля.
        movieTitle.numberOfLines = 3 // Если бы я знал, как это заменить, то я бы это заменил
        self.movieTitle.text = movie?.title
        movieOverview.numberOfLines = 60 // Аналогично
        self.movieOverview.text = movie?.overview
        self.movieDate.text = "Release date: " + (movie?.release_date)! // В идеале, надо было проверки делать на все приходящие данные, чтобы не было таких интересных конструкций (_?._)!
        
        if let moviePosterPath = movie?.poster {
            moviePoster.af_setImage(withURL: URL(string: moviePosterPath)!)
        }
    }
    
    /*
        Xcode попросил добавить @objc. Я не стал сопротивляться
        При нажатии на кнопку bookmark меняем состояние movie.bookmark и меняет цвет кнопки bookmark
     */
    @objc func addToBookmarks() {
        if movie!.bookmark == "NO" {
            try! realmObject.write {
                movie?.bookmark = "YES"
                navigationItem.rightBarButtonItem?.tintColor = UIColor.green
            }
        } else {
            try! realmObject.write {
                movie?.bookmark = "NO"
                navigationItem.rightBarButtonItem?.tintColor = UIColor.red
            }
        }
    }

}

/*
 Делегируем обязанности UIScrollView.
 Чтобы при большом описании фильма была возможность скроллить
 */

extension MovieDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}
