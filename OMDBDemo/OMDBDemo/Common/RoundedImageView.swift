//
//  RoundedImageView.swift
//  OMDBDemo
//
//  Created by Amit Mishra K. on 20/01/20.
//  Copyright © 2020 mishra. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedImageView: UIImageView {
  
    @IBInspectable var cornerRadius: CGFloat = 0{
           didSet{
           self.layer.cornerRadius = cornerRadius
           }
       }
  

 
}
