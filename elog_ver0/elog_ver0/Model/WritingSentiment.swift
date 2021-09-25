//
//  WritingSentiment.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/09/26.
//

import Foundation

struct WritingSentiment: Codable {
    let document: Document
    let sentences: [Sentence]
}

// MARK: - Document
struct Document: Codable {
    let sentiment: String
    let confidence: Confidence
}

// MARK: - Confidence
struct Confidence: Codable {
    let negative, positive, neutral: Double
}

// MARK: - Sentence
struct Sentence: Codable {
    let content: String
    let offset, length: Int
    let sentiment: String
    let confidence: Confidence
    let highlights: [Highlight]
}

// MARK: - Highlight
struct Highlight: Codable {
    let offset, length: Int
}
