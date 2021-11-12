//
//  Restaurant.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/8.
//

import Foundation

struct Restaurant: Hashable{
    var name: String = ""
    var image: String = ""
    var isFavorite: Bool = false
}
//Array is a value-type object

extension Restaurant {
    
    static func generateData( sourceArray: inout [Restaurant]) {
        sourceArray = [
            Restaurant(name: "baseball", image: "baseball.png"),
            Restaurant(name: "basketball", image: "basketball.png"),
            Restaurant(name: "football", image: "football.png"),
            Restaurant(name: "other", image: "other.png"),
        ]
        
        
    }
    
}
