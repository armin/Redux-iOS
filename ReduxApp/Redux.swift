//
//  Redux.swift
//  ReduxApp
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import Foundation

// MARK: Usually implemented by the app delegate
protocol Reduxable {
	var store : Store? { get set }
}

// MARK: State

typealias State = Dictionary<String , Any>

// MARK: Actions

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

// MARK: Updatable

// Listeners are updatable and have an identity so they can be compared
protocol Updatable
{
	func update(state : State)
	var identifier : String { get set }
}

// helper that can be use in implementations of Updatable to mage it unique and identifieable
func generateIdentifier() -> String {
	 return NSUUID().UUIDString
}

// Equatable for Updatables. This will allow us to filter Updatables (basically subscribers)
func !=(lhs: Updatable, rhs: Updatable) -> Bool {
	return  lhs.identifier != rhs.identifier
}


// MARK: Store

// Something that wants to transfer a state into another state
protocol Reducable
{
	var reducer : (state : State? , action : ActionType) -> State? { get }
}

// Simple Redux Store implementation

struct Store : Reducable
{
	var state : State?
	var reducer : (state : State? , action : ActionType) -> State?
	var subscribers : Array<Updatable>

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
	
	mutating func unsubscribe(listener: Updatable ) {
		self.subscribers = self.subscribers.filter({ $0 != listener })
	}
}
