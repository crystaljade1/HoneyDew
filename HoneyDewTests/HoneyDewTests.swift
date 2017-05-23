//
//  HoneyDewTests.swift
//  HoneyDewTests
//
//  Created by Crystal Jade Allen-Washington on 5/22/17.
//  Copyright © 2017 Crystal Jade Allen-Washington. All rights reserved.
//

import XCTest
import Firebase

@testable import HoneyDew

class HoneyDewTests: XCTestCase {
    func testCreateToDo() {
        let result = createToDo(title: "Grocery List",
                                description: "Things to get from Publix",
                                dateCreated: "May 22, 2017")
    }
}
