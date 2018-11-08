//
//  ViewController.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzafful on 10/31/2018.
//  Copyright (c) 2018 Fitzafful. All rights reserved.
//

import UIKit
import AudiomackSwiftLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let client = AudiomackClient(consumerKey: "", consumerSecret: "", oauthToken: "", oauthTokenSecret: "", oauthTokenVerifier: "")
		
		/*client.getArtistDetails(slug: "officiallive919fm") { (result) in
			switch result{
			case let .success(response):
				print("Success")
				print(response)
			case let .failure(error):
				print("error \(error)")
			}
		}*/
		
		client.getArtistUploads(slug: "officiallive919fm") { (result) in
			switch result{
			case let .success(response):
				print("Success")
				print(response)
			case let .failure(error):
				print("error \(error)")
			}
		}
    }
}

