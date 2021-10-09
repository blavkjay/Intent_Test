//
//  RepoListResponse.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation

public struct RepoListResponse {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
}

public struct Repository: Equatable {
   
    let name: String?
    let owner: Owner?
    let description: String?
    public static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.name == rhs.name && lhs.owner == rhs.owner && lhs.description == rhs.description
    }
    
}

public struct Owner: Equatable {
    
    let login: String?
    let htmlUrl: String?
    let avatarURL: String?
}
