//
//  NewsStory.swift
//  EG Stocks
//
//  Created by Bekzat Kalybayev on 28.02.2022.
//

import Foundation

/// Represent news story
struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}
