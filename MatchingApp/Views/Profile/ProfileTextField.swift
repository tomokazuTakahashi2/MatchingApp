//
//  ProfileTextField.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/15.
//

import UIKit

class ProfileTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        self.borderStyle = .roundedRect
        self.placeholder = placeholder
        self.backgroundColor = .rgb(red: 245, green: 245, blue: 245)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
