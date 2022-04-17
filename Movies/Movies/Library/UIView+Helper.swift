//
//  UIView+Helper.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import UIKit

extension UIView {
    func addSubview(_ view: UIView, translatesAutoresizingMaskIntoConstraints: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        addSubview(view)
    }
}
