//
//  File.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

public class AudiomackClient {
	
	private let authClient: AuthenticationClientImplementation
	private let artistClient: ArtistClientImplementation
	private let chartClient: ChartClientImplementation
	private let searchClient: SearchClientImplementation
	private let musicClient: MusicClientImplementation
	private let playlistClient: PlaylistClientImplementation
	
	public init(consumerKey: String, consumerSecret: String) {
		authClient = AuthenticationClientImplementation(apiClient: ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,completionHandlerQueue: OperationQueue.main), oauthSignatureGenerator: OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret))
		artistClient = ArtistClientImplementation(authClient: authClient)
		chartClient = ChartClientImplementation(authClient: authClient)
		searchClient = SearchClientImplementation(authClient: authClient)
		musicClient = MusicClientImplementation(authClient: authClient)
		playlistClient = PlaylistClientImplementation(authClient: authClient)
	}
	
	/** Register new user
	
	For more info,
	https://www.audiomack.com/data-api/docs#user-registration
	
	- Parameters:
	-  parameter: RegisterUserParameter ( email, artist_name, password, password2)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns RegisterResponse with oauth_token, oauth_token_secret, registered_user
	
	
	*/
	
	public func registerUser(email: String, name: String, password: String, password2: String, completionHandler: @escaping RegisterUserCompletionHandler) {
		let parameter = RegisterUserParameter(email: email, artist_name: name, password: password, password2: password2)
		authClient.registerUser(parameter: parameter) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Artist Information / Details
	
	For more info,
	https://www.audiomack.com/data-api/docs#artist-information
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackUser Object of the Artist
	*/
	public func getArtistDetails(slug: String, completionHandler: @escaping GetArtistDetailsCompletionHandler) {
		artistClient.getArtistDetails(parameter: ArtistParameter(slug: slug)) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Artist Uploads
	
	For more info,
	https://www.audiomack.com/data-api/docs#artist-uploads
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of AudiomackMusic objects
	*/
	public func getArtistUploads(slug: String, completionHandler: @escaping GetArtistUploadsCompletionHandler) {
		artistClient.getArtistUploads(parameter: ArtistParameter(slug: slug)) { (result) in
			completionHandler(result)
		}
		
	}
	
	/** Get Artist Favorites
	
	For more info,
	https://www.audiomack.com/data-api/docs#artist-favs
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of AudiomackMusic objects
	*/
	
	public func getArtistFavorites(slug: String, filter: AudioFilter?, completionHandler: @escaping GetArtistFavoritesCompletionHandler){
		artistClient.getArtistFavorites(parameter: ArtistParameter(slug:slug), filter: filter) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Artist Playlists
	
	For more info,  https://www.audiomack.com/data-api/docs#artist-playlists
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of AudiomackMusic objects
	*/
	public func getArtistPlaylists(slug: String, genre: String?, completionHandler: @escaping GetArtistPlaylistsCompletionHandler){
		artistClient.getArtistPlaylists(parameter: ArtistParameter(slug:slug), genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
	/** Search through Artist favorites
	
	For more info,
	https://www.audiomack.com/data-api/docs#artist-fav-search
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of AudiomackMusic objects
	*/
	public func searchArtistFavorites(slug: String, searchText: String, completionHandler: @escaping GetArtistFavoritesCompletionHandler){
		artistClient.searchArtistFavorites(parameter: ArtistParameter(slug:slug), searchText: searchText) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Artist Following
	
	For more info,  https://www.audiomack.com/data-api/docs#artist-following
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of Audiomack Users who are followed by specified artist
	*/
	public func getArtistFollowing(slug: String, completionHandler: @escaping GetArtistFollowingCompletionHandler){
		artistClient.getArtistFollowing(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Artist Followers
	
	For more info,  https://www.audiomack.com/data-api/docs#artist-followers
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of Audiomack Users who are followed by specified artist
	*/
	public func getArtistFollowers(slug: String, completionHandler: @escaping GetArtistFollowersCompletionHandler){
		artistClient.getArtistFollowers(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Artist Feed
	
	For more info,  https://www.audiomack.com/data-api/docs#artist-feed
	
	- Parameters:
	-  parameter: ArtistParameter (slug)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns Array of AudiomackMusic objects
	*/
	public func getArtistFeed(slug: String, completionHandler: @escaping GetArtistFeedCompletionHandler){
		artistClient.getArtistFeed(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	

	//CHARTS
	
	/** Get songs on chart
	
	For more info,  https://www.audiomack.com/data-api/docs#chart-tracks
	
	- Parameters:
	-  musicType: MusicType - songs, albums, playlists
	-  chartType: ChartType - total, daily, weekly, monthly, yearly
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	*/
	public func getChart(musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler) {
		chartClient.getChart(musicType: musicType, chartType: chartType) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get songs on chart by genre
	
	For more info,  https://www.audiomack.com/data-api/docs#charts-genre-specific
	
	- Parameters:
	-  genre: String - rap, electronic
	-  musicType: MusicType - songs, albums, playlists
	-  chartType: ChartType - total, daily, weekly, monthly, yearly
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	*/
	public func getGenreChart(genre: String, musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetGenreChartCompletionHandler) {
		chartClient.getGenreChart(genre: genre, musicType: musicType, chartType: chartType) { (result) in
			completionHandler(result)
		}
	}
	
	
	//SEARCH
	
	/** Search Audiomack for music, artists
	
	For more info,  https://www.audiomack.com/data-api/docs#search-songs
	
	- Parameters:
	-  searchText: String - text to search
	-  resultType: SearchMusicType -  (optional)
	-  sortBy: SortType -  slug of artist (optional)
	-  genre: String -  eg. rap, electronic (optional)
	-  verified: Bool -  verified results only? (optional)
	-  page: Int -  for pagination only (optional)
	-  limit: Int -  by default, only 20 results are returned. Adjust to suit your use (optional)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackSearchResponse containing music, artists
	*/
	public func search(searchText: String, resultType: SearchMusicType?, sortBy: SortType?, genre: String?, verified: Bool?, page: Int?, limit: Int?, completionHandler: @escaping SearchCompletionHandler){
		
		searchClient.search(searchText: searchText, resultType: resultType, sortBy: sortBy, genre: genre, verified: verified, page: page, limit: limit) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get autosuggested words for search
	
	For more info,  https://www.audiomack.com/data-api/docs#search-autosuggest
	
	- Parameters:
	-  searchText: String - text to search
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns a String array of autosuggested words
	*/
	public func searchAutosuggest(searchText: String, completionHandler: @escaping SearchAutoSuggestCompletionHandler){
		searchClient.searchAutosuggest(searchText: searchText) { (result) in
			completionHandler(result)
		}
	}
	
	//MUSIC
	
	/** Get Music Information
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-song-album-info
	
	- Parameters:
	-  id: Music Id
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic object
	
	
	*/
	func getMusic(id: String, completionHandler: @escaping GetMusicCompletionHandler){
		musicClient.getMusic(id: id) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Music Information
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-song-album-info
	
	- Parameters:
	-  id: Music Id
	-  key: (optional) promotional key for private tracks
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic object
	*/
	func getMusic(id: String, key:String, completionHandler: @escaping GetMusicCompletionHandler){
		musicClient.getMusic(id: id, key: key) { (result) in
			completionHandler(result)
		}
	}
	
	/** Search Audiomack for music, artists
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-song-album-info
	
	- Parameters:
	-  musicSlug: Url slug of music
	-  musicType: Music Type - song, album
	-  artistSlug: URL slug of artist (owner of music)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic object
	*/
	func getMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, key:String?, completionHandler: @escaping GetMusicCompletionHandler){
		musicClient.getMusic(musicSlug: musicSlug, musicType: musicType, artistSlug: artistSlug, key: key) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get most recent Music
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-most-recent
	
	- Parameters:
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	*/
	func getMostRecentMusic(completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getMostRecentMusic { (result) in
			completionHandler(result)
		}
	}
	
	/** Get most recent music by Genre
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-genre-most-recent
	
	- Parameters:
	-  genre: Music Genre ( eg. rap, electronic)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	*/
	func getGenreMostRecentMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getGenreMostRecentMusic(genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get trending music
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-trending
	
	- Parameters:
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	*/
	func getTrendingMusic(completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getTrendingMusic { (result) in
			completionHandler(result)
		}
	}
	
	/** Get trending music by Genre
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-genre-trending
	
	- Parameters:
	-  genre: genre of music
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	*/
	func getGenreTrendingMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getGenreTrendingMusic(genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
	/** Play Music / Get Streaming URL for music
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-play-track
	
	- Parameters:
	-  parameter: PlayMusicParameter object containing ID, session, album_id, playlist_id, hq, key
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns A url to stream for Music item.
	*/
	func playMusic(parameter: PlayMusicParameter, completionHandler: @escaping MusicStreamCompletionHandler){
		self.musicClient.playMusic(parameter: parameter) { (result) in
			completionHandler(result)
		}
	}
	
	/** Flag Music as unplayable
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-flagging
	
	- Parameters:
	-  musicSlug: Url slug of music
	-  musicType: Music Type - song, album
	-  artistSlug: URL slug of artist (owner of music)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: A void response with 204 http code.
	
	
	*/
	func flagUnplayableMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String,  completionHandler: @escaping FlagMusicCompletionHandler){
		self.musicClient.flagUnplayableMusic(musicSlug: musicSlug, musicType: musicType, artistSlug: artistSlug) { (result) in
			completionHandler(result)
		}
	}
	
	/** Track Ad
	
	For more info,  https://www.audiomack.com/data-api/docs#endpoint-track-ad
	
	- Parameters:
	-  parameter: TrackAdParameter containing id and status
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, A void response with 204 http code
	*/
	func trackAd(parameter: TrackAdParameter, completionHandler: @escaping TrackAdCompletionHandler){
		self.musicClient.trackAd(parameter: parameter) { (result) in
			completionHandler(result)
		}
	}
	
	
	// PLAYLISTS
	
	/** Get Playlist Info
	
	
	- Parameters:
	-  id: The id of playlist
	-  fields: Fields you want in the response. eg url_slug
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic
	*/
	func getPlaylistInfo(id: String, fields: [String], completionHandler: @escaping GetPlaylistDetailsCompletionHandler){
		self.playlistClient.getPlaylistInfo(id: id, fields: fields) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get Playlist Info
	
	Get details of a playlist
	
	- Parameters:
	-  playlistSlug:    The url slug of playlist.
	-  artistSlug:    The url slug of artist who own's the playlist.
	-  fields:     Fields you want in the response. eg url_slug
	-  fields: Fields you want in the response. eg url_slug
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic
	*/
	func getPlaylistInfo(playlistSlug: String, artistSlug: String, fields: [String], completionHandler: @escaping GetPlaylistDetailsCompletionHandler){
		self.playlistClient.getPlaylistInfo(playlistSlug: playlistSlug, artistSlug: artistSlug, fields: fields) { (result) in
			completionHandler(result)
		}
	}
	
	/** Get trending playlists
	
	
	- Parameters:
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns array of AudiomackMusic object
	*/
	func getTrendingPlaylists(completionHandler: @escaping GetPlaylistArrayCompletionHandler){
		self.playlistClient.getTrendingPlaylists { (result) in
			completionHandler(result)
		}
	}
	
	/** Get trending playlists by genre
	
	
	- Parameters:
	-  genre: Particular genre you want the trending playlists from
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, an array of AudiomackMusic object
	*/
	func getGenreTrendingPlaylists(genre: String, completionHandler: @escaping GetPlaylistArrayCompletionHandler){
		self.playlistClient.getGenreTrendingPlaylists(genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
}
