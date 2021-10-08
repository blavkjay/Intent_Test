//
//  ApiClient.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation

public protocol ApiClient {
    func get(url: String, params: [String:Any] ,completion: @escaping (Result<Data?, Error>) -> Void) 
}
