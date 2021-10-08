//
//  RemoteRepoListResponse.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation


struct RemoteRepoListResponse : Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [RemoteRepository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    func toModel() -> RepoListResponse {
        return RepoListResponse(totalCount: totalCount, incompleteResults: incompleteResults, items: items.map{ $0.toModel()})
    }
}

struct RemoteRepository: Codable {
    let id: Int?
    let name: String?
    let owner: RemoteOwner?
    let description: String?
    let forksURL: String?
    let forks : Int?
    let watchers: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case description
        case forksURL = "forks_url"
        case forks
        case watchers
    
    }
    
    func toModel() -> Repository {
        return Repository(id: id, name: name, owner: owner?.toModel() , description: description, forksURL: forksURL, forks: forks, watchers: watchers)
    }
}

struct RemoteOwner: Codable {
    
    let login: String?
    let id: Int?
    let avatarURL: String?
    let publicRepos : Int?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case publicRepos = "public_repos"
    }
    
    func toModel() -> Owner {
        return Owner(login: login, id: id, avatarURL: avatarURL, publicRepos: publicRepos)
    }
}
