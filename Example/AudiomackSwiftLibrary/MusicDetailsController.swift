//
//  MusicDetailsController.swift
//  AudiomackSwiftLibrary_Example
//
//  Created by Fitzgerald Afful on 13/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FTIndicator

class MusicDetailsController: UIViewController {

	@IBOutlet weak var textView: UITextView!
	override func viewDidLoad() {
        super.viewDidLoad()

		FTIndicator.showProgress(withMessage: "Loading")
		client.getMusic(id: "2077853") { (result) in
			switch result{
			case let .success(response):
				FTIndicator.dismissProgress()
				self.textView.text = "\(response)"
			case let .failure(error):
				FTIndicator.dismissProgress()
				print("error \(error.localizedDescription)")
				if (error.audiomackError != nil) {
					print(error.audiomackError!.message)
					FTIndicator.showError(withMessage: error.audiomackError!.message)
				}
			}
		}
    }
	

}
