//
//  OmdbSearchController.swift
//  OMDBDemo
//
//  Created by Amit Mishra K. on 19/01/20.
//  Copyright © 2020 mishra. All rights reserved.
//

import UIKit

class OmdbSearchController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    //MARK:- User Actions
    @IBAction func btnSearchClicked(_ sender: Any) {
        self.view.endEditing(true)
        // Check for the movie name
        guard let searchText = searchTextField.text else {
            showErrorAlert()
            return
        }

        if searchText == "" {
            showErrorAlert()
        } else {
            // TODO: Perform movie search
            //self.navigationItem.title = searchText
            OMDB.shared.fetchMovies(withName: searchText) { (result) in
                switch result {
                    case .success(let searchResults):
                        // Populate data on next view controller
                        self.showOmdbMoviesListController(searchResults)
                        break
                    case .failure( _):
                        // Show Error alert
                        DispatchQueue.main.async {
                            self.showSearchFailureAlert()
                        }
                        break
                }
            }
        }
    }
    
    func showOmdbMoviesListController(_ results: Search) {
          DispatchQueue.main.async {
              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let omdbMoviesListController = storyBoard.instantiateViewController(withIdentifier: "OmdbMoviesListController") as! OmdbMoviesListController
              omdbMoviesListController.movies = results.search
              omdbMoviesListController.searchText = self.searchTextField.text ?? ""
              self.navigationController?.pushViewController(omdbMoviesListController, animated: true)
          }
      }
    // MARK: Alerts
    func showErrorAlert() {
        let alert = UIAlertController(title: "Empty Text.", message: "Please enter the search text to search the movie.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    func showSearchFailureAlert() {
        let alert = UIAlertController(title: "Network failure", message: "Unable to load the movies. Please try again.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

}
