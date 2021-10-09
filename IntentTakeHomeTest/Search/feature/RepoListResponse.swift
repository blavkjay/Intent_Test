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

public struct Repository {
    let id: Int?
    let name: String?
    let owner: Owner?
    let description: String?
    let forksURL: String?
    let forks : Int?
    let watchers: Int?
}

public struct Owner {
    
    let login: String?
    let id: Int?
    let url: String?
    let htmlUrl: String?
    let avatarURL: String?
    let publicRepos : Int?

}
