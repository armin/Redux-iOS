//
//  SecondViewController.swift
//  ReduxApp
//
//  Created by Armin Kroll on 12/12/2015.
//  Copyright © 2015 jtribe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, Updatable {
	
	@IBOutlet weak var filterSwitch: UISwitch!
	
	@IBOutlet weak var facebookSwitch: UISwitch!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
		appDelegate?.store?.subscribe(self)
		self.update((appDelegate?.store?.state)!)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func update(state: State) {
		print("Updating switches")
		if let settings = state["settings"] as? Dictionary<String,Bool> {
			if let filter = settings["filter"] {
				self.filterSwitch.on = filter
			}
			if let facebook = settings["facebook"] {
				self.facebookSwitch.on = facebook
			}
		}
	}


	@IBAction func filterSwitchPressed(sender: AnyObject) {
		let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
		appDelegate?.store?.dispatch(ToggleSettingsAction(type : "TOGGLE_FILTER"))
	}

	@IBAction func facebookSwtichPressed(sender: AnyObject) {
		let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
		appDelegate?.store?.dispatch(ToggleSettingsAction(type : "TOGGLE_FACEBOOK"))
	}

}


