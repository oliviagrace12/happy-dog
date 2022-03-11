//
//  DataParser.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 3/6/22.
//

import Foundation

class DataParser {
    
    func parse(jsonData: Data) -> Array<Breed> {
        do {
            return try JSONDecoder().decode(Array<Breed>.self, from: jsonData)
        } catch {
            print("Parsing Error: \(error)")
        }
        return Array()
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("File reading error: \(error)")
        }
        
        return nil
    }
    
    func createUrlRequest () -> URLRequest {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-api-key": ,
            "Content-Type": "application/json"
        ]
        
        return request
    }
    
    func loadJson(fromUrlRequest urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlSession = URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        urlSession.resume()
    }
}
