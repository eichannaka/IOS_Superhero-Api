//
//  ApiNetwork.swift
//  API-SuperHero
//
//  Created by Eichan Nakagawa on 02/07/2025.
//

import Foundation

class ApiNetwork {
    
    struct Wrapper:Codable{
        let response:String
        let results:[SuperHero]
    }
    struct SuperHero:Codable, Identifiable{
        let id:String
        let name:String
        let image:ImageSuperhero
    }
    
    struct ImageSuperhero:Codable{
        let url:String
    }
    
//    --------------
    
    struct SuperheroCompleted:Codable{
        let id:String
        let name:String
        let image:ImageSuperhero
        let powerstats:Powerstats
        let biography:Biography
    }
    struct Powerstats:Codable{
        let intelligence:String
        let strength:String
        let speed:String
        let durability:String
        let power:String
        let combat:String
    }
    
    struct Biography:Codable{
        let alignment:String
        let publisher:String
        let aliases:[String]
        let fullName:String
        
        enum CodingKeys: String, CodingKey {
            case fullName = "full-name"
            case alignment
            case publisher
            case aliases
        }
    }
    
    func getHeroByQuery(query: String) async throws ->Wrapper{
        let url = URL(string: "https://superheroapi.com/api/9597cc4d1d4ba37e8c839b0be5188e0c/search/\(query)")!
        let (data,_) = try await URLSession.shared.data(from: url)
        
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        return wrapper
    }
    
    func getHeroById(id:String) async throws -> SuperheroCompleted{
        let url =  URL(string: "https://superheroapi.com/api/9597cc4d1d4ba37e8c839b0be5188e0c/\(id)")!
        
        let (data,_) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(SuperheroCompleted.self, from: data)
    
    }
}
