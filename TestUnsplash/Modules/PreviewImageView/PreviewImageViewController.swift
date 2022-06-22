//
//  PreviewImageViewController.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 20.06.2022.
//

import UIKit

class PreviewImageViewController: UIViewController {
    
    private var viewModel: PreviewViewModelProtocol?
    var listFavoriteDelegate: FavoriteListDelegate?
    
    private var photo: UnsplashModel?
    
    private var avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.layer.cornerRadius = 50
        avatar.layer.masksToBounds = true
        avatar.contentMode = .scaleAspectFill
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private var buttonLike: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = .white
        btn.setTitle("Добавить", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var downloadsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(avatarImage)
        view.addSubview(buttonLike)
        view.addSubview(authorLabel)
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        view.addSubview(downloadsLabel)
        
        guard let photo = photo else { return }
        viewModel = PreviewViewModel(photo)
        
        if likesImages.contains(where: { $0 == photo } ) {
            buttonLike.setTitle("Удалить", for: .normal)
        } else {
            buttonLike.setTitle("Добавить", for: .normal)
        }
        
        bindingViewModel()
        
        buttonLike.addTarget(self, action: #selector(selectedButton), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        layoutUIElement()
    }
    
    //MARK: Для обновления View
    
    func bindingViewModel() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.titleText.bind({ title in
                self?.buttonLike.setTitle(title, for: .normal)
            })
            self?.viewModel?.reloadView.bind({ isReload in
                if isReload {
                    self?.listFavoriteDelegate?.reloadView()
                }
            })
        }
    }
    
    private func layoutUIElement() {
        
        NSLayoutConstraint.activate([
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            buttonLike.widthAnchor.constraint(equalToConstant: 100),
            buttonLike.heightAnchor.constraint(equalToConstant: 30),
            buttonLike.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 30),
            buttonLike.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: buttonLike.bottomAnchor, constant: 20),
            authorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            authorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            authorLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12),
            downloadsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            downloadsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            downloadsLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    func configure(_ unsplashImage: UnsplashModel) {
        guard let urlString = unsplashImage.urls?.regular else { return }
        guard let url = URL(string: urlString) else { return }
        
        avatarImage.sd_setImage(with: url)
        authorLabel.text = unsplashImage.user?.username ?? "Unknown author"
        dateLabel.formatterDate(unsplashImage.createdAt)
        locationLabel.text = unsplashImage.location?.title ?? "Unknown location"
        downloadsLabel.text = "Downloads: \(unsplashImage.downloads ?? 0)"
        
        photo = unsplashImage
    }
    
    @objc func selectedButton() {
        viewModel?.clickButton()
    }
}


extension UILabel {
    func formatterDate(_ date: String?) {
        guard let date = date else {
            self.text = "Unknown date"
            return
        }

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-HH:mm"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterGet.date(from: date) {
            self.text = dateFormatterPrint.string(from: date)
        } else {
            self.text = "Unknown"
        }
    }
}
