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

    let name: String?
    let owner: RemoteOwner?
    let description: String?
    
    enum CodingKeys: String, CodingKey {

        case name
        case owner
        case description
    }
    
    func toModel() -> Repository {
        return Repository(name: name, owner: owner?.toModel() , description: description)
    }
}

struct RemoteOwner: Codable {
    let login: String?
    let avatarURL: String?
    let htmlUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlUrl = "html_url"
    }
    
    func toModel() -> Owner {
        return Owner(login: login,htmlUrl: htmlUrl, avatarURL: avatarURL)
    }
}
