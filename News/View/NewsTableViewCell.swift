//
//  NewsTableViewCell.swift
//  News
//
//  Created by Ramazan Abdullayev on 18.05.21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let newsImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private let newsSubtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .light)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubtitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.frame.size.width - 170,
            height: 70
        )
        
        newsSubtitleLabel.frame = CGRect(
            x: 10,
            y: 70,
            width: contentView.frame.size.width - 170,
            height: contentView.frame.size.height / 2
        )
        
        newsImageView.frame = CGRect(
            x: contentView.frame.size.width - 150,
            y: 5 ,
            width: 140,
            height: contentView.frame.size.height - 10
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = nil
        newsTitleLabel.text = nil
        newsSubtitleLabel.text = nil
    }
    
    func configure(with viewModel: NewsCellModel) {
        newsTitleLabel.text = viewModel.title
        newsSubtitleLabel.text = viewModel.subtitle
        
        // Image
        if let data = viewModel.imageData {
            self.newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
