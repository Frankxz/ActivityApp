//
//  StorageManager.swift
//  PursuApp
//
//  Created by Robert Miller on 05.02.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    private let userDefaults = UserDefaults.standard
    private let activityKey = "activity"
    
    private init() { }
    
    func save(activity: Activity) {
        var toDoList = fetchFavoriteActivities()
        toDoList.append(activity)
        guard let data = try? JSONEncoder().encode(toDoList) else { return }
        userDefaults.set(data, forKey: activityKey)
    }
    
    func fetchFavoriteActivities() -> [Activity] {
        guard let data = userDefaults.object(forKey: activityKey) as? Data else {
            return []
        }
        guard let favoriteActivities = try? JSONDecoder().decode([Activity].self, from: data) else { return [] }
    
        return favoriteActivities
    }
    
    func deleteActivity(at index: Int) {
        var favoriteActivities = fetchFavoriteActivities()
        favoriteActivities.remove(at: index)
        
        guard let data = try? JSONEncoder().encode(favoriteActivities) else { return }
        userDefaults.set(data, forKey: activityKey)
    }
    
}
