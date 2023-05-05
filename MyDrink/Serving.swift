//
//  Serving.swift
//  MyDrink
//
//  Created by Dylan Packham on 4/27/23.
//

import Foundation

struct Serving: Identifiable, Codable, Equatable {
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
}
