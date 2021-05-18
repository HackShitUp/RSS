//
//  FetchState.swift
//  RSS
//
//  Created by Joshua Choi on 5/18/21.
//

import UIKit


/**
 Abstract: Enum used to delegate the current fetch state when used with the Fetcher class
 */
enum FetchState: Int, CaseIterable {
    /// Indicates that the Fetcher is loading
    case loading = 0
    /// Indicates that the Fetcher succeeded loading
    case success = 1
    /// Indicates that the Fetcher failed loading
    case failed = 2
}
