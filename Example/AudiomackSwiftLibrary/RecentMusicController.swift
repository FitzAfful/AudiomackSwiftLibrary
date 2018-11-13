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


class RecentMusicController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var recentMusic:[AudiomackMusic] = []
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Recent Music"
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView()
		getData()
	}
	
	func getData(){
		FTIndicator.showProgress(withMessage: "Searching")
		client.getMostRecentMusic { (result) in
			switch result{
			case let .success(response):
				FTIndicator.dismissProgress()
				self.recentMusic.removeAll()
				self.recentMusic.append(contentsOf: response)
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
		return recentMusic.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = recentMusic[indexPath.row].title
		cell.detailTextLabel?.text = recentMusic[indexPath.row].uploader.name
		return cell
	}
	
}
