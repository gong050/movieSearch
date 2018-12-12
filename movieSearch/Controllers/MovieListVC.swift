//
//  MovieListVC.swift
//  movieSearch
//
//  Created by Alex Kustov on 25/11/2018.
//  Copyright © 2018 Alex Kustov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Realm
import RealmSwift

let apiKey = "fb67545d44e4cb12c97ecbc280e9bd21"
let realmObject = try! Realm()

class MovieListVC: UIViewController {

    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //Объявляем массив объектов фильма для того, чтобы отображать его непосредственно в UITableViewCell
    var movieOnClient: [Movie]? = []
    var filteredMovieOnClient: [Movie]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realmObject = try! Realm()
        let dbMovies = realmObject.objects(Movie.self)
     
        /*
         Проверяем наличие фильмов в БД.
         Если их нет, то выполняем запрос в TMDB
         */
        
        if dbMovies.count > 0 {
            print("Found movies in Data Base")
            var movies = [Movie]()
            for movie in dbMovies {
                movies.append(movie)
            }
            movieOnClient = movies
        } else {
            // Да, в идеале нужно сделать пагинацию. В TMDB нет возможности принять, к примеру 100 фильмов.
            var count: Int = 1
            while count != 10 {
                sendRequest(page: count)
                count += 1
            }
        }
        
    }
    
    /*
     При переходе из MovieDetailVC в MovieListVC состояние tableView изменится,
     т.к. мы можем сделать определенный фильм избранным в MovieDetailVC, поэтому необходимо обновить
     состояние MovieListVC
     */
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    /*
     Функция выполняющая запрос в TMDB для получения JSON со списком фильмов.
     Для написания запросов была использована библиотека Alamofire.
    */
    
    func sendRequest(page: Int) {
        Alamofire.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&page=\(page)", method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                print("ERROR: Unable to hit the API with status code: \(String(describing: response.result.error))")
                return
            }
            
            guard let arrayOfMovies = response.result.value as? [String: Any] else {
                print("ERROR: Error with type transformation with status code: \(String(describing: response.result.error))");
                return
            }
            let movie = Movie()
            self.movieOnClient = movie.movies(array: arrayOfMovies)
            self.tableView.reloadData()
        }
    }
    
    // Сигвей на MovieDetailVC. При переходе передаем данные объекта определенной ячейки.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movieOnClient![indexPath!.row]
        
        let MovieDetailVC = segue.destination as! MovieDetailVC
        
        MovieDetailVC.movie = movie
        self.tableView.reloadData()
    }
    
}

//Делегируем обязанности UITableView

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieOnClient?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTVCell
        
        movieOnClient = movieOnClient!.sorted(by: { $0.bookmark! > $1.bookmark! })
        cell.movie = movieOnClient![indexPath.row]
        
        return cell
    }
}
