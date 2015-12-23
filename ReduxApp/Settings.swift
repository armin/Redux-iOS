//
//  Settings.swift
//  ReduxApp
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import Foundation

// 2 actions: one to toggle a filer on/off and one to toggle facebook on/off
enum SettingsActionKey : String {
	case ToggleFilter = "TOGGLE_FILTER"
	case ToggleFacebook = "TOGGLE_FACEBOOK"
}

// The action to toggle any setting
struct ToggleSettingsAction : ActionType {
	var type : String
	var data : Any { get {return ""} }
}

// the key for the settings in the settings dictionary
// We use this to construct the new settings state
enum SettingKey : String {
	case Filter = "filter"
	case Facebook = "facebook"
}


// settings is a dictionary of string,Bool 
func settingsReducer(settings: Dictionary<String,Bool>?, action: ActionType) -> Dictionary<String,Bool>
{
	guard let settings = settings else {
		// defaults
		return [
			SettingKey.Filter.rawValue : false,
			SettingKey.Facebook.rawValue : false
		] }
	
	// find the item wih the key and toggle it
	var toggleKey = "undefined"
	switch action.type {
	case SettingsActionKey.ToggleFilter.rawValue :
		toggleKey = SettingKey.Filter.rawValue
		break
	case SettingsActionKey.ToggleFacebook.rawValue :
		toggleKey = SettingKey.Facebook.rawValue
		break
	default : break
	}
	
	var newSettings : Dictionary<String, Bool> = [:]
	for (key , value) in settings {
		if toggleKey == key { newSettings[key] = !value }
		else { newSettings[key] = value }
	}
	
	return newSettings
}
