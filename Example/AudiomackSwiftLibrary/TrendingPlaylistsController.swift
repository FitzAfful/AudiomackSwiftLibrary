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


class TrendingPlaylistsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var playlists:[AudiomackMusic] = []
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Trending Playlists"
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView()
		getData()
	}
	
	func getData(){
		FTIndicator.showProgress(withMessage: "Loading")
		client.getTrendingPlaylists() { (result) in
			switch result{
			case let .success(response):
				FTIndicator.dismissProgress()
				self.playlists.removeAll()
				self.playlists.append(contentsOf: response)
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
		return playlists.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = playlists[indexPath.row].title
		cell.detailTextLabel?.text = playlists[indexPath.row].uploader.name
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let playlist = playlists[indexPath.row]
		let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = myStoryboard.instantiateViewController(withIdentifier: "PlaylistDetailsController") as! PlaylistDetailsController
		controller.playlistSlug = playlist.url_slug
		controller.artistSlug = playlist.uploader.url_slug
		print(playlist.url_slug)
		print(playlist.uploader)
		print(playlist.id)
		//self.navigationController?.pushViewController(controller, animated: true)
	}
	
}
