//
//  RegisterButton.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/12.
//

import UIKit

class RegisterButton: UIButton {
    
    //ボタンのハイライト
    override var isHighlighted: Bool {
        didSet {
            //タップしたら半透明になり、そうじゃない時は非透明
            self.backgroundColor = isHighlighted ? .rgb(red: 227, green: 48, blue: 0.2, alpha: 0.2) : .rgb(red: 227, green: 48, blue: 78)
        }
    }
    
    init() {
        super.init(frame: .zero)
        setTitle("登録", for: .normal)
        backgroundColor = .rgb(red: 227, green: 48, blue: 78)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
