//
//  CollectionImageViewController.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 20.06.2022.
//

import UIKit

class CollectionImageViewController: UIViewController {
    
    private var viewModel: CollectionViewModelProtocol = CollectionViewModel()
    
    private var searchConrtoller: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultViewController())
        search.searchBar.placeholder = "Search"
        search.searchBar.tintColor = .black
        search.searchBar.searchBarStyle = .minimal
        return search
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 28, height: UIScreen.main.bounds.width / 3 - 28)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.identifier)
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Изображения"
        
        navigationItem.searchController = searchConrtoller
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchConrtoller.searchResultsUpdater = self
        
        bindingViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        layoutCollectionView()
    }
    
    func bindingViewModel() {
        viewModel.reloadCollection.bind { isReload in
            if isReload {
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                    
                }
            }
        }
    }
    
    func layoutCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ])
    }


}

extension CollectionImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as? ImageCollectionCell else { return UICollectionViewCell()}
        
        guard let url = viewModel.dataSource[indexPath.row].urls?.regular else { return UICollectionViewCell() }
        cell.configureCell(url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let photo = viewModel.dataSource[indexPath.row]
        let previewVC = PreviewImageViewController()
        previewVC.configure(photo)
        
        present(previewVC, animated: true)
    }
    
}

extension CollectionImageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else { return }
            
        viewModel.search(query) { result in
            DispatchQueue.main.async {
                guard let result = result else { return }
                guard let resultConrtollers = searchController.searchResultsController as? SearchResultViewController else { return }
                resultConrtollers.configure(result)
            }
            
        }
        
    }
    
}

