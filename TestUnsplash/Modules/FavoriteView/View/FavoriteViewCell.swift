//
//  FavoriteViewCell.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 20.06.2022.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    
    static let identifier = "FavoriteViewCell"
    
    private var imageFavorite: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Vladimir Povalskij"
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageFavorite)
        contentView.addSubview(authorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        layoutUIElements()
    }
    
    private func layoutUIElements() {
        NSLayoutConstraint.activate([
            imageFavorite.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageFavorite.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14),
            imageFavorite.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            imageFavorite.widthAnchor.constraint(equalToConstant: 60),
            authorLabel.leftAnchor.constraint(equalTo: imageFavorite.rightAnchor, constant: 20),
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            authorLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            authorLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    func configure(_ with: UnsplashModel) {
        guard let urlString = with.urls?.regular else { return }
        guard let url = URL(string: urlString) else { return }
        imageFavorite.sd_setImage(with: url)
        authorLabel.text = with.user?.username ?? "Unknown"
    }

}
