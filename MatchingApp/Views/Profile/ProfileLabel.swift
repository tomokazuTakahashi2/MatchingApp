//
//  ProfileLabel.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/14.
//

import UIKit

class ProfileLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: 45, weight: .bold)
        self.textColor = .black
    }
    
    //infoCollectionViewのtitleLabel
    init(title: String) {
        super.init(frame: .zero)
        
        self.text = title
        self.font = .systemFont(ofSize: 14)
        self.textColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
