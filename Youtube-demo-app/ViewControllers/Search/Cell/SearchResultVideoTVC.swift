//
//  SearchResultVideoTVC.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import UIKit

class SearchResultVideoTVC: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
//    @IBOutlet weak var dateAdded: UILabel!
//    @IBOutlet weak var likes: UILabel!
    
    // MARK: -
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
//        dateAdded.text = ""
//        likes.text = ""
        thumbnail.image = nil
    }
    
    func bindModel(_ model: VideoSnippetModel) {
        self.nameLabel.text = model.snippet?.title ?? "oops! T_T"
        
    }
    
}

