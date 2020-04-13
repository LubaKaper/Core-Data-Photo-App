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
    
    var isEditingTableView = false {
        didSet { // property observer
            // toggle editing mode of table view
            tableView.isEditing = isEditingTableView
            
            // toggle bar button item's title between "Edit" and "Done"
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle()
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
        cell.backgroundColor = #colorLiteral(red: 0.8741410375, green: 0.7467750311, blue: 0.4927862883, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard!.instantiateViewController(identifier: "DetailVC") as DetailViewController
            let image = favorites[indexPath.row]
           detailVC.favorite = image
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    
    
}
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 
    }
}
