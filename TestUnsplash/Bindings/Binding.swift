//
//  Binding.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 22.06.2022.
//

import Foundation

class Binding<T> {
    private var listener: ((T) -> Void)?
    
    func bind(_ listener: ((T) -> Void)?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
