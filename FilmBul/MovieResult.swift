//
//  MovieResult.swift
//  FilmBul
//
//  Created by Hüseyin Savaş on 8.12.2022.
//

import Foundation

struct MovieResult: Codable {
    let search: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
