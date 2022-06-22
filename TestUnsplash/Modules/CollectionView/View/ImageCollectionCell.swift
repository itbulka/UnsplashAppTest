//
//  ImageCollectionCell.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 20.06.2022.
//

import UIKit
import SDWebImage

class ImageCollectionCell: UICollectionViewCell {
    static let identifier = "ImageCollectionCell"
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        image.frame = contentView.bounds
    }
    
    func configureCell(_ with: String) {
        guard let url = URL(string: with) else { return }
        image.sd_setImage(with: url)
    }
    
}
