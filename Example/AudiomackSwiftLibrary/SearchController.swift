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

///Checkout the searchMethod. Audiomack's Search API is used there.
class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	var searchResults:AudiomackSearchResponse = AudiomackSearchResponse(songs:[], artists: [], albums: [], playlists: [], verified_artists: [])
	@IBOutlet weak var segmentControl: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
	var searched: Bool = false
	let searchController = UISearchController(searchResultsController: nil)
	var typeOfResult = 0
	
	enum ResultType : Int {
		case songs = 0
		case albums = 1
		case artists = 2
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		searchController.searchBar.placeholder = "Search"
		searchController.searchBar.delegate = self
		self.definesPresentationContext = true
		if #available(iOS 11.0, *) {
			self.navigationItem.searchController = self.searchController
			self.navigationItem.hidesSearchBarWhenScrolling = false
		} else {
			tableView.tableHeaderView = searchController.searchBar
		}
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
		self.tableView.tableFooterView = UIView()
	}
	
	@IBAction func tabChanged(_ sender: Any) {
		typeOfResult = segmentControl.selectedSegmentIndex
		tableView.reloadData()
	}
	
	//Search API Example
	func searchMethod(searchText: String){
		if(!(searchText.isEmpty)){
			FTIndicator.showProgress(withMessage: "Searching")
			client.search(searchText: searchText, resultType: SearchMusicType.all, sortBy: SortType.relevance, genre: nil, verified: nil, page: nil, limit: nil){ (result) in
				switch result{
				case let .success(response):
					self.searchController.isActive = false
					FTIndicator.dismissProgress()
					self.searchResults = response
					self.searched = true
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
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchMethod(searchText: searchController.searchBar.text!)
	}
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55.0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(searched){
			switch typeOfResult{
			case ResultType.songs.rawValue:
				return self.searchResults.songs.count
			case ResultType.albums.rawValue:
				return self.searchResults.albums.count
			case ResultType.artists.rawValue:
				return self.searchResults.artists.count
			default:
				break
			}
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		if(searched){
			switch typeOfResult{
			case ResultType.songs.rawValue:
				cell.textLabel?.text = searchResults.songs[indexPath.row].title
				cell.detailTextLabel?.text = searchResults.albums[indexPath.row].uploader.name
			case ResultType.albums.rawValue:
				cell.textLabel?.text = searchResults.albums[indexPath.row].title
				cell.detailTextLabel?.text = searchResults.albums[indexPath.row].uploader.name
			case ResultType.artists.rawValue:
				cell.textLabel?.text = searchResults.artists[indexPath.row].name
			default:
				break
			}
		}
		return cell
	}
	
}
