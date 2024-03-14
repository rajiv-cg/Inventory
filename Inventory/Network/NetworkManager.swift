//
//  NetworkManager.swift
//  SwiftUIDemo
//
//  Created by Mayur Rangari on 07/03/24.
//

import Foundation

enum DemoError: Error {
    case BadURL
    case NoData
    case DecodingError
}

enum RequestType: String {
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}


class NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping(Result<T, DemoError>) -> Void) {
       
        aPIHandler.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func updateRequest<T: Codable>(type: T.Type, url: URL, requestType: RequestType, parameters: [String: Any], completion: @escaping(Result<T, DemoError>) -> Void) {
        guard let apiHandler = aPIHandler as? APIHandler else {
            completion(.failure(.DecodingError))
            return
        }

        apiHandler.updateData(url: url, parameters: parameters, requestType: requestType) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

protocol APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping(Result<Data, DemoError>) -> Void)
    func updateData(url: URL, parameters: [String: Any], requestType: RequestType, completion: @escaping(Result<Data, DemoError>) -> Void)

}

class APIHandler: APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping(Result<Data, DemoError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            completion(.success(data))
           
        }.resume()
    }
    
    func updateData(url: URL, parameters: [String: Any], requestType: RequestType, completion: @escaping(Result<Data, DemoError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating JSON: \(error)")
            completion(.failure(.DecodingError))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            completion(.success(data))
        }.resume()
    }
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, DemoError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, DemoError>) -> Void) {
        let commentResponse = try? JSONDecoder().decode(type.self, from: data)
        if let commentResponse = commentResponse {
            return completion(.success(commentResponse))
        } else {
            completion(.failure(.DecodingError))
        }
    }
    
}
