//
//  RepoSearchComposer.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation
import UIKit

public final class RepoSearchComposer {
    private init(){}
    
    public static func composedWith(repoSearchLoader: RepoSearchLoader) -> RepoSearchViewController {
        let viewModel = RepoSearchViewModel(repoSearchLoader: repoSearchLoader)
        let viewController = RepoSearchViewController(viewModel: viewModel)
        return viewController
        
    }
}
