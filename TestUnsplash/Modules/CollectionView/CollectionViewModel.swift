//
//  CollectionViewModel.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 21.06.2022.
//

import Foundation


protocol CollectionViewModelProtocol {
    var dataSource: [UnsplashModel] { get set }
    var reloadCollection: Binding<Bool> { get set }
    func search(_ query: String, completion: @escaping ([UnsplashModel]?) -> Void)
}

class CollectionViewModel: CollectionViewModelProtocol {
    var dataSource: [UnsplashModel]  = [UnsplashModel]()
    var reloadCollection = Binding(false)
    
    
    init() {
        getPhotos()
    }
    
    func getPhotos() {
        NetworkManager.shared.request(routes: .RandomImages, endpoing: .Count, value: "30") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let photos = try? decoder.decode([UnsplashModel].self, from: data) else { return }
                self.dataSource = photos
                self.reloadCollection.value = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func search(_ query: String, completion: @escaping ([UnsplashModel]?) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        NetworkManager.shared.request(routes: .SearchImage, endpoing: .Query, value: query) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let photos = try? decoder.decode(SearchPhotos.self, from: data) else { return }
                completion(photos.results)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
}
