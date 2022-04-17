//
//  UIImageView + Caching.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    var activity: UIActivityIndicatorView  {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = .medium
        self.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerYAnchor.constraint(equalTo: centerYAnchor),
            activity.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        return activity
    }

    func showLoader() {
        self.bringSubviewToFront(activity)
        activity.isHidden = false
        activity.startAnimating()
    }

    func hideLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }

    func loadImageFromUrl(url: URL)  {
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = imageFromCache
            return
        }
        self.showLoader()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.hideLoader()
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
