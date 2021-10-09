//
//  URLSessionHttpClient.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation


final class URLSessionHttpClient: ApiClient {

    
    let session = URLSession.shared
    
    func get(url: String, params: [String:Any] ,completion: @escaping (Result<Data?, Error>) -> Void) {
        
        guard var urlComponents = URLComponents(string: url) else {
            return
        }
        
        //add params to the url
        urlComponents.queryItems = params.map { (arg) -> URLQueryItem in
            let (key, value) = arg
            return URLQueryItem(name: key, value: "\(value)")
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = urlComponents.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        //MARK:- ADD TOKEN
        urlRequest.setValue("token ", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("error \(httpResponse.statusCode)")
            }
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(data))
        }.resume()
    }
    
}
