//
//  RepoSearchViewController.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation
import UIKit

final public class RepoSearchViewController: UIViewController {
    
    var layout = RepoSearchLayout()
    var viewModel: RepoSearchViewModel?
    
    convenience init(viewModel: RepoSearchViewModel) {
        self.init()
        self.viewModel = viewModel
        view.addSubview(layout)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(layout)
        layout.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        title = "Search GitHub"
        bindView()
    }
    
    private func bindView() {
        layout.searchQueryEntered = { query in
            print(query)
        }
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
         
            layout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            layout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            layout.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
