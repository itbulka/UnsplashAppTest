//
//  SearchPhotos.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 22.06.2022.
//

import Foundation

struct SearchPhotos: Decodable {
    let total: Int?
    let results: [UnsplashModel]?
}
