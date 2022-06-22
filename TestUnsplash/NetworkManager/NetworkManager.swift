//
//  NetworkManager.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 21.06.2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private var defaultUrl: String { get { "https://api.unsplash.com/" } }
    private var accessToken: String { get { "tpXOWU1SIY07L2KDJH2CstZECmg9cVU7IxSTPW5wBXo" } }
    
    enum Routes: String {
        case RandomImages = "photos/random"
        case SearchImage = "search/photos"
    }
    
    enum Endpoint: String {
        case Count = "count"
        case Query = "query"
    }
    
    //MARK: При выборе endpoint 'Count' в параметр value указывается количество рандомных фотографий
    //MARK: При Query передается строка поиска 
    func request(routes: Routes, endpoing: Endpoint, value: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = URL(string: "\(defaultUrl)/\(routes.rawValue)?client_id=\(accessToken)&\(endpoing.rawValue)=\(value)") else { return }
        
        let requst = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requst) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {  return }
            
            completion(.success(data))
            

        }.resume()
    }
    
}
