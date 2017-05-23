//
//  ToDo.swift
//  HoneyDew
//
//  Created by Crystal Jade Allen-Washington on 5/22/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import UIKit
import Firebase

class ToDo {

    let title: String
    let description: String
    let dateCompleted: Date?
    let dueDate: Date
    let dateCreated: Date
    let createdBy: User
    
    init(title: String, description: String, dateCreated: Date, dueDate: Date, dateCompleted: Date?, createdBy: User) {
        self.title = title
        self.description = description
        self.dateCreated = dateCreated
        self.dueDate = dueDate
        self.dateCompleted = dateCompleted
        self.createdBy = createdBy
    }
}

