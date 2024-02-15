//
//  Transformation.swift
//  Practica_Fundamentos_IOS
//
//  Created by Daniel Serrano on 9/11/23.
//

import UIKit

public typealias Transformations = [Transformation]

public struct Transformation: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case hero
        case photo
        
    }
    public let id : String?
    public let name: String?
    public let description: String?
    public let hero: Hero?
    public let photo: String?
    
    public init(id: String?, name: String?, description: String?, hero: Hero?, photo: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.photo = photo
        self.hero = hero
    }
}
