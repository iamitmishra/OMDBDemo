//
//  OmdbMoviesListController.swift
//  OMDBDemo
//
//  Created by Amit Mishra K. on 19/01/20.
//  Copyright © 2020 mishra. All rights reserved.
//

import UIKit

class OmdbMoviesListController: UIViewController {

    @IBOutlet weak var movieListTableView: UITableView!
    var movies: [Movie] = []
    var searchText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigatioonBar()
    }
    // MARK: Back Button

    func setupNavigatioonBar() {
        let button = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem  = button
        self.navigationItem.title = searchText

    }

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

 // MARK: User Defined functions

    func showOmdbMovieDetailController(_ result: MovieDetails) {
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let omdbMovieDetailController = storyBoard.instantiateViewController(withIdentifier: "OmdbMovieDetailController") as! OmdbMovieDetailController
            omdbMovieDetailController.movieDetails = result
            self.navigationController?.pushViewController(omdbMovieDetailController, animated: true)
        }
    }

    // MARK: Alerts

    func showUnableToLoadAlert() {
        let alert = UIAlertController(title: "Unknown Failure.", message: "Unable to load the movie details. Please try again.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

}

// MARK: UITableViewDataSource
extension OmdbMoviesListController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return movies.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
         let currentMovie = movies[indexPath.row]

          cell.lblTitle.text = currentMovie.title
         cell.lblYear.text = currentMovie.year

         if
             let posterURL = URL(string: currentMovie.poster) {
             DispatchQueue.global().async {
                 if let data = try? Data(contentsOf: posterURL) {
                     let image = UIImage(data: data)
                     DispatchQueue.main.async {
                         cell.imgMovie?.image = image
                         cell.setNeedsLayout()
                     }
                 }
             }
         }
         return cell
     }
}

// MARK: UITableViewDelegate
extension OmdbMoviesListController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let selectedMovie = movies[indexPath.row]

    OMDB.shared.getMovieDetails(withID: selectedMovie.imdbID) { (result) in
         switch result {
                 case .success(let searchResults):
                     // Populate data on next view controller
                     self.showOmdbMovieDetailController(searchResults)
                 case .failure( _):
                     // Show Error alert
                     DispatchQueue.main.async {
                       self.showUnableToLoadAlert()
                     }
                 }
    }
  }

}

