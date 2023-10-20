//
//  Item.swift
//  ToDo List
//
//  Created by Dmitry Fatsievich on 18.09.2023.
//

import Foundation

struct Item: Identifiable, Codable {
    var id = UUID()
    var todo: String
}

