//
//  CardImageView.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/11.
//

import UIKit

class CardImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        //image = UIImage(named: "image1")
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
