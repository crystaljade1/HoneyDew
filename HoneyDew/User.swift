//
//  User.swift
//  HoneyDew
//
//  Created by Crystal Jade Allen-Washington on 5/22/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import UIKit
import Firebase


// MARK: User setup
class User: Hashable {
    
    let displayName: String
    let userName: String
    var toDo: ToDo
    var toDoList: [ToDo]
    var listOfToDoLists: [List]
    
    init(displayName: String, userName: String, toDo: ToDo, toDoList: [ToDo], listOfToDoLists: [List]) {
        self.displayName = displayName
        self.userName = userName
        self.toDo = toDo
        self.toDoList = toDoList
        self.listOfToDoLists = listOfToDoLists
    }
    
    var hashValue: Int {
        return userName.hashValue &+ displayName.hashValue
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userName == rhs.userName && lhs.displayName == rhs.displayName
    }
}

// MARK: User functionality (User story functions)
extension User {
    func createToDo(title: String, description: String, dateCreated: Date, createdBy: User, dueDate: Date, dateCompleted: Date?) -> [ToDo] {
        precondition(createdBy == self)
        var toDoList = [ToDo]()
        toDoList.append(toDo)
        
        return toDoList
    }
    
    func shareListWithUser(user: User, permissions: Permissions?) {
        
    }
}
