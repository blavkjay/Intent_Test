//
//  RepoSearchViewModelTest.swift
//  IntentTakeHomeTestTests
//
//  Created by Admin on 09/10/2021.
//

import Foundation
import XCTest
@testable import IntentTakeHomeTest

class RepoSearchViewModelTest: XCTestCase {
    
    
    
    func test_init_doesntMakeAnyCall() {
        
        let (_, repoSearchLoaderSpy) = makeSUT()
        XCTAssertTrue(repoSearchLoaderSpy.messageCount == 0)
    }
    
    
    func test_onLoad_isCalled() {
        let (sut, _) = makeSUT()
        var onLoadCalled = false
        sut.onload = {
            onLoadCalled = true
        }
        
        sut.searchGit(queryString: "swift")
        
        XCTAssertTrue(onLoadCalled)
    }
    
    func test_onSuccess_calledTheCorrectCallbackInTheRightOrder() {
        let (sut,repoSearchLoaderSpy) = makeSUT()
        var invocationOrder: [String] = []
        
        sut.onload = {
            invocationOrder.append("load")
        }
        
        let exp = expectation(description: "wait for completion")
        
        sut.onSuccess = { data in
            invocationOrder.append("success")
            exp.fulfill()
        }
        
        sut.searchGit(queryString: "swift")
        
        repoSearchLoaderSpy.completeSuccess()
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(invocationOrder, ["load", "success"])
    }
    
    func test_onError_calledTheCorrectCallbackInTheRightOrder() {
        let (sut,repoSearchLoaderSpy) = makeSUT()
        var invocationOrder: [String] = []
        
        sut.onload = {
            invocationOrder.append("load")
        }
        
        let exp = expectation(description: "wait for completion")
        
        sut.onError = { data in
            invocationOrder.append("error")
            exp.fulfill()
        }
        
        sut.searchGit(queryString: "swift")
        
        repoSearchLoaderSpy.completeWithError()
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(invocationOrder, ["load", "error"])
    }
    
    private func makeSUT() -> (sut: RepoSearchViewModel, repoSearchLoaderSpy: RepoSearchLoaderSpy) {
        let repoSearchLoaderSpy = RepoSearchLoaderSpy()
        let sut =  RepoSearchViewModel(repoSearchLoader: repoSearchLoaderSpy)
        return (sut,repoSearchLoaderSpy)
    }
    
    
    
}

public class RepoSearchLoaderSpy: RepoSearchLoader {
    
    private var message = [(queryString: String,page: Int, perPageNumber: Int, completion: (RepoSearchLoader.Result) -> Void)]()
    
    public var messageCount: Int {
        return message.count
    }

    
    public func getRepositoriesFromSearch(queryString: String, page: Int, perPageNumber: Int, completion: @escaping (RepoSearchLoader.Result) -> Void) {
        message.append((queryString,page,perPageNumber,completion))
    }
    
    func completeWithError(index: Int = 0 ) {
        message[index].completion(.failure(.init(message: "")))
    }
    
    func completeSuccess(index: Int = 0) {
        message[index].completion(.success(RepoListResponse(totalCount: 0, incompleteResults: false, items: [Repository(name: "", owner: Owner(login: "", htmlUrl: "", avatarURL: ""), description: "")])))
    }
}
