//
//  ListFavoriteViewController.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 20.06.2022.
//

import UIKit

protocol FavoriteListDelegate {
    func reloadView()
}

class ListFavoriteViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.register(FavoriteViewCell.self, forCellReuseIdentifier: FavoriteViewCell.identifier)
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Любимые изображения"
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ListFavoriteViewController: UITableViewDelegate, UITableViewDataSource, FavoriteListDelegate {

    func reloadView() {
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likesImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteViewCell.identifier, for: indexPath) as? FavoriteViewCell else { return UITableViewCell()}
        
        cell.configure(likesImages[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let previewImage = PreviewImageViewController()
        previewImage.configure(likesImages[indexPath.row])
        previewImage.listFavoriteDelegate = self
        
        present(previewImage, animated: true)
    }
    
    
}
