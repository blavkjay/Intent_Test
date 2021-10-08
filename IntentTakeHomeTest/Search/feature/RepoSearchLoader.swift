//
//  RepoSearchLoader.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation


public struct RepoSearchError : Error {
    let message : String
}

public protocol RepoSearchLoader {
    
    typealias Result = Swift.Result<RepoListResponse,RepoSearchError>
    func getRepositoriesFromSearch(queryString : String, page : Int , perPageNumber : Int, completion : @escaping (Result) -> Void)
}



