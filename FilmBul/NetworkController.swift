//
//  NetworkController.swift
//  FilmBul
//
//  Created by Hüseyin Savaş on 11.12.2022.
//

import Foundation

class NetworkController {
    
    func getData(query: String, completion: @escaping (MovieResult?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?s=\(query)&apikey=86f9081f&type=movie")!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            var result: MovieResult?
            let decoder = JSONDecoder()
            result = try? decoder.decode(MovieResult.self, from: data)
            guard result != nil else { return completion(nil) }
            completion(result)
        }.resume()
    }
}
