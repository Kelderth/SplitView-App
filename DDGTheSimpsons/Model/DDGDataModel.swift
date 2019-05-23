//
//  DDGDataModel.swift
//  DDGTheSimpsons
//
//  Created by Eduardo Santiz on 5/20/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import Foundation

struct DDGDataModel: Decodable {
    var relatedTopics: [CharacterDetail]
    
    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
    }
    
    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        
        self.relatedTopics = try container.decodeIfPresent([CharacterDetail].self, forKey: .relatedTopics) ?? []
    }
}

struct CharacterDetail: Decodable {
    let firstURL: String
    let text: String
    var icon: Multimedia?
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case text = "Text"
        case icon = "Icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.firstURL = try container.decodeIfPresent(String.self, forKey: .firstURL) ?? "N/A"
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? "N/A"
        self.icon = try container.decodeIfPresent(Multimedia.self, forKey: .icon) ?? nil
    }
}

struct Multimedia: Decodable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "URL"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? nil
    }
}
