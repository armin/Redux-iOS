//
//  ReduxAppTests.swift
//  ReduxAppTests
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import XCTest
@testable import ReduxApp

class Subscriber : Updatable {
	var identifier = generateIdentifier()
	func update(state: State) {
		return
	}
}


class ReduxAppTests: XCTestCase {
	
	var store : Store?
	
	func appReducer(_: State?, action: ActionType) -> State? {
		return [:]
	}

	
	override func setUp() {
		super.setUp()
		self.store = Store(reducer: appReducer)
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testSubscribe() {
		XCTAssert(self.store?.subscribers.count == 0)
		let subscriber = Subscriber()
		self.store?.subscribe(subscriber)
		XCTAssert(self.store?.subscribers.count == 1)
		self.store?.unsubscribe(subscriber)
		XCTAssert(self.store?.subscribers.count == 0)
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measureBlock {
			// Put the code you want to measure the time of here.
		}
	}
	
}
