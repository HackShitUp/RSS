//
//  MainView.swift
//  RSS
//
//  Created by Joshua Choi on 5/17/21.
//

import UIKit
import SwiftUI



/**
 Abstract: Application's POE view — This class loads the contents of up-and-coming music
 */
struct MainView: View {
    
    // MARK: - Class Vars
    
    // MARK: - Album
    @State private var albums: [Album] = []
    
    // MARK: - View
    var body: some View {
        NavigationView {
            List(albums, id: \.id) { (album: Album) in
                NavigationLink(destination: AlbumDetailView(album: album)) {
                    AlbumView(album: album)
                }
            }.navigationBarTitle(Text("Coming Soon 😜"))
        }.onAppear(perform: {
            // MARK: - URL
            let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/\(100)/explicit.json")
            
            // MARK: - RSS
            RSS.shared.loadData(url: url) { (albums: [Album]?, error: Error?) in
                if error == nil {
                    // Unwrap the albums array
                    if let albums = albums, !albums.isEmpty {
                        // MARK: - Album
                        self.albums = albums
                    } else {
                        print("\(#file)/\(#line) - No Albums were returned.")
                    }
                } else {
                    print("\(#file)/\(#line) - Error: \(error?.localizedDescription as Any)")
                }
            }
        })
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

