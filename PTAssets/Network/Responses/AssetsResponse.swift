//
//  AssetsResponse.swift
//  PTAssets
//
//  Created by Saffi on 2023/2/5.
//

import Foundation
import ObjectMapper

struct AssetsResponse: Mappable {
    var next: String?
    var previous: String?
    var assets: [AssetModel] = []

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        next <- map["next"]
        previous <- map["previous"]
        assets <- map["assets"]
    }
}

struct AssetModel: Mappable, Hashable {
    var imageURL = ""
    var name = ""
    var collectionName = ""
    var description = ""
    var permalink = ""  // button link

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        imageURL <- map["image_url"]
        name <- map["name"]
        collectionName <- map["collection.name"]
        description <- map["description"]
        permalink <- map["permalink"]
    }
}
