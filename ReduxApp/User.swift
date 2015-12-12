//
//  User.swift
//  ReduxApp
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import Foundation

struct User {
	var name : String
}

struct AddUserAction : ActionType {
	var type : String
	var data : Any
	init() {
		self.type = "AddUserAction"
		self.data = User(name: "tom")
	}
}

// this deals only with the user part of the state not the total app state
func userReducer(users: [User]?, action: ActionType) -> [User] {
	guard let users = users else {
		return []
	}
	if let user = action.data as? User {
		// Actions that need a user as input
		if action.type == "AddUserAction" {
			return users + [user]
		}
	}
	return users
}

