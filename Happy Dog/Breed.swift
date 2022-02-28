//
//  Breed.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 2/27/22.
//

import Foundation

struct HeightWeight: Codable {
    let imperial: String
    let metric: String
}

struct Image: Codable {
    let id: String
    let width: Int
    let height: Int
    let url: String
}

struct Breed: Codable {
    let weight: HeightWeight
    let height: HeightWeight
    let id: Int
    let name: String
    let bred_for: String?
    let breed_group: String?
    let life_span: String
    let temperament: String?
    let origin: String?
    let reference_image_id: String
    let image: Image
}
