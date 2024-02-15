//
//  Hero.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 6/11/23.
//

import UIKit

public typealias Heroes = [Hero]

public struct Hero: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case photo
        case isFavorite = "favorite"
    }

    public let id: String?
    public let name: String?
    public let description: String?
    public let photo: String?
    public let isFavorite: Bool?

    public init(id: String?, name: String?, description: String?, photo: String?, isFavorite: Bool?) {
        self.id = id
        self.name = name
        self.description = description
        self.photo = photo
        self.isFavorite = isFavorite
    }
}
