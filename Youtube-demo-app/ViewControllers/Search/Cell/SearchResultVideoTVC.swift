//
//  SearchResultVideoTVC.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import UIKit
import Combine

class SearchResultVideoTVC: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    private var model: VideoSnippetModel? = nil
    private var cancellable: AnyCancellable? = nil
    
    // MARK: -
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""

        thumbnail.image = nil
        model = nil
        cancellable?.cancel()
        cancellable = nil
    }
    
    func bindModel(_ model: VideoSnippetModel) {
        self.nameLabel.text = model.snippet?.title ?? "oops! T_T"
        
        guard let urlString = model.snippet?.thumbnails?.medium?.url, let url = URL(string: urlString) else { return }
        cancellable = URLSession.shared
            .downloadTaskPublisher(for: url)
            .map { UIImage(contentsOfFile: $0.url.path)! }
            .receive(on: DispatchQueue.main)
            .replaceError(with: UIImage(named: "")) // TODO: - add default pic
            .assign(to: \.image, on: self.thumbnail)
        
    }
    
}

