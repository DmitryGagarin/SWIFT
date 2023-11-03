//
//  Group.swift
//  DatabaseTrain
//
//  Created by Dmitry Fatsievich on 03.11.2023.
//

import Foundation
import RealmSwift

final class Group: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var items = RealmSwift.List<Item>()
    
}
