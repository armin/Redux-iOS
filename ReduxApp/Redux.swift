//
//  Redux.swift
//  ReduxApp
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import Foundation

// MARK - State

typealias State = Dictionary<String , Any>

// MARK - Actions

protocol ActionType {
	var type : String { get }
	var data : Any { get }
}

struct InitialAction : ActionType {
	var type : String
	var data : Any { get {return ""} }
	init() {
		self.type = "Initial"
	}
}

// MARK - Listeners are updatable
protocol Updatable
{
	func update(state : State)
}

// MARK - Store

// Sothing that wants to transfered a state into anothers state
protocol Reducable
{
	var reducer : (state : State? , action : ActionType) -> State? { get }
}

// Simple Redux Store implementation

struct Store : Reducable
{
	var state : State?
	var reducer : (state : State? , action : ActionType) -> State?
	private var subscribers : Array<Updatable>

	init(reducer: (State?, ActionType) -> State?)
	{
		self.reducer = reducer
		print("call initial")
		self.state = reducer(nil, InitialAction())
		self.subscribers = []
	}
	
	mutating func dispatch(action: ActionType) {
		self.state = self.reducer(state: self.state, action: action)
		print("Current State:\n \(self.state)")
		if let state = self.state {
			self.subscribers.forEach { $0.update(state) }
		}
	}

	mutating func subscribe(listener: Updatable) {
		self.subscribers.append(listener)
	}
}
