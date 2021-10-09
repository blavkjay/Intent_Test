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
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
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
