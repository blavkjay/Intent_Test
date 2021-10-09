//
//  RepoSearchViewModel.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation


public class RepoSearchViewModel {
    
    let repoSearchLoader: RepoSearchLoader
    
    init(repoSearchLoader: RepoSearchLoader){
        self.repoSearchLoader = repoSearchLoader
    }
    
    var onload: (() -> Void)?
    var onSuccess: (([Repository]) -> Void)?
    var onError: ((String) -> Void)?
    
    func searchGit(queryString: String) {
        onload?()
        
        repoSearchLoader.getRepositoriesFromSearch(queryString: queryString, page: 1, perPageNumber: 20) { [weak self] result in
            switch result {
            case let .success(model):
                print(model)
                self?.onSuccess?(model.items)
            case let .failure(error):
                self?.onError?(error.message)
            }
        }
    }
    
}
