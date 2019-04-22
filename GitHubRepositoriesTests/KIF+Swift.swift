//
//  KIF+Swift.swift
//  AcceptanceTests
//
//  Created by Paulo Cesar Abrantes on 21/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import UIKit
import XCTest
import KIF

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
}
