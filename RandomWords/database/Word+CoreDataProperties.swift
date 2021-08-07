//
//  Word+CoreDataProperties.swift
//  
//
//  Created by Lê Hoàng Sinh on 7/27/20.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var eng: String?
    @NSManaged public var vn: String?
    @NSManaged public var img: String?
    @NSManaged public var song: Song?

    static func insertObject2(word: WordModel) -> Word {
        let new = NSEntityDescription.insertNewObject(forEntityName: "Word", into: AppDelegate.managedObjectContext!) as! Word
        new.eng = word.eng
        new.vn = word.vn
        new.img = word.img
        new.song = word.song
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            print("insert failed")
        }
        return new
    }
    
//    static func insertObject(eng: String,vn: String,img: String) -> Word{
//        let new = NSEntityDescription.insertNewObject(forEntityName: "Word", into: AppDelegate.managedObjectContext!) as! Word
//        new.eng = eng
//        new.vn = vn
//        new.img = img
//        do {
//            try AppDelegate.managedObjectContext?.save()
//        } catch  {
//            print("insert failed")
//        }
//        return new
//    }
    
    static func showObject() -> [Word] {
        var result = [Word]()
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchRequest()) as! [Word]
        } catch  {
            print("show failed")
        }
        return result
    }
    static func deleteObject(){
        let data = Word.showObject()
        for i in data{
            AppDelegate.managedObjectContext?.delete(i)
        }
        
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            print("error")
        }
    }
    
    static func fetchObjectWithSongName(key:Song) -> [Word]{
        var result = [Word]()
        let fetchData:NSFetchRequest = Word.fetchRequest()
        let predicate = NSPredicate(format: "song == %@", key)
        fetchData.predicate = predicate
        
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchData) as! [Word]
        } catch  {
            print("error")
        }
        return result
    }
}
