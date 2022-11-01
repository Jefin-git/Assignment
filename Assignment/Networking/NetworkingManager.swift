//
//  NetworkingManager.swift
//  Assignment
//
//  Created by Jefin on 31/10/22.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

protocol NetworkingManageable {
    func getItems(completion: @escaping (Result<[Items], NetworkError>) -> Void)
}

class NetworkingManager: NetworkingManageable {
 
    func getItems(completion: @escaping (Result<[Items], NetworkError>) -> Void) {
        guard let url = URL(string: "https://mocki.io/v1/ea1d04c1-abc6-4d2a-8e97-4fb32bf0c16c") else {
            preconditionFailure(NetworkError.badURL.localizedDescription)
        }
        
        AF.request(url, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                let model = try JSONDecoder().decode([Items].self, from: data)
                completion(.success(model))
                } catch {
                completion(.failure(.decodingError))
                }
            case .failure:
                completion(.failure(.noData))
            }
        }
    }
}
