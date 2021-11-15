//
//  ProfileImageView.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/14.
//

import UIKit

class ProfileImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        self.image = UIImage(named: "no_image")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 90
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
