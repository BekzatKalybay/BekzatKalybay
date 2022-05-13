//
//  SearchResultsViewController.swift
//  EG Stocks
//
//  Created by Bekzat Kalybayev on 23.02.2022.
//

import UIKit

// Whenever we tap on search results, we want to pass that back to WatchListViewController, so can present details about it
/// Delegate for search results
protocol SearchResultsViewControllerDelegate: AnyObject {
    /// Notify delegate of selection
    func searchResultsViewControllerDidSelect(searchResult: SearchResult)
}

/// VC to show search results
final class SearchResultsViewController: UIViewController {
    /// Delegate
    weak var delegate: SearchResultsViewControllerDelegate?
    
    /// Collection of results
    private var results: [SearchResult] = []
    
    /// Primary view
    private let tableView: UITableView = {
        let table = UITableView()
        // Register a cell
        table.register(SearchResultTableViewCell.self,
                       forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - Private
    
    /// Set up our tableView
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Public
    
    /// Update results on VC
    /// - Parameter results: Collection of new results
    public func update(with results: [SearchResult]) {
        self.results = results
        tableView.isHidden = results.isEmpty
        tableView.reloadData()
    }

}

//MARK: - TableView

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.identifier,
            for: indexPath)
        let model = results[indexPath.row]
        
        cell.textLabel?.text = model.displaySymbol
        cell.detailTextLabel?.text = model.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = results[indexPath.row]
        delegate?.searchResultsViewControllerDidSelect(searchResult: model)
    }
    
}
