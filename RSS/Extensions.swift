//
//  Extensions.swift
//  RSS
//
//  Created by Joshua Choi on 5/18/21.
//

import UIKit



extension Date {
    /// Gets the date of a Date object and returns a readable String value. Defaults to "LLL, yyy" (ABBREVIATED MONTH, Year)
    /// - Parameter dateFormat: A String value to set the DateFormatter object. Use the following formats to return different types of String:
    func readableDate(_ dateFormat: String = "LLL, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let readableDate = dateFormatter.string(from: self)
        return readableDate
    }
}



extension String {
    /// Gets an optional array of Date objects representing dates found in the string
    var dates: [Date]? {
        get {
            // MARK: - NSTextCheckingResult.CheckingType
            let types: NSTextCheckingResult.CheckingType = [.date]
            let detector = try? NSDataDetector(types: types.rawValue)
            
            // Parse the string
            let range = NSMakeRange(0, self.utf16.count)
            let matches = detector?.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: range)
            
            // Filter out date match types and map them to the Date object values
            guard let allMatches = matches?.filter({$0.resultType == .date}).map({$0.date!}) else {
                return nil
            }
            
            // Return all the matches found
            return allMatches
        }
    }
}
