//
//  RepoSearchListService.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation

public final class RepoSearchListService: RepoSearchLoader {
    
    
    private let apiClient: ApiClient
    
    public init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    public func getRepositoriesFromSearch(queryString: String, page: Int, perPageNumber: Int, completion: @escaping (RepoSearchLoader.Result) -> Void) {
        let url = "https://api.github.com/search"
        let params: [String:Any] = ["q": queryString,
                                    "page": page,
                                    "per_page": perPageNumber]
        
        apiClient.get(url: url, params: params) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                let decodeData = try? JSONDecoder().decode(RemoteRepoListResponse.self, from: data)
                guard let response = decodeData else { return }
                completion(.success(response.toModel()))
                
            case .failure(let error):
                completion(.failure(.init(message: error.localizedDescription)))
            }
        }
    }
    
    
}
