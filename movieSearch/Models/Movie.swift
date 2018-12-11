//
//  Movie.swift
//  movieSearch
//
//  Created by Alex Kustov on 25/11/2018.
//  Copyright © 2018 Alex Kustov. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    var poster: String? = nil
    var title: String? = nil
    var overview: String? = nil
    var release_date: String? = nil
    
    /*
     Инициализация модели данных Movie
     На вход принимаем словарь (JSON)
     */
    
    public func newMovie(dictionary: NSDictionary) -> Movie {
        let movie = Movie()
        
        if let posterUrl = dictionary["poster_path"] as? String {
            movie.poster = posterUrl
        } else {
            movie.poster = nil
        }
        
        movie.title = dictionary["title"] as? String
        movie.overview = dictionary["overview"] as? String
        movie.release_date = dictionary["release_date"] as? String
        
        return movie
    }
    
    /*
     Функция, возвращающая массив объектов класса Movie
     На вход принимаем массив словарей, которые поэлементно отправляем в метод newMovie() для инициализации объектов Movie
     */
    
    public func movies(array: [NSDictionary]) -> [Movie] {
        var movies = [Movie]()
        
        for dictionary in array {
            let movie = newMovie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
}
