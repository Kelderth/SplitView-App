//
//  DDGViewModel.swift
//  DDGTheSimpsons
//
//  Created by Eduardo Santiz on 5/20/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import Foundation

class DDGViewModel {
    let ns = NetworkService()
    let baseURL = "https://api.duckduckgo.com/?q=simpsons+characters&format=json"
    
    var model: DDGDataModel?
    
    var arrayWithData: [CharacterDetail] = [CharacterDetail]()
    
    func downloadJSON(completion: @escaping () -> Void) {
        ns.downloadData(from: baseURL) { (jsonData) in
            if let jsonData = jsonData {
                do {
                    let dataDecoded = try JSONDecoder().decode(DDGDataModel.self, from: jsonData)
                    
                    self.model = dataDecoded
                    completion()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func fillArrayWithData() {
        self.arrayWithData = model?.relatedTopics ?? []
    }
    
    func getArrayWithDataSize() -> Int? {
        return self.arrayWithData.count
    }
    
    func getCharactersName(index: Int) -> String? {
        let text = self.arrayWithData[index].text
        let characterName = text.components(separatedBy: " - ")
        
        return characterName[0]
    }
}
