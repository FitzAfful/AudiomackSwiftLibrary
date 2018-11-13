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
class ChartController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var chartMusic:[AudiomackMusic] = []
	@IBOutlet weak var segmentControlMusic: UISegmentedControl!
	@IBOutlet weak var segmentControlGenre: UISegmentedControl!
	@IBOutlet weak var segmentControlSort: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
	
	var genres = ["","Rap","Electronic"]
	var chosenGenre: String = ""
	
	var musicType:[MusicType] = [MusicType.songs, MusicType.albums, MusicType.playlists]
	var chosenMusicType: MusicType = MusicType.songs
	
	var chartTypes:[ChartType] = [ChartType.daily, ChartType.weekly, ChartType.monthly, ChartType.yearly, ChartType.total]
	var chosenChartType: ChartType = ChartType.daily
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.tableFooterView = UIView()
	}
	
	@IBAction func tabChanged(_ sender: Any) {
		if((sender as! UISegmentedControl) == segmentControlSort){
			chosenChartType = self.chartTypes[segmentControlSort.selectedSegmentIndex]
		}else if((sender as! UISegmentedControl) == segmentControlGenre){
			chosenGenre = self.genres[segmentControlGenre.selectedSegmentIndex]
		}else if((sender as! UISegmentedControl) == segmentControlMusic){
			chosenMusicType = self.musicType[segmentControlMusic.selectedSegmentIndex]
		}
	}
	
	@IBAction func getData(_ sender: Any){
		FTIndicator.showProgress(withMessage: "Loading Chart")
		if(chosenGenre.isEmpty){
			client.getChart(musicType: chosenMusicType, chartType: chosenChartType) { (result) in
				switch result{
				case let .success(response):
					FTIndicator.dismissProgress()
					self.chartMusic = response
					self.tableView.reloadData()
				case let .failure(error):
					print("error \(error.localizedDescription)")
					FTIndicator.dismissProgress()
					if (error.audiomackError != nil) {
						FTIndicator.showError(withMessage: error.audiomackError!.message)
					}
				}
			}
		}else{
			client.getGenreChart(genre: chosenGenre, musicType: chosenMusicType, chartType: chosenChartType) { (result) in
				switch result{
				case let .success(response):
					FTIndicator.dismissProgress()
					self.chartMusic = response
					self.tableView.reloadData()
				case let .failure(error):
					print("error \(error.localizedDescription)")
					FTIndicator.dismissProgress()
					if (error.audiomackError != nil) {
						FTIndicator.showError(withMessage: error.audiomackError!.message)
					}
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
		return chartMusic.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = chartMusic[indexPath.row].title
		cell.detailTextLabel?.text = chartMusic[indexPath.row].uploader.name
		return cell
	}
	
}
