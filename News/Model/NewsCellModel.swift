//
//  NewsCellModel.swift
//  News
//
//  Created by Ramazan Abdullayev on 18.05.21.
//

import Foundation

class NewsCellModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    let imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}
