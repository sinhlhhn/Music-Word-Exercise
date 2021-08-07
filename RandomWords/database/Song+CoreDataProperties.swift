//
//  Song+CoreDataProperties.swift
//  
//
//  Created by Lê Hoàng Sinh on 7/23/20.
//
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var name: String?
    @NSManaged public var word: NSSet?

    static func insertObject(songModel: SongModel) -> Song {
        let new = NSEntityDescription.insertNewObject(forEntityName: "Song", into: AppDelegate.managedObjectContext!) as! Song
        new.name = songModel.name
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            print("Insert failed")
        }
        return new
    }
    
    static func showObject() -> [Song] {
        var result = [Song]()
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchRequest()) as! [Song]
        } catch  {
            print("Show failed")
        }
        return result
    }
    static func deleteObject(){
        let data = Song.showObject()
        for i in data{
            AppDelegate.managedObjectContext?.delete(i)
        }
        
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            print("error")
        }
    }
    static func fetchSongWithSongName(key:String)->[Song]{
        var result = [Song]()
        let fetchData:NSFetchRequest = Song.fetchRequest()
        let predicate = NSPredicate(format: "name == %@ ", key)
        fetchData.predicate = predicate
        
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchData) as! [Song]
        } catch  {
            print("error")
        }
        return result
    }
    static func isExisting(name: String) -> Bool {
        let items = Song.showObject()
        for i in items {
            if i.name == name {
                return true
            }
        }
        return false
    }
}

// MARK: Generated accessors for word
extension Song {

    @objc(addWordObject:)
    @NSManaged public func addToWord(_ value: Word)

    @objc(removeWordObject:)
    @NSManaged public func removeFromWord(_ value: Word)

    @objc(addWord:)
    @NSManaged public func addToWord(_ values: NSSet)

    @objc(removeWord:)
    @NSManaged public func removeFromWord(_ values: NSSet)

}
