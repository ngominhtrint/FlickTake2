//
//  SearchViewController.swift
//  MovieViewer
//
//  Created by TriNgo on 7/11/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit
import MBProgressHUD

class SearchViewController: UIViewController {
    
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var searchBar = UISearchBar()
    var cancelButton = UIBarButtonItem()
    var filtersButton = UIBarButtonItem()
    var refreshControl: UIRefreshControl!
    
    var name: String = ""
    var includeAdult: String = "true"
    var releaseYear: String?
    var primaryYear: String?
    var filteredMovies: [Movie]?
    var movies: [Movie]? {
        didSet {
            filteredMovies = movies
        }
    }
    var releaseYearRow: Int = 0
    var primaryYearRow: Int = 0
    var year = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        initYearArray()
        initNavigationBar()
        setupRefreshControls()
        setTheme()
        
        searchMovies()
    }

    func initYearArray() {
        year.append("Any")
        for index in 0...100 {
            year.append(String(1950 + index))
        }
        releaseYear = year[0]
        primaryYear = year[0]
    }
    
    func initNavigationBar() {
        cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SearchViewController.onCancelTap))
        filtersButton = UIBarButtonItem(title: "Filters", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SearchViewController.onFiltersTap))
        
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItems = [filtersButton, cancelButton]
        searchBar.showsCancelButton = false
    }
    
    func setupRefreshControls() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        // remove showing empty row for table incase network error
        tableView.tableFooterView = UIView()
    }
    
    func setTheme() {
        tableView.backgroundColor = UIColor.blackColor()
        
        searchBar.tintColor = themeColor
        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = themeColor
        searchBar.keyboardAppearance = .Dark
        
        refreshControl.backgroundColor = UIColor.blackColor()
        refreshControl.tintColor = themeColor
        
        errorView.backgroundColor = UIColor.whiteColor()
        errorView.alpha = 0.8
        errorLabel.textColor = UIColor.redColor()
    }
    
    func onCancelTap() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func onFiltersTap() {
        let filterVC = self.storyboard!.instantiateViewControllerWithIdentifier("FiltersViewController") as! FiltersViewController
        filterVC.delegate = self
        filterVC.includeAdult = includeAdult
        filterVC.releaseYearRow = releaseYearRow
        filterVC.primaryYearRow = primaryYearRow
        self.navigationController!.pushViewController(filterVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchMovies() {
        hideError()
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        // make network request
        TMDBClient.searchMovies(name, includeAdult: includeAdult, releaseYear: releaseYear!, primaryYear: primaryYear!, page: nil, language: nil, complete: {(movies: [Movie]?, error: NSError?) -> Void in
            
            // Hide HUD once the network request comes back (must be done on main UI thread)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            // end refreshing
            self.refreshControl.endRefreshing()
            
            guard error == nil else {
                self.movies?.removeAll()
                self.tableView.reloadData()
                self.showError(error!)
                return
            }
            
            self.tableView.hidden = movies?.count == 0
            self.noResultView.hidden = movies?.count != 0
            
            self.movies = movies
            self.tableView.reloadData()
        })
    }

    func hideError() {
        errorView.hidden = true
    }
    
    func showError(error: NSError) {
        errorLabel.text = error.localizedDescription
        errorView.hidden = false
    }
    
    func onRefresh() {
        searchMovies()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var indexPath: NSIndexPath?
        if let cell = sender as? UITableViewCell {
            indexPath = tableView.indexPathForCell(cell)
        }
        
        let movie = filteredMovies![indexPath!.row]
        let movieDetailView = segue.destinationViewController as! MovieDetailViewController
        movieDetailView.movie = movie
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    // Tells the data source to return the number of rows in a given section of a table view.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies?.count ?? 0
    }
    
    // Asks the data source for a cell to insert in a particular location of the table view.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = filteredMovies![indexPath.row]
        
        cell.setData(movie)
        cell.setTheme()
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    // Tells the delegate that the specified row is now selected.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// MARK: - Search Bar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        name = searchText
        filteredMovies = searchText.isEmpty ? movies : movies!.filter({ (movie :Movie) -> Bool in
            return movie.title!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchMovies()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - Filters Delegate
extension SearchViewController: FiltersDelegate {
    
    func onAdultShowContent(target: FiltersViewController, state: String) {
        print("Adult Show Content \(state)")
        includeAdult = state
        searchMovies()
    }
    
    func onReleaseYearPick(target: FiltersViewController, row: Int) {
        print("Release year: \(year[row])")
        self.releaseYearRow = row
        releaseYear = year[row]
        searchMovies()
    }
    
    func onPrimaryYearPick(target: FiltersViewController, row: Int) {
        print("Primary year: \(year[row])")
        self.primaryYearRow = row
        primaryYear = year[row]
        searchMovies()
    }
    
    func onResetFilters(sender: FiltersViewController, adultShowContent: String, releaseYearRow: Int, primaryYearRow: Int) {
        self.includeAdult = adultShowContent
        self.releaseYearRow = releaseYearRow
        self.primaryYearRow = primaryYearRow
        releaseYear = year[releaseYearRow]
        primaryYear = year[primaryYearRow]
        searchMovies()
    }
}





