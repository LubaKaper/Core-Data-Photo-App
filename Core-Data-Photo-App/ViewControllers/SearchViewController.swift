//
//  ViewController.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var images = [Hit]() {
           didSet {
               DispatchQueue.main.async {
                   self.collectionView.reloadData()
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages(searchQuary: "")
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    private func fetchImages(searchQuary: String) {
        ImageAPIClient.getAllImageInfo(for: searchQuary, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not fetch images with error \(appError)")
            case .success(let images):
                DispatchQueue.main.async {
                    self?.images = images.hits
                }
                
            }
        })
    }


}
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("could not downcast to imageCell")
        }
        let image = images[indexPath.row]
        cell.configureCollectionViewCell(for: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard!.instantiateViewController(identifier: "DetailVC") as DetailViewController
        let image = images[indexPath.row]
        detailVC.imageInfo = image
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    // FOR SIZE: IN COLLECTIONVIEW, GO TO SIZE INSPECTOR. CHANGE ESTIMATED SIZE TO NONE
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing:CGFloat = 5 // space between items
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        let numberOfItems: CGFloat = 1 // 3 items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth:CGFloat = (maxWidth - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
    }
    // by defayult this is 10
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.text else {
            print("missing search text")
            return
        }
      fetchImages(searchQuary: search)
    }
}
