//
//  Fetcher.swift
//  RSS
//
//  Created by Joshua Choi on 5/18/21.
//

import UIKit



/**
 Abstract: An ObservableObject used to delegate loading the contents of a URL and its loaded state
 */
class Fetcher: ObservableObject {
    
    // MARK: - Class Vars

    // MARK: - Data
    var data: Data = Data()
    
    // MARK: - URLSession
    var session: URLSession = URLSession(configuration: .default)
    
    // MARK: - FetchState
    var state: FetchState = FetchState.loading

    /// MARK: - Init
    /// - Parameter url: An optional URL value used to load the URL
    init(url: URL?) {
        // MARK: - URL
        guard let url = url else {
            fatalError("\(#file)/\(#line) - Invalid URL")
        }

        // MARK: - URLSession
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            // MARK: - Data
            if let data = data, data.count > 0 {
                self.data = data
                // MARK: - FetchState
                // Update the FetchState
                self.state = .success
            } else {
                // MARK: - FetchState
                // Update the FetchState
                self.state = .failed
            }

            // Execute in the main thread
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }
    
    /// Cancel the current URLSession's requests, if any
    /// - Parameter completion: An optional void completion to execute after cancelling the request
    open func cancel(completion: (() -> Void)? = nil) {
        // MARK: - URLSession
        session.invalidateAndCancel()
        // Execute the completion
        completion?()
    }
}
