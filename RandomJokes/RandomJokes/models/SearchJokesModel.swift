//
//  SearchJokesModel.swift
//  RandomJokes
//
//  Created by Ahmed Ateek on 2/26/19.
//  Copyright © 2019 Ahmed-Ateek. All rights reserved.
//

import Foundation

struct SearchJokesModel: Codable {
    let currentPage, limit, nextPage, previousPage: Int
    let results: [Result]
    let searchTerm: String
    let status, totalJokes, totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case limit
        case nextPage = "next_page"
        case previousPage = "previous_page"
        case results
        case searchTerm = "search_term"
        case status
        case totalJokes = "total_jokes"
        case totalPages = "total_pages"
    }


struct Result: Codable {
    let id, joke: String
    }
    
}
