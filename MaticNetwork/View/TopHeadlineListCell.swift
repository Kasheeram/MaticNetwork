//
//  TopHeadlineListCell.swift
//  MaticNetwork
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
     var cornerRadius: CGFloat = 5
     var shadowOffSetWidth: CGFloat = 0
     var shadowOffSetHeight: CGFloat = 1.5
     var shadowColor: UIColor = UIColor.lightGray
     var shadowRadius : CGFloat = 3.0
     var shadowOpacity: CGFloat = 1.0
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = Float(shadowOpacity)
    }
}



class TopHeadlineListCell: UICollectionViewCell {
    
    var article: ArticleViewModel? {
        didSet {
            titleLabel.text = article?.title
            newsImage.sd_setImage(with: URL(string: article?.urlToImage ?? ""), completed: nil)
        }
    }
    
    let cardView: CardView = {
        let view = CardView()
        view.backgroundColor = Colors.cardViewBGR
        return view
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 33.0/255.0, green: 73.0/255.0, blue: 88.0/255.0, alpha: 1)
        return label
    }()
    
    let newsImage:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
       return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.cardCellBGR
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(newsImage)
        cardView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0 , left: 10, bottom: 0, right: 10))
        
        titleLabel.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 50))
        
        newsImage.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: cardView.bottomAnchor, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 16, right: 0))
        
    }
}
