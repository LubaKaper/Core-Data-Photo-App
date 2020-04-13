//
//  DetailViewController.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit
import Kingfisher

protocol SaveFavoriteDelegate: AnyObject {
    func didSaveFavorite(_ detailVC: DetailViewController, favorite: Favorite)
}

class DetailViewController: UIViewController {
    
    let user = User()
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    
    @IBOutlet weak var heartButton: UIBarButtonItem!
    
    weak var delegate: SaveFavoriteDelegate?
    
    var imageInfo: Hit?
    var favorite: Favorite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        updateUI()
    }
    
    func updateUI() {
        
        if  let image = imageInfo {
        if let userName = image.user{
            userLabel.text = "user: \(userName)"
        } else {
            userLabel.text = "user: nothing"

        }
        
        tagsLabel.text = image.tags
        likesLabel.text = "likes: \(image.likes?.description ?? "")"
        favoritesLabel.text = "favorited by \(image.favorites?.description ?? "0") users"
        
        detailImageView.kf.setImage(with: URL(string: image.largeImageURL ?? ""))
            
        } else if let image = favorite {
            heartButton.image = UIImage(systemName: "heart.fill")
            if let userName = image.userName{
                userLabel.text = "user: \(userName)"
            } else {
                userLabel.text = "user: nothing"

            }
           // tagsLabel.text = image.tags
            likesLabel.text = "likes: \(image.likes.description )"
            favoritesLabel.text = "favorited by \(image.favoritedBy.description ) users"
            
            detailImageView.kf.setImage(with: URL(string: image.image ?? ""))
        } else {
            fatalError("could not segueue")
        }
    }

    

    @IBAction func heartButtonPressed(_ sender: UIBarButtonItem) {
        heartButton.image = UIImage(systemName: "heart.fill")
        guard let image = imageInfo else {
            fatalError("check prepare for segue")
        }
        guard let name = image.user, let tag = image.tags, let likes = image.likes, let faviritedBy = image.favorites, let image1 = image.largeImageURL else {
            return
        }
       // let tags = image.tags,
        let favorite = CoreDataManager.shared.saveFavorite( image: image1, imageByUser: name, likes: likes, favoritedBy: faviritedBy)//, tags: tags)
        delegate?.didSaveFavorite(self, favorite: favorite)
    }
    

}
