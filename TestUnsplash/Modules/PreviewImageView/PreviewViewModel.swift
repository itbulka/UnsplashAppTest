//
//  PreviewViewModel.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 21.06.2022.
//

import Foundation

protocol PreviewViewModelProtocol {
    var titleText: Binding<String> { get set }
    var reloadView: Binding<Bool> { get set }
    func clickButton()
}

class PreviewViewModel: PreviewViewModelProtocol {
    
    var photo: UnsplashModel
    
    var titleText = Binding("Добавить")
    var reloadView = Binding(false)
    
    init(_ photo: UnsplashModel) {
        self.photo = photo
        
    }
    
    func clickButton() {
        let index = likesImages.firstIndex(where: {$0 == photo })

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let index = index {
                likesImages.remove(at: index)
                self.titleText.value = "Добавить"
            } else {
                likesImages.append(self.photo)
                self.titleText.value = "Удалить"
            }
            self.reloadView.value = true
        }
    }
}
