//
//  UITextView_Extension.swift
//  Poster
//
//  Created by Akif Acar on 22.04.2022.
//

import UIKit


extension UITextView {
    /**
    This method is used to add Done button to keyboard to dismiss when the text entering is finished.
    */
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 45.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
