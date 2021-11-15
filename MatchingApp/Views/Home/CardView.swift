//
//  CardView.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/11.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    private let cardImageView = CardImageView(frame: .zero)
    //↑に替わる
//    let cardImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.backgroundColor = .blue
//        iv.layer.cornerRadius = 10
//        iv.contentMode = .scaleAspectFill
//        iv.image = UIImage(named: "image1")
//        iv.clipsToBounds = true
//       return iv
//    }()
    
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    //↑に替わる
//    let infoButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
//        button.tintColor = .white
//        button.imageView?.contentMode = .scaleAspectFit
//        return button
//    }()
    
    private let nameLabel = CardInfoLabel(font: .systemFont(ofSize: 40, weight: .heavy))
    //↑に替わる
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 40, weight: .heavy)
//        label.textColor = .white
//        label.text = "Taro, 22"
//        return label
//    }()
    
    private let residenceLabel = CardInfoLabel(font: .systemFont(ofSize: 20, weight: .regular))
    //↑に替わる
//    let residenceLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 20, weight: .regular)
//        label.textColor = .white
//        label.text = "日本、大阪"
//        return label
//    }()
    
    private let hobbyLabel = CardInfoLabel(font: .systemFont(ofSize: 25, weight: .regular))
    //↑に替わる
//    let hobbyLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 25, weight: .regular)
//        label.textColor = .white
//        label.text = "ランニング"
//        return label
//    }()
    
    private let introductionLabel = CardInfoLabel(font: .systemFont(ofSize: 25, weight: .regular))
    //↑に替わる
//    let introductionLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 25, weight: .regular)
//        label.textColor = .white
//        label.text = "走り回るのが大好きです"
//        return label
//    }()
    
    private let goodLabel = CardInfoLabel(text: "GOOD", textColor: .rgb(red: 137, green: 223, blue: 86))
    //↑に替わる
//    let goodLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 45)
//        label.textColor = .rgb(red: 137, green: 223, blue: 86)
//        label.text = "GOOD"
//
//        //枠線
//        label.layer.borderWidth = 3
//        label.layer.borderColor = UIColor.rgb(red: 137, green: 223, blue: 86).cgColor
//        label.layer.cornerRadius = 10
//
//        label.textAlignment = .center
//        label.alpha = 0
//        return label
//    }()
    
    private let nopeLabel = CardInfoLabel(text: "NOPE", textColor: .rgb(red: 222, green: 110, blue: 110))
    //↑に替わる
//    let nopeLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 45)
//        label.textColor = .rgb(red: 222, green: 110, blue: 110)
//        label.text = "NOPE"
//
//        //枠線
//        label.layer.borderWidth = 3
//        label.layer.borderColor = UIColor.rgb(red: 222, green: 110, blue: 110).cgColor
//        label.layer.cornerRadius = 10
//
//        label.textAlignment = .center
//        label.alpha = 0
//        return label
//    }()
    
    init(user: User) {
        super.init(frame: .zero)
        
        setupLayout(user: user)
        setupGradientLayer()
        
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(pangesture)
    }
    
    //グラデーション
    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.3, 1.1] //0.3(上から３割の位置)〜1.1（底辺（1.0）ちょい過ぎ）
        cardImageView.layer.addSublayer(gradientLayer)
    }
    
    //グラデーションレイヤーの大きさ
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: self)
        guard let view = gesture.view else { return }
        
        //指で触ったら
        if gesture.state == .changed {
            self.handlePanChange(translation: translation)
        //指を離したら
        } else if gesture.state == .ended {
            self.handlePanEnded(view: view, translation: translation)
        }
    }
    //カードの動き方
    private func handlePanChange(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 100 //円周率
        
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        
        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        
        //カードが右に行ったらGOODを表示
        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        //カードが左にいったらNOPEを表示
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
    }
    
    //指を離した時の動き(斜め下へ消える)
    private func handlePanEnded(view: UIView, translation: CGPoint) {
        
        if translation.x <= -120 {
            view.removeCardViewAnimation(x: -600)
            //↑に替わる
//            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
//
//                let degree: CGFloat = -600 / 40
//                let angle = degree * .pi / 180
//
//                let rotateTranslation = CGAffineTransform(rotationAngle: angle)
//                view.transform = rotateTranslation.translatedBy(x: -600, y: 100)
//                self.layoutIfNeeded()
//
//            } completion: { _ in
//                self.removeFromSuperview()
//            }
            
        } else if translation.x >= 120 {
            view.removeCardViewAnimation(x: 600)
            //↑に替わる
//            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
//
//                let degree: CGFloat = 600 / 40
//                let angle = degree * .pi / 180
//
//                let rotateTranslation = CGAffineTransform(rotationAngle: angle)
//                view.transform = rotateTranslation.translatedBy(x: 600, y: 100)
//                self.layoutIfNeeded()
//
//            } completion: { _ in
//                self.removeFromSuperview()
//            }
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: []) {
                self.transform = .identity //定位置に戻る
                self.layoutIfNeeded()
                //指を離したらアルファ値を０にする
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }
    }
    
    private func setupLayout(user: User) {
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        baseStackView.axis = .horizontal
        
        //viewの配置を作成
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)
        
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20,leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 20)
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 20)
        
        //ユーザー情報をviewに反映
        nameLabel.text = user.name
        introductionLabel.text = user.introduction
        hobbyLabel.text = user.hobby
        residenceLabel.text = user.residence
        
        //カードにプロフィール画像を反映
        if let url = URL(string: user.profileImageUrl) {
            cardImageView.sd_setImage(with: url) //SDWebImageで画像を表示
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
