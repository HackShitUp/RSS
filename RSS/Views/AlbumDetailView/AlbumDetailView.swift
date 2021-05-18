//
//  AlbumDetailView.swift
//  RSS
//
//  Created by Joshua Choi on 5/18/21.
//

import UIKit
import SwiftUI



/**
 Abstract: View class used to display the contents of an Album
 */
struct AlbumDetailView: View {
    
    // MARK: - Class Vars
    
    // MARK: - Album
    var album: Album!
    
    // MARK: - View
    var body: some View {
        ScrollView {
            VStack {
                // 1/4 of width
                let fourthWidth = UIScreen.main.bounds.width/4.0
                // MARK: - AlbumImageView
                AlbumImageView(url: URL(string: album.artworkUrl100 ?? ""))
                    .frame(width: fourthWidth, height: fourthWidth)
                    .cornerRadius(32.0)
                    .shadow(radius: 1)
                    .padding(.top, 32.0)
                Text(album.copyright ?? "Loading...")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 16.0)
                    .padding(.bottom, 32.0)
                
                // MARK: - Text
                // Set the Album object's ```name```, ```artistName```, ```releaseDate```, and ```genres``` attributes — fallback to "Loading..." if we couldn't get any
                Text(album.name ?? "Loading...")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(album.artistName ?? "Loading...")
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(album.releaseDate ?? "Loading...")
                    .font(.title)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Genres: \(album.genres ?? "Loading...")")
                    .font(.caption)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .center).padding(.top, 32.0)
            }
        }
        
        // MARK: - Button
        Button {
            // Open the URL for the album
            if let url = album.url, let iTunesURL = URL(string: url), UIApplication.shared.canOpenURL(iTunesURL) {
                UIApplication.shared.open(iTunesURL, options: [:], completionHandler: nil)
            } else {
                print("\(#file)/\(#line) - Invalid URL")
            }
        } label: {
            Text("Open iTunes")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.heavy)
                .cornerRadius(40.0/3.0)
        }
        .frame(width: UIScreen.main.bounds.width - 40.0, height: 40.0)
        .background(Color.blue)
        .padding(.top, 20.0)
        .padding(.bottom, 20.0)
    }
    
    init(album: Album) {
        // MARK: - Album
        self.album = album
    }
}
