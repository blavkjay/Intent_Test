//
//  SearchInput.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 09/10/2021.
//

import Foundation

import UIKit

class SearchInput : UIView {
    let textInput : UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        v.returnKeyType = .done
        v.textColor = UIColor.black
        return v
    }()
    
    let wrapper : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.borderWidth = 1
        return v
    }()
    
    let searchIcon : UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        v.image = UIImage(named: "search icon")
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
        arrangelayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchInput  {
    
    func addLayout() {
        addSubview(wrapper)
        addSubview(searchIcon)
        addSubview(textInput)
    }
    
    func arrangelayout() {
    
        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(equalTo: topAnchor),
            wrapper.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapper.trailingAnchor.constraint(equalTo: trailingAnchor),
            wrapper.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 16),
            
            searchIcon.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            
           searchIcon.heightAnchor.constraint(equalToConstant: 15),
            searchIcon.widthAnchor.constraint(equalToConstant: 15),
            
            textInput.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 20),
            textInput.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -10),
            textInput.centerYAnchor.constraint(equalTo: searchIcon.centerYAnchor)
        
        ])
        
    }
    
    
}
