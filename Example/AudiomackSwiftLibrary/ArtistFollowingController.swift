//
//  SearchAutosuggestController.swift
//  AudiomackSwiftLibrary_Example
//
//  Created by Fitzgerald Afful on 13/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FTIndicator
import AudiomackSwiftLibrary


class ArtistFollowingController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var following:[AudiomackUser] = []
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView()
		getData()
	}
	
	func getData(){
		FTIndicator.showProgress(withMessage: "Searching")
		client.getArtistFollowing(slug: "eminem") { (result) in
			switch result{
			case let .success(response):
				FTIndicator.dismissProgress()
				self.following.removeAll()
				self.following.append(contentsOf: response)
				self.tableView.reloadData()
			case let .failure(error):
				print("error \(error.localizedDescription)")
				if (error.audiomackError != nil) {
					FTIndicator.dismissProgress()
					FTIndicator.showError(withMessage: error.audiomackError!.message)
				}
			}
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55.0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return following.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = following[indexPath.row].name
		return cell
	}
	
}
