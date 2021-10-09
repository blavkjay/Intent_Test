//
//  RepoSearchListServiceTest.swift
//  IntentTakeHomeTestTests
//
//  Created by Admin on 09/10/2021.
//

import Foundation
import XCTest
@testable import IntentTakeHomeTest

class RepoSearchListServiceTest: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    

    
    func test_getRepositoriesFromSearch_requestDataFromURLRequest() {
        //Given
        let (sut, client) = makeSUT()
        //When
        sut.getRepositoriesFromSearch(queryString: "word", page: 1, perPageNumber: 20) { _ in }
        //Then
        XCTAssertEqual(client.requestedURLs.count, 1, "client was called")
    
    }
    
    func test_sut_CalledClientWithCorrectData() {
        let (sut, client) = makeSUT()
        
        let passedQuery: [String: Any] = ["q": "word",
                           "page": 1,
                           "per_page": 20]
        
        
        sut.getRepositoriesFromSearch(queryString: passedQuery["q"] as! String, page: passedQuery["page"] as! Int, perPageNumber: passedQuery["per_page"] as! Int) { _ in }
        
        XCTAssertEqual(passedQuery["q"] as! String, client.paramPassed[0]["q"] as! String)
        XCTAssertEqual(passedQuery["page"] as! Int, client.paramPassed[0]["page"] as! Int)
        XCTAssertEqual(passedQuery["per_page"] as! Int, client.paramPassed[0]["per_page"] as! Int)
        
    }
    
    func test_getRepositoriesFromSearch_deliversResponseOn200Response() {
        //Given
        let (sut, client) = makeSUT()
        //stub
        let owner = Owner(login: "just saying", htmlUrl: "https://any-url.com", avatarURL: "https://any-url1.com")
        let repo = Repository(name: "Juwon", owner: owner, description: "just describe")

        let repoList = [repo]
        
        //When
       
        var expectedRepoList: RepoListResponse?
        let exp = expectation(description: "wait for load completion")
    
        sut.getRepositoriesFromSearch(queryString: "Swift", page: 1, perPageNumber: 20) { result in
            switch result {
            case .success(let response):
                expectedRepoList = response
            default:
                XCTFail("expectation failed")
            }
            exp.fulfill()
        }
        
        //Then
        let json1 : [String: Any] = [ "total_count": 7,
                                      "incomplete_results": false, "items": [["name": "Juwon","description": "just describe", "owner": [
            "login": "just saying", "html_url": "https://any-url.com", "avatar_url": "https://any-url1.com"
        ]]]]
        
        let jsonData = makeRepoJSON(json1)
        
        
        client.complete(withStatusCode: 200, data: jsonData)
        
        wait(for: [exp], timeout: 5.0)
        XCTAssertEqual(expectedRepoList?.items, repoList, "repo data gotten")
    }
    
    func test_getCountriesAndCapital_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let errorCodes = [199,201,300,400,500]

        let localError: NSError = NSError(domain: "test", code: 0)
        let expectedError : RepoSearchError = RepoSearchError.init(message: localError.localizedDescription)

        var returnedError : RepoSearchError?
        for _ in errorCodes {
            let exp = expectation(description: "wait for load completion")
            sut.getRepositoriesFromSearch(queryString: "Swift", page: 1, perPageNumber: 20) { result in
                switch result {
                case .failure(let error):
                    returnedError = error
                default:
                    XCTFail("expectation failed")
                }

            }
            client.complete(with: localError)
            exp.fulfill()
            wait(for: [exp], timeout: 1.0)
        }

        XCTAssertEqual(expectedError.localizedDescription, returnedError?.localizedDescription)
    }
    
    
    private func makeSUT() -> (sut: RepoSearchLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut =  RepoSearchListService(apiClient: client)
        return (sut,client)
    }
    
    private func makeRepoJSON(_ repo: [String: Any]) -> Data {
        let json = repo
       return try! JSONSerialization.data(withJSONObject: json)
    }
}



public class HTTPClientSpy: ApiClient {
    
    
   
    private var messages = [(url: String, params: [String: Any], completion: (Result<Data?, Error>) -> Void)]()
    
    var requestedURLs : [String] {
        return messages.map { $0.url }
    }
    
    var paramPassed: [[String: Any]] {
        return messages.map {$0.params}
    }
    
    public func get(url: String, params: [String : Any], completion: @escaping (Result<Data?, Error>) -> Void) {
        messages.append((url, params,completion))
    }
    
    func complete(with error: Error, at index: Int = 0 ) {
        messages[index].completion(.failure(error))
    }
    
    func complete(withStatusCode code: Int,data: Data, at index: Int = 0 ) {
        messages[index].completion(.success(data))
    }
    
  
}
