//
//  FavoritesViewController.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    public var favorites = [Favorite]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .cyan
        tableView.dataSource = self
        tableView.delegate = self
        fetchFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchFavorites()
    }
    
    private func fetchFavorites() {
        favorites = CoreDataManager.shared.fetchFavorites()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
    }
    
   
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not downcast to FavoriteCell")
        }
        let favorite = favorites[indexPath.row]
        cell.configureCell(for: favorite)
        return cell
    }
    
    
}
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 
    }
}
