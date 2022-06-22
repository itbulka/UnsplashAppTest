//
//  UnsplashModel.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 21.06.2022.
//

import Foundation

struct UnsplashModel: Decodable, Equatable {
    static func == (lhs: UnsplashModel, rhs: UnsplashModel) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
    let id: String?
    let createdAt: String?
    let updatedAt: String?
    let width: Int?
    let height: Int?
    let urls: UrlKind?
    let location: LocationImage?
    let likes: Int?
    let downloads: Int?
    let user: User?
    
}

struct UrlKind: Decodable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String

}

struct LocationImage: Decodable {
    let title: String?
}


struct User: Decodable {
    let username: String?
    
}
