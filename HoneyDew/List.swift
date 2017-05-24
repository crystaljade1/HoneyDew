//
//  List.swift
//  HoneyDew
//
//  Created by Crystal Jade Allen-Washington on 5/22/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import UIKit
import Firebase

class List {
    
    var dateCompleted: Date? {
        guard let dateCompleted = self.dateCompleted else {
            return nil
        }
        return dateCompleted
    }
    
    let toDos: [ToDo]
    let createdBy: User
    let sharedWith: [User: Permissions]
    let listID: UUID
    let title: String
    
    init(createdBy: User, sharedWith: [User: Permissions], toDos: [ToDo], listID: UUID, title: String) {
        self.createdBy = createdBy
        self.sharedWith = sharedWith
        self.toDos = toDos
        self.listID = listID
        self.title = title
    }
    
}
