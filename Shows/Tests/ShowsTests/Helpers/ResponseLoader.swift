//
//  ResponseLoader.swift
//  MoviesDB-LuanaTests
//
//  Created by Luana Chen Chih Jun on 19/04/21.
//

import Foundation
@testable import Shows

class ResponseLoader {
    static func getResponseFrom<T: Decodable>(resource: String, decodable: T.Type) -> T {
           guard let url = Bundle.module.url(forResource: resource, withExtension: "json") else { fatalError("Couldn't load json file") }
           do {
               let jsonData = try Data(contentsOf: url)
               let decoder = JSONDecoder()
               decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(decodable, from: jsonData)
               return response
           } catch {
               fatalError("Couldn't decode json file")
           }
       }
}
