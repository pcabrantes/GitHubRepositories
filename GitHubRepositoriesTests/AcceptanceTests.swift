//
//  AcceptanceTests.swift
//  AcceptanceTests
//
//  Created by Paulo Cesar Abrantes on 21/04/19.
//  Copyright © 2019 Paulo Cesar Abrantes. All rights reserved.
//

import XCTest
import KIF

class AcceptanceTests: KIFTestCase {

    func testPullToRefresh() {
        tester().tapStatusBar()
        tester().waitForAnimationsToFinish()
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.down)
    }
    
    func testInfiniteScroll() {
        tester().waitForAnimationsToFinish()
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
        tester().swipeView(withAccessibilityLabel: "Repositories Table View", in: KIFSwipeDirection.up)
    }
}
