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
    
    // К хвосту baseImageURL прибавляем адрес на определенную картинку
    let baseImageURL = "http://image.tmdb.org/t/p/w500"
    
    /*
     Инициализация модели данных Movie
     На вход принимаем массив (JSON) [key: value], в котором находится информация о фильме.
     */
    
    public func newMovie(json: [String: Any]) -> Movie {
        let movie = Movie()
        
        if let posterUrl = json["poster_path"] as? String {
            movie.poster = baseImageURL + posterUrl
        } else {
            movie.poster = nil
        }
        
        movie.title = json["title"] as? String
        movie.overview = json["overview"] as? String
        movie.release_date = json["release_date"] as? String
        
        return movie
    }
    
    /*
     Функция, возвращающая массив объектов класса Movie
     На вход принимаем массив (JSON) фильмов [key: value], которые поэлементно отправляем
     в метод newMovie() для инициализации объектов Movie.
     */
    
    public func movies(array: [String: Any]) -> [Movie] {
        var movies = [Movie]()
        
        guard let moviesInput = array["results"] as? [[String: Any]] else {
            print("ERROR: Error with convertation result array")
            return movies
        }
        
        for movie in moviesInput {
            let movieAdd = newMovie(json: movie)
            
            try! realmObject.write() {
                realmObject.add(movieAdd)
                print("New movie: \(movieAdd.title), ImageURL: \(movieAdd.poster)")
                movies.append(movieAdd)
            }
            
        }
        return movies
    }
}
