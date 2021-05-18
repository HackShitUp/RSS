//
//  Album.swift
//  RSS
//
//  Created by Joshua Choi on 5/17/21.
//

import UIKit



/**
 Abstract: Struct used to model the data from the RSS feed (https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json)
 */
struct Album {
    
    // MARK: - Class Vars
    
    /// Album's id
    var id: String?
    /// Name of the album
    var name: String?
    /// Name of the artist
    var artistName: String?
    /// String value representing the absolute URL path of the album artwork
    var artworkUrl100: String?
    /// String value representing the release date of the album
    var releaseDate: String?
    /// String value representing the copyright of the album
    var copyright: String?
    /// String representing the genres of the album
    var genres: String?
    /// String representing the absolute URL path of the album
    var url: String?
}
