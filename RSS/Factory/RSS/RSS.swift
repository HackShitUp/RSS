//
//  RSS.swift
//  RSS
//
//  Created by Joshua Choi on 5/17/21.
//

import UIKit
import Combine
import SwiftUI



/**
 Abstract: Class used to manage laoding data 
 */
class RSS {
    
    // MARK: - Class Vars
    
    // MARK: - URLSession
    let urlSession: URLSession!
    
    // MARK: - Global Init
    static let shared = RSS()
    
    // MARK: - Init
    private init() {
        // MARK: - URLSession
        self.urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    /// Cancel loading the data if necessary
    /// - Parameter completion:
    func cancel(completion: (() -> Void)? = nil) {
        // MARK: - URLsession
        self.urlSession.invalidateAndCancel()
    }
    
    /// Load the data from the RSS feed
    /// - Parameters:
    ///   - url: An optional URL value representing the URL we're loading content from
    ///   - completion: Returns an optional array of Album objects or an optional Error if the request fails
    func loadData(url: URL?, completion: ((_ albums: [Album]?, _ error: Error?) -> ())? = nil) {
        // MARK: - URL
        guard let url = url else {
            completion?(nil, LocalError(message: "\(#file)/\(#line) - Invalid URL"))
            return
        }
        
        // MARK: - URLSession
        urlSession.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                do {
                    // MARK: - JSON
                    guard let data = data,
                          let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                          let feed = json["feed"] as? NSDictionary,
                          let results = feed["results"] as? [NSDictionary]
                          else {
                        // Pass the values in the completion
                        completion?(nil, LocalError(message: "\(#file)/\(#line) - Error parsing JSON"))
                        return
                    }
                    
                    // MARK: - Album
                    // Map to Album objects
                    let albums = results.map { (dictionary: NSDictionary) -> Album in
                        // Get the release date and parse it to make readable to humans
                        let date = dictionary["releaseDate"] as? String ?? ""
                        let readableDate = date.dates?.first?.readableDate() ?? date
                        
                        // Map the dictionary to their genres
                        let genres = (dictionary["genres"] as? [NSDictionary] ?? []).map { (value: NSDictionary) -> String in
                            return value["name"] as? String ?? ""
                        }.joined(separator: ", ")
                        
                        // MARK: - Album
                        return Album(id: dictionary["id"] as? String,
                                     name: dictionary["name"] as? String,
                                     artistName: dictionary["artistName"] as? String,
                                     artworkUrl100: dictionary["artworkUrl100"] as? String,
                                     releaseDate: readableDate,
                                     copyright: dictionary["copyright"] as? String,
                                     genres: genres.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty ? nil : genres,
                                     url: dictionary["url"] as? String)
                    }

                    // Pass the values in the completion
                    completion?(albums, nil)

                } catch let error {
                    // Pass the values in the completion
                    completion?(nil, LocalError(message: "\(#file)/\(#line) - Error: \(error.localizedDescription)"))
                }
                
            } else {
                // Pass the values in the completion
                completion?(nil, LocalError(message: "\(#file)/\(#line) - Error: \(error?.localizedDescription as Any)"))
            }
        }.resume()
    }
}
