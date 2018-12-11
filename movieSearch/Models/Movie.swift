//
//  Movie.swift
//  movieSearch
//
//  Created by a.kustov on 11/12/2018.
//Copyright © 2018 Alex Kustov. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Movie: Object {
    
    @objc dynamic var poster: String? = nil
    @objc dynamic var title: String? = nil
    @objc dynamic var overview: String? = nil
    @objc dynamic var release_date: String? = nil
    
    
    /*
     Инициализация модели данных Movie
     На вход принимаем словарь (JSON)
     */
    
    public func newMovie(dictionary: [String: Any]) -> Movie {
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
    
    public func movies(array: [String: Any]) -> [Movie] {
        var movies = [Movie]()
        
        guard let moviesInput = array["results"] as? [[String: Any]] else {
            print("ERROR: Error with convertation result array")
            return movies
        }
        
        for movie in moviesInput {
            /*
            print("=================================")
            print(movie)
            print("=================================")
            */
            let movieAdd = newMovie(dictionary: movie)
            
            try! realmObject.write() {
                realmObject.add(movieAdd)
                print("New movie: \(movieAdd.title)")
                movies.append(movieAdd)
            }
            
        }
        return movies
    }
}
