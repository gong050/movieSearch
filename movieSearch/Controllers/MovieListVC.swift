//
//  MovieListVC.swift
//  movieSearch
//
//  Created by Alex Kustov on 25/11/2018.
//  Copyright © 2018 Alex Kustov. All rights reserved.
//

import UIKit
import Alamofire

let apiKey = "fb67545d44e4cb12c97ecbc280e9bd21"

class MovieListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesList: [Movie]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendRequest()
    }
    
    /*
     Выполняем запрос в TMDB для получения JSON со списком фильмов.
     Для написания запросов была использована библиотека Alamofire.
    */
    func sendRequest() {
        Alamofire.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)", method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                print("ERROR: Unable to hit the API with status code: \(String(describing: response.result.error))")
                return
            }
        
            guard let arrayOfMovies = response.result.value as? [NSDictionary]
                else {
                    print("ERROR: Error with type transformation with status code: \(String(describing: response.result.error))");
                    return
            }
            
            let movieObj = Movie()
            movieObj.movies(array: arrayOfMovies)
            
            self.tableView.reloadData()
        }
    }

}
