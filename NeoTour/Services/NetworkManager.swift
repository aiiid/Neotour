//
//  NetworkManager.swift
//  NeoTour
//
//  Created by Ai Hawok on 01/07/2024.
//
import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    // Request with no body and expecting a response
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedObject))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
    
    // Request with a body and expecting a response
    func request<T: Decodable, U: Encodable>(
        url: URL,
        method: HTTPMethod,
        body: U,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch let encodingError {
            completion(.failure(encodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedObject))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
    
    // Request with a body and no response
    func requestNoResponse<U: Encodable>(
        url: URL,
        method: HTTPMethod,
        body: U,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch let encodingError {
            completion(.failure(encodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                return
            }
            
            completion(.success(()))
        }.resume()
    }
}
