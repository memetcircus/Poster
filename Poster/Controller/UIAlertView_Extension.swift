//
//  UIAlertView_Extension.swift
//  Poster
//
//  Created by Akif Acar on 23.04.2022.
//

import UIKit


extension UIAlertController {

    /**
    This method is used to set custom background color of UIAlertController
    - parameter : type 'UIColor' is the desired color of the alertview's background
    */
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }

    /**
    This method is used to set custom message font type and message color
    - parameter : type 'UIFont' is the desired font type for the alertview's message
    - parameter : type 'UIColor' is the desired color for the alertview's message
    */
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }

        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
}
