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
                // Print the received data and decoding error for debugging
                print("Failed to decode response: \(decodingError)")
                print("Response data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                completion(.failure(decodingError))
            }
        }.resume()
    }
    
    func postRequest<T: Decodable, U: Encodable>(
            url: URL,
            body: U,
            responseType: T.Type,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.POST.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("JSON Payload: \(jsonString)")
                }
            } catch {
                completion(.failure(error))
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                        print("Response Body: \(responseBody)")
                        completion(.failure(NSError(domain: "HTTP error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: responseBody])))
                    } else {
                        completion(.failure(NSError(domain: "HTTP error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)])))
                    }
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedObject = try JSONDecoder().decode(responseType, from: data)
                    completion(.success(decodedObject))
                } catch {
                    print("Failed to decode response: \(error)")
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    completion(.failure(error))
                }
            }.resume()
        }
}
