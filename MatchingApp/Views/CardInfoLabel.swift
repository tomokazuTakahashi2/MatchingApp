//
//  CardInfoLabel.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/11.
//

import UIKit

class CardInfoLabel: UILabel {
    
    //good/nopeラベル
    init(frame: CGRect, labelText: String, labelColor: UIColor) {
        super.init(frame: frame)
        
        font = .boldSystemFont(ofSize: 45)
        textColor = labelColor
        text = labelText
        
        //枠線
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
    }
    
    //その他のラベル
    init(frame: CGRect, labelText: String, labelFont: UIFont) {
        super.init(frame: frame)
        
        font = labelFont
        textColor = .white
        text = labelText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
