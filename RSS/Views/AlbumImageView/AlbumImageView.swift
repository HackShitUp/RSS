//
//  AlbumImageView.swift
//  RSS
//
//  Created by Joshua Choi on 5/18/21.
//

import UIKit
import SwiftUI



/**
 Abstract: View subclass that enables loading remote images async (cache not implemented)
 */
struct AlbumImageView: View {
    
    // MARK: - Class Vars
    
    // MARK: - Fetcher
    @StateObject var fetcher: Fetcher
    
    // MARK: - Image
    fileprivate var loading, failed: Image
    
    // MARK: - View
    var body: some View {
        image().resizable()
    }
    
    /// MARK: - Init
    /// - Parameters:
    ///   - url: An optional URL value representing the remote Image URL
    ///   - loading: An Image placeholder representing an image state for loading
    ///   - failed: An Image placeholder representing an image state for failed
    init(url: URL?, loading: Image = Image(uiImage: UIImage()), failed: Image = Image(uiImage: UIImage())) {
        // MARK: - Fetcher
        _fetcher = StateObject(wrappedValue: Fetcher(url: url))
        // MARK: - Image
        self.loading = loading
        self.failed = failed
    }
    
    /// Returns an Image based on the Fetcher's loaded state loading the contents of its URL
    /// - Returns: An Image view
    fileprivate func image() -> Image {
        // MARK: - Fetcher
        switch fetcher.state {
        case .loading:
            return loading
        case .failed:
            return failed
        default:
            // MARK: - UIImage
            if let image = UIImage(data: fetcher.data) {
                return Image(uiImage: image)
            } else {
                return failed
            }
        }
    }
}
