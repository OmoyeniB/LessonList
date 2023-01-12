//
//  NetworkManager.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 05/01/2023.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func makeAPICall<T: Codable>(to url: URL, expecting: T.Type) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkManagerProtocol {
   
    func makeAPICall<T: Codable>(to url: URL, expecting: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
}
