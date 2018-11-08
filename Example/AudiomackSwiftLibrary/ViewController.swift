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
		
		let client = AudiomackClient(consumerKey: "live-919fm", consumerSecret: "99b372ca87246c2d33249fcab58db071", oauthToken: "", oauthTokenSecret: "", oauthTokenVerifier: "")
		
		client.getArtistDetails(slug: "officiallive919fm") { (result) in
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

