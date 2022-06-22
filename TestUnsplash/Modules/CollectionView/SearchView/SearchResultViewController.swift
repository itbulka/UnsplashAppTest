//
//  SearchResultViewController.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 21.06.2022.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var photos: [UnsplashModel] = [UnsplashModel]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 28, height: UIScreen.main.bounds.width / 3 - 28)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillLayoutSubviews() {
        layoutCollectionView()
    }
    
    private func layoutCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ])
    }

    func configure(_ photos: [UnsplashModel]) {
        self.photos = photos
        collectionView.reloadData()
    }

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as? ImageCollectionCell else { return UICollectionViewCell() }
        guard let url = photos[indexPath.row].urls?.regular else { return UICollectionViewCell() }
        cell.configureCell(url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let photo = photos[indexPath.row]
        let previewVC = PreviewImageViewController()
        previewVC.configure(photo)
        
        present(previewVC, animated: true)
    }
    
    
}
