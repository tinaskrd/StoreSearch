//
//  SearchViewController.swift
//  StoreSearch
//
//  Created by Tina  on 17.12.25.
//

import UIKit

class SearchViewController: UIViewController {

    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
        }
    }
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.contentInset = UIEdgeInsets(top: 51, left: 0, bottom: 0, right: 0)
        var cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        for _ in 0...2 {
            let searchResult = SearchResult()
            searchResult.artistName = searchBar.text!
            searchResults.append(searchResult)
        }
        hasSearched = true
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.artistName
            cell.artistNameLabel.text = searchResult.artistName
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}

// MARK: - Position
extension SearchViewController {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
