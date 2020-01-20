//
//  OMDB.swift
//  OMDBDemo
//
//  Created by Amit Mishra K. on 19/01/20.
//  Copyright © 2020 mishra. All rights reserved.
//

import UIKit
class OMDB: NSObject {
    
    private let base_url = "https://www.omdbapi.com/?apikey=d062a57d"
    
    override init(){
        
    }
    static let shared : OMDB = {
        let instance = OMDB()
        return instance
    }()
    
   //MARK:- API CALLS
    func fetchMovies(withName searchText: String, completion: @escaping(Result<Search, Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=d062a57d&s=\(searchText)"

        guard let movieURL = URL(string: urlString) else {
            return
        }

        let dataTask = URLSession.shared.dataTask(with: movieURL, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                completion(.failure(error!))
                return
            }

            do {
                // Decode the json data.
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(Search.self, from: data)
                completion(.success(searchResults))
            } catch {
                completion(.failure(error))
            }
        })

        dataTask.resume()
    }
    
    func getMovieDetails(withID: String, completion: @escaping(Result<MovieDetails, Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=d062a57d&i=\(withID)"

        guard let movieDetailsURL = URL(string: urlString) else {
            return
        }

        let dataTask = URLSession.shared.dataTask(with: movieDetailsURL, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil, response != nil else {
                completion(.failure(error!))
                return
            }

            do {
                // Decode the json data.
                let decoder = JSONDecoder()
                let searchResults = try decoder.decode(MovieDetails.self, from: data)
                completion(.success(searchResults))
            } catch {
                completion(.failure(error))
            }
        })

        dataTask.resume()
    }
}
