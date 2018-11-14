//
//  PlayMusicController.swift
//  AudiomackSwiftLibrary_Example
//
//  Created by Fitzgerald Afful on 13/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import AudiomackSwiftLibrary
import FTIndicator
import AVKit

class PlayMusicController: UIViewController {

	@IBOutlet weak var idField: UITextField!
	@IBOutlet weak var textView: UITextView!
	var id = "2077853"
	
	override func viewDidLoad() {
        super.viewDidLoad()

		idField.text = id
    }
	
	@IBAction func getURL(_ sender: Any) {
		if((idField.text?.isEmpty)!){
			FTIndicator.showToastMessage("ID Field is empty")
			return
		}
		FTIndicator.showProgress(withMessage: "Loading")
		let parameter = PlayMusicParameter(id: id)
		client.playMusic(parameter: parameter) { (result) in
				switch result{
				case let .success(response):
					FTIndicator.dismissProgress()
					print(response)
					self.textView.text = response
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
