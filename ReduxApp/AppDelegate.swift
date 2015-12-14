//
//  AppDelegate.swift
//  ReduxApp
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import UIKit

// shorthand to get to the store
func storeKeeper() -> AppDelegate {
	let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
	return delegate!
}

// the app reducer calls other reducers and assembles the app state.
func appReducer(state: State?, action: ActionType) -> State? {
	if let state = state {
		return [
			"users" : userReducer(state["users"] as? [User], action: action),
			"settings" : settingsReducer(state["settings"] as? Dictionary<String,Bool>, action: action)
		]
	}
	
	// defaults
	return [
		"users" : userReducer(nil, action: action),
		"settings" : settingsReducer(nil, action: action)
	]
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, Reduxable {

	var window: UIWindow?
	var store : Store?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		
		self.store = Store(reducer: appReducer)
		
		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

