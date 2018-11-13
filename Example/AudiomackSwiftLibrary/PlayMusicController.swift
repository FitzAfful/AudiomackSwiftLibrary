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

	var player: AVAudioPlayer!
	@IBOutlet weak var textView: UITextView!
	var id = "2077853"
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
    }
	
	@IBAction func playStop(_ sender: Any) {
		
		FTIndicator.showProgress(withMessage: "Loading")
		let parameter = PlayMusicParameter(id: id)
		client.playMusic(parameter: parameter) { (result) in
				switch result{
				case let .success(response):
					FTIndicator.dismissProgress()
					//self.downloadFileFromURL(url: URL(string: response)!)
					print(response)
					let url: URL = URL(string: response)!
					self.play(url: url)
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
	
	/*func downloadFileFromURL(url:URL){
		
		var downloadTask:URLSessionDownloadTask
		downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
			self?.play(url: url)
		})
		
		downloadTask.resume()
		
	}*/
	
	func play(url:URL) {
		print("playing \(url)")
		
		do {
			self.player = try AVAudioPlayer(contentsOf: url)
			player.prepareToPlay()
			player.volume = 1.0
			player.play()
		} catch let error as NSError {
			//self.player = nil
			print(error.localizedDescription)
		} catch {
			print("AVAudioPlayer init failed")
		}
		
	}

}
