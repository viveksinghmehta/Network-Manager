//
//  TestJSONModel.swift
//  TestingJSON
//
//  Created by Vindeshwar Rai on 06/05/19.
//  Copyright © 2019 Vivek Singh Mehta. All rights reserved.
//

import Foundation

struct NewJSON: Codable {
    var nameNew: String?
}


struct TestJSONModel : Codable {
    
    var batters : Batters?
    var id : String?
    var name : String?
    var ppu : Float?
    var topping : [Topping]?
    var type : String?
    
    
    enum CodingKeys: String, CodingKey {
        case batters
        case id = "id"
        case name = "name"
        case ppu = "ppu"
        case topping = "topping"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        batters = try Batters(from: decoder)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        ppu = try values.decodeIfPresent(Float.self, forKey: .ppu)
        topping = try values.decodeIfPresent([Topping].self, forKey: .topping)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        print("Working")
    }
    
    
}

struct Topping : Codable {
    
    var id : String?
    var type : String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        print("Working")
    }
    
    
}

struct Batters : Codable {
    
    var id : String?
    var type : String?
    var newBatter : [Batter]?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case newBatter = "batter"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        newBatter = try values.decodeIfPresent([Batter].self, forKey: .newBatter)
    }
    
    func encode(to encoder: Encoder) throws {
        print("Working")
    }
    
    
}


struct Batter : Codable {
    
    var id : String?
    var type : String?
    var newBatter : [Batter]?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case newBatter = "batter"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        newBatter = try values.decodeIfPresent([Batter].self, forKey: .newBatter)
    }
    
    func encode(to encoder: Encoder) throws {
        print("Working")
    }
    
    
}
