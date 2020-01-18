//
//  ArticalDetailsController.swift
//  MaticNetwork
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import UIKit


class ArticalDetailsController: UIViewController {
    
    var articalViewModel: ArticleViewModel? {
        didSet {
            newsImage.sd_setImage(with: URL(string: articalViewModel?.urlToImage ?? ""), completed: nil)
            titleLabel.text = articalViewModel?.title
            authorLabel.text = articalViewModel?.author
            if let dateString = articalViewModel?.publishedAt {
                let date = Date.getFormattedDate(string: dateString, formatter: "MMM dd, yyyy")
                timestampLabel.text = date
            }
            descriptionLabel.text = articalViewModel?.description
            contentLabel.text = articalViewModel?.content
            
        }
    }
    
    let scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        return scroll
    }()
    
    let contentView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    let newsImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 33.0/255.0, green: 73.0/255.0, blue: 88.0/255.0, alpha: 1)
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 33.0/255.0, green: 73.0/255.0, blue: 88.0/255.0, alpha: 1)
        return label
    }()
    
    let timestampLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 33.0/255.0, green: 73.0/255.0, blue: 88.0/255.0, alpha: 1)
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 33.0/255.0, green: 73.0/255.0, blue: 88.0/255.0, alpha: 1)
        return label
    }()
    
    let contentLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 33.0/255.0, green: 73.0/255.0, blue: 88.0/255.0, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Detail"
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [newsImage, authorLabel, titleLabel, timestampLabel, descriptionLabel,  contentLabel].forEach({contentView.addSubview($0)})
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, size: .init(width: view.frame.width, height: 0))
        
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, size: .init(width: view.frame.width, height: 0))
        
        newsImage.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, size: .init(width: 0, height: 300))
        
        titleLabel.anchor(top: newsImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        
        timestampLabel.anchor(top: titleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 40))
        
        authorLabel.anchor(top: timestampLabel.topAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: timestampLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8), size: .init(width: 0, height: 40))
        
        descriptionLabel.anchor(top: authorLabel.bottomAnchor, leading: authorLabel.leadingAnchor, bottom: nil, trailing: timestampLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
        contentLabel.anchor(top: descriptionLabel.bottomAnchor, leading: descriptionLabel.leadingAnchor, bottom: contentView.bottomAnchor, trailing: descriptionLabel.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 16, right: 0))
        contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
    }
    
    
    
}
