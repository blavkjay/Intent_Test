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
        
        layout.didSelectRepo = { url in
            if let link = URL(string: url) {
                UIApplication.shared.open(link)
            }
        }
        
        layout.searchQueryEntered = { [weak self] query in
            guard let self = self else { return }
            self.viewModel?.searchGit(queryString: query)
        }
        
        viewModel?.onSuccess = { [weak self] data in
            guard let self = self else { return }
            self.layout.data = data
        }
        
        viewModel?.onError = { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showErrorAlert(message: errorMessage)
            }
            
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


extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {  [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
