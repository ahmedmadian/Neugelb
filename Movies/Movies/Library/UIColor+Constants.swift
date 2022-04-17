//
//  UIColor+Constants.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import UIKit

extension UIColor {
    enum Neugelb {
        enum Text {
            static let TEXT_PRIMARY: UIColor = .black
        }

        enum Background {
            static let PRIMARY: UIColor = UIColor(red: 240 / 255, green: 238 / 255, blue: 235 / 255, alpha: 1)
            static let SURFACE: UIColor = .white
        }

        enum Highlight {
            static let PRIMARY: UIColor = .systemBlue
        }
    }
}
