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
        
    }
}
