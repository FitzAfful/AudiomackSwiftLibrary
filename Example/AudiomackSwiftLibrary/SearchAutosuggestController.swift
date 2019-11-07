//
//  SearchAutosuggestController.swift
//  AudiomackSwiftLibrary_Example
//
//  Created by Fitzgerald Afful on 13/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FTIndicator

///Checkout the searchMethod. Audiomack's Search Autosuggest API is used there.
class SearchAutosuggestController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	var autosuggestStrings:[String] = []
	@IBOutlet weak var tableView: UITableView!
	var searched: Bool = false
	let searchController = UISearchController(searchResultsController: nil)

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
	
	//Search Autosuggest API Example
	func searchMethod(searchText: String){
		autosuggestStrings.removeAll()
		if(!(searchText.isEmpty)){
			FTIndicator.showProgress(withMessage: "Searching")
			client.searchAutosuggest(searchText: searchText) { (result) in
				switch result{
				case let .success(response):
					self.searchController.isActive = false
					FTIndicator.dismissProgress()
					self.autosuggestStrings.append(contentsOf: response)
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
			return autosuggestStrings.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = autosuggestStrings[indexPath.row]
		return cell
	}
	
}
