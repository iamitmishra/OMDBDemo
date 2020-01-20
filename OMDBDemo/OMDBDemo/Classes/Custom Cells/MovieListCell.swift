//
//  MovieListCell.swift
//  OMDBDemo
//
//  Created by Amit Mishra K. on 19/01/20.
//  Copyright © 2020 mishra. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
  
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblYear: UILabel!
  @IBOutlet weak var imgMovie: UIImageView!
  
  var item: Movie? = nil {
    didSet {
      if let item = item {
       lblTitle.text = item.title
        lblYear.text = item.year
      } else {
        lblTitle.text = ""
        lblYear.text = ""
      }
    }
  }
}
