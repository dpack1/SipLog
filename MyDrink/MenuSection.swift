//
//  MenuSection.swift
//  MyDrink
//
//  Created by Dylan Packham on 4/26/23.
//

import Foundation

struct MenuSection: Identifiable, Codable {
    let id: UUID
    let name: String
    let drinks: [Drink]
    
}
