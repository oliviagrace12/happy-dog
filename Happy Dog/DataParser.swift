//
//  DataParser.swift
//  Happy Dog
//
//  Created by Olivia Chisman on 3/6/22.
//

import Foundation

class DataParser {
        
    func getBreedData() {
         getBreedDataFromHttpRequest()
//         getBreedDataFromLocalFile()
    }
    
    private func getBreedDataFromHttpRequest() {
        loadJson(fromUrlRequest: createUrlRequest()) { (result) in
            switch result {
                case .success(let data):
                    print("Request successful: \(data)")
                case .failure(let error):
                    print("Request failed: \(error)")
            }
        }
    }
    
    private func getBreedDataFromLocalFile() {
        if let data = readLocalFile(forName: "breeds") {
            breeds = parse(jsonData: data)
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
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("File reading error: \(error)")
        }
        
        return nil
    }
    
    private func createUrlRequest () -> URLRequest {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "x-api-key": "ec87e0e5-f352-4670-8d41-f674c3a638de",
            "Content-Type": "application/json"
        ]
        
        return request
    }
    
    private func loadJson(fromUrlRequest urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            breeds = self.parse(jsonData: data)
        }
        task.resume()
    }
}
