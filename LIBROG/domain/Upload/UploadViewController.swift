//
//  UploadViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/07/07.
//

import UIKit

class UploadViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let searchBarImage = UIImage()
        searchBar.backgroundImage = searchBarImage
        // Do any additional setup after loading the view.
    }
}

extension UploadViewController: UISearchBarDelegate {
    
}
