	//
//  SecondViewController.swift
//  ReduxApp
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, Subscriber {
	
	@IBOutlet weak var filterSwitch: UISwitch!
	
	@IBOutlet weak var facebookSwitch: UISwitch!
	// generate an identifier as part of being an Updatable
	var identifier = generateIdentifier()

	deinit {
		// remove self form Redux store subscribers
		storeKeeper().store?.unsubscribe(self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		storeKeeper().store?.subscribe(self)
		self.update((storeKeeper().store?.state)!)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func update(state: State) {
		print("Updating switches")
		if let settings = state["settings"] as? Dictionary<String,Bool> {
			if let filter = settings[SettingKey.Filter.rawValue] {
				self.filterSwitch.on = filter
			}
			if let facebook = settings[SettingKey.Facebook.rawValue] {
				self.facebookSwitch.on = facebook
			}
		}
	}

	@IBAction func filterSwitchPressed(sender: AnyObject) {
		storeKeeper().store?.dispatch(ToggleSettingsAction(type : SettingsActionKey.ToggleFilter.rawValue))
	}

	@IBAction func facebookSwtichPressed(sender: AnyObject) {
		storeKeeper().store?.dispatch(ToggleSettingsAction(type : SettingsActionKey.ToggleFacebook.rawValue))
	}

}


