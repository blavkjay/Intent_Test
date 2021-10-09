//
//  SearchResultTableViewCell.swift
//  IntentTakeHomeTest
//
//  Created by Admin on 09/10/2021.
//

import Foundation
import UIKit

final class SearchResultTableViewCell: UITableViewCell {
    
    
    let containerView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.shadowOffset = CGSize(width: 0, height: 3)
        v.layer.shadowRadius = 3
        v.layer.shadowOpacity = 0.3
        v.layer.shadowPath = UIBezierPath(roundedRect: v.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        v.layer.shouldRasterize = true
        v.layer.rasterizationScale = UIScreen.main.scale
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let userImageView: UIImageView = {
       let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
       return v
    }()
    
    var userNameLabel : UILabel = {
        let v  = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Nigeria"
        v.textAlignment = .left
        v.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        v.numberOfLines = 0
        return v
    }()
    
    var titleLabel : UILabel = {
        let v  = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Nigeria"
        v.textAlignment = .left
        v.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        v.numberOfLines = 0
        return v
    }()
    
    var descriptionLabel : UILabel = {
        let v  = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Nigeria"
        v.textAlignment = .left
        v.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        v.numberOfLines = 0
        return v
    }()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
        userImageView.backgroundColor = .lightGray
        descriptionLabel.numberOfLines = 0
        userImageView.contentMode = .scaleAspectFill
        isAccessibilityElement = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = 15
        userImageView.layer.masksToBounds = true
    }
    
    private func setupViewLayout(){
        
        addSubview(containerView)
        containerView.addSubview(userImageView)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 20),
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 20),
            userImageView.heightAnchor.constraint(equalToConstant: 30),
            userImageView.widthAnchor.constraint(equalToConstant: 30),
            
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 15),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            userNameLabel.topAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: -15),
            
            titleLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with data: Repository?) {
        ImageCacheManager.fetchImageData(from: data?.owner?.avatarURL ?? "") { imageData in
            DispatchQueue.main.async { [weak self] in
                let image: UIImage = UIImage(data: imageData as Data) ?? UIImage()
                self?.userImageView.image = image
            }
        }
        
        userNameLabel.text = data?.name
        titleLabel.text = data?.owner?.login
        descriptionLabel.text = data?.description
    }
    
}

public extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        //messageLabel.font = Font().getBoldFont(ofSize: 24)
        messageLabel.sizeToFit()
        emptyView.addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
        
    }
}
