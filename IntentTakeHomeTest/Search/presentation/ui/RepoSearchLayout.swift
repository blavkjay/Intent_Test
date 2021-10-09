//
//  RepoSearchLayout.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 08/10/2021.
//

import Foundation
import UIKit

public final class RepoSearchLayout: UIView {
    
    var searchQueryEntered: ((String) -> Void)?
    var didSelectRepo: ((String) -> Void)?
    
    var data : [Repository]?{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let searchInput : SearchInput = {
        let v = SearchInput()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textInput.placeholder = "Enter github repo"
        return v
    }()
    
    let tableView: UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchInput.textInput.delegate = self
        arrangeLayout()
        addLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func arrangeLayout() {
        addSubview(activityIndicator)
        addSubview(searchInput)
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = self.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "\(SearchResultTableViewCell.self)")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func addLayout() {
        NSLayoutConstraint.activate([
        
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            searchInput.topAnchor.constraint(equalTo: topAnchor),
            searchInput.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchInput.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchInput.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: searchInput.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
}
extension RepoSearchLayout: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        if text.count >= 5 {
            searchQueryEntered?(text)
        }
    }
}

extension RepoSearchLayout: UITableViewDelegate, UITableViewDataSource {
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchResultTableViewCell.self)", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()}
        cell.configureCell(with: data?[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = data?[indexPath.row].owner?.htmlUrl else { return }
        didSelectRepo?(url)
        
    }
}
