//
//  DataParser.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 3/6/22.
//

import Foundation

class DataParser {
        
    func getBreedData() {
        getData(fromUrlRequest: createUrlRequest()) { (result) in
            switch result {
                case .success(let data):
                    print("Request successful: \(data)")
                case .failure(let error):
                    print("Request failed: \(error)")
            }
        }
    }
    
    private func parse(jsonData: Data) -> Array<Breed> {
        do {
            return try JSONDecoder().decode(Array<Breed>.self, from: jsonData)
        } catch {
            print("Parsing Error: \(error)")
        }
        return Array()
    }
    
    private func createUrlRequest () -> URLRequest {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-api-key": ,
            "Content-Type": "application/json"
        ]
        
        return request
    }
    
    private func getData(fromUrlRequest urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            breeds = self.parse(jsonData: data)
        }
        task.resume()
    }
}
