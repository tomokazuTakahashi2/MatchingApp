//
//  CardInfoLabel.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/11.
//

import UIKit

class CardInfoLabel: UILabel {
    
    //good/nopeラベル
    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 45)
        self.textColor = textColor
        self.text = text
        
        //枠線
        layer.borderWidth = 3
        layer.borderColor = textColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
    }
    
    //その他のラベル
    init(font: UIFont) {
        super.init(frame: .zero)
        
        self.font = font
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
