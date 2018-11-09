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
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getArtistUploads(slug: "officiallive919fm") { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getArtistFavorites(slug: "lilmoskii", filter: AudioFilter.all) { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.searchArtistFavorites(slug: "lilmoskii", searchText: "kevin") { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getArtistPlaylists(slug: "lilmoskii", genre: "rap") { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getArtistFollowing(slug: "lilmoskii") { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getArtistFollowers(slug: "lilmoskii") { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getArtistFeed(slug: "lilmoskii") { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getChart(musicType: MusicType.albums, chartType: ChartType.monthly) { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.getGenreChart(genre:"Rap", musicType: MusicType.albums, chartType: ChartType.monthly) { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
		
		/*client.search(searchText: "eminem", resultType: SearchMusicType.artists, sortBy: SortType.popular, genre: nil, verified: nil, page: nil, limit: nil) { (result) in
		switch result{
		case let .success(response):
		print("Success")
		print(response)
		case let .failure(error):
		print("error \(error)")
		}
		}*/
    }
}

