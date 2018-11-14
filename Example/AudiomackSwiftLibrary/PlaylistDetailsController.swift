//
//  MusicDetailsController.swift
//  AudiomackSwiftLibrary_Example
//
//  Created by Fitzgerald Afful on 13/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FTIndicator

class PlaylistDetailsController: UIViewController {

	var playlistSlug = "smino"
	var playlistId = ""
	var artistSlug = "fuckjoevango"
	@IBOutlet weak var textView: UITextView!
	override func viewDidLoad() {
        super.viewDidLoad()

		FTIndicator.showProgress(withMessage: "Loading")
		if(playlistId.isEmpty){
			client.getPlaylistInfo(playlistSlug: playlistSlug, artistSlug: artistSlug, fields: []) { (result) in
				switch result{
				case let .success(response):
					FTIndicator.dismissProgress()
					self.textView.text = "\(response)"
				case let .failure(error):
					FTIndicator.dismissProgress()
					print("error \(error.localizedDescription)")
					if (error.audiomackError != nil) {
						FTIndicator.showError(withMessage: error.audiomackError!.message)
					}
				}
			}
		}else{
			client.getPlaylistInfo(id: playlistId, fields: []) { (result) in
				switch result{
				case let .success(response):
					FTIndicator.dismissProgress()
					self.textView.text = "\(response)"
				case let .failure(error):
					FTIndicator.dismissProgress()
					print("error \(error.localizedDescription)")
					if (error.audiomackError != nil) {
						FTIndicator.showError(withMessage: error.audiomackError!.message)
					}
				}
			}
		}
    }
	

}
