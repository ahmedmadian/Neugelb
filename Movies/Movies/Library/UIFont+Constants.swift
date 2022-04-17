//
//  UIFont+Constants.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import UIKit

extension UIFont {
    /** SFUIText 17.0 */
    static let LABEL = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    /** SFUIText 15.0 */
    static let LABEL_SMALL = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    private func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: 0)
    }
}
