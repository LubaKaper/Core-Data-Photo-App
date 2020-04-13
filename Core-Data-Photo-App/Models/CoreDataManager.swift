//
//  CoreDataManager.swift
//  Core-Data-Photo-App
//
//  Created by Liubov Kaper  on 4/10/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    
    private var favorites = [Favorite]()
    
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func saveFavorite( image: String, imageByUser: String, likes: Int, favoritedBy: Int ) -> Favorite {
        let favorite = Favorite(entity: Favorite.entity(), insertInto: context)
        favorite.image = image
        favorite.userName = imageByUser
        favorite.likes = Int16(likes)
       // favorite.tag = tags
        
       // favorite.newRelationship = user
        
        do {
            try context.save()
        } catch {
            print("error saving favorite: \(error)")
        }
        return favorite
        
    }
    
    public func fetchFavorites() -> [Favorite] {
        do {
            favorites = try context.fetch(Favorite.fetchRequest())
        } catch {
           print("error fetching favorites: \(error)")
        }
        return favorites
    }
    
}
// trsting
