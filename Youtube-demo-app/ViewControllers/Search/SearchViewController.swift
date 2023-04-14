//
//  SearchViewController.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import Foundation
import Combine
import UIKit

enum SearchStatus {
    case initial
    case noResult
    case notStarted
    case error
    case resultsFound

    var shouldShowList: Bool {
        switch self {
        case .error, .notStarted, .noResult: return false
        case .initial, .resultsFound: return true

        }
    }
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var fullModel: SearchResultModel? = nil
    @Published  private var dataSource: [VideoSnippetModel]? = nil
    
    @Published private var isActionInProgress: Bool = false
    @Published private var state = SearchStatus.initial

    private var subscriptions = Set<AnyCancellable>()
    private var searchSubscription: AnyCancellable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        state = .notStarted
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSubscriptions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        subscriptions.forEach({ $0.cancel() })
        searchSubscription?.cancel()
        subscriptions.removeAll()
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Private
    private func setupSubscriptions() {
        $dataSource
            .receive(on: DispatchQueue.main)
            .sink { [weak self] new in
                guard let self = self else { return }
                
                self.tableView.reloadData()
                self.checkNoResults()
                
        }.store(in: &subscriptions)
        
        $state.receive(on: DispatchQueue.main).sink { [weak self] new in
            guard let self = self else { return }
            self.tableView.isHidden = !new.shouldShowList
//            self.emptyStateView.setup(with: new)
            self.isActionInProgress = false
        }.store(in: &subscriptions)
        
        $isActionInProgress.sink(receiveValue: { [weak self] new in
            guard let self = self, new != self.isActionInProgress else { return }

            DispatchQueue.main.async {
                self.spinner.isHidden = !new
                self.tableView.isHidden = new || !self.state.shouldShowList
                new ? self.spinner.startAnimating() : self.spinner.stopAnimating()
            }
        }).store(in: &subscriptions)
        
    }
    
    private func checkNoResults() {
        // TODO: -
    }
    
    private func handleError(message: String? = nil) {
        self.showError(with: message)
        self.dataSource = nil
        self.fullModel = nil
    }
    
    private func search(for keyword: String = "") {
        isActionInProgress = true

        searchSubscription = SearchService().searchVideo(for: keyword).sink { error in
            switch error {
            case let .failure(error):
                print("Couldn't get users: \(error)")
                self.handleError(message: error.customMessage)
                self.state = .error

            case .finished: break
            }
            self.isActionInProgress = false
            
        } receiveValue: { value in
            
            self.fullModel = value
            if let items = value.items, !items.isEmpty {
                self.dataSource = items
                self.state = .resultsFound
            } else {
                self.dataSource = nil
                self.state = .noResult
            }
            
        }

    }
    
}

//MARK: - TableView DataSource
extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = dataSource?[indexPath.row] else {
            return UITableViewCell()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultVideoTVC().identifier) as? SearchResultVideoTVC {
            cell.bindModel(model)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

//MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSubscription?.cancel()
        
        if searchText.isEmpty {
            fullModel = nil
            dataSource = nil
            state = .notStarted
        } else {
            search(for: searchText)
        }
    }
}

