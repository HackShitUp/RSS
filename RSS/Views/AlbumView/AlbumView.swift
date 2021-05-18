//
//  AlbumView.swift
//  RSS
//
//  Created by Joshua Choi on 5/17/21.
//

import UIKit
import SwiftUI



/**
 Abstract: View subclass used to display the contents of an album
 */
struct AlbumView: View {
    
    // MARK: - Class Vars
    
    // MARK: - Album
    fileprivate var album: Album!
    
    /// MARK: - Init
    /// - Parameter album: An Album object
    init(album: Album) {
        // MARK: - Album
        self.album = album
    }
    
    // MARK: - View
    var body: some View {
        HStack {
            // MARK: - AlbumImageView
            AlbumImageView(url: URL(string: album.artworkUrl100 ?? ""))
                .frame(width: 80.0, height: 80.0)
                .cornerRadius(20.0)
                .shadow(radius: 1)
                .padding(.bottom, 8.0)
                .padding(.top, 8.0)
            
            // MARK: - VStack
            VStack {
                // MARK: - Text
                // Set the Album object's ```name``` and ```artistName``` attributes — fallback to "Loading..." if we couldn't get any
                Text(album.name ?? "Loading...")
                    .font(.body)
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(album.artistName ?? "Loading...")
                    .font(.caption)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
