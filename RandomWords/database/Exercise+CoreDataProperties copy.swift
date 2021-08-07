//
//  Exercise+CoreDataProperties.swift
//  
//
//  Created by Lê Hoàng Sinh on 8/4/20.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var requiredTimes: Int64
    @NSManaged public var link: String?
    @NSManaged public var name: String?
    @NSManaged public var exerciseLog: NSSet?

    static func insertObject(exerciseModel:ExerciseModel) -> Exercise {
           let new = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: AppDelegate.managedObjectContext!) as! Exercise
           new.name = exerciseModel.name
           new.link = exerciseModel.link
           new.requiredTimes = Int64(exerciseModel.requiredTimes)
           
           
           do {
               try AppDelegate.managedObjectContext?.save()
           } catch  {
               print("insert failed")
           }
           return new
       }
       
       static func showObject() -> [Exercise] {
           var result = [Exercise]()
           do {
               result = try AppDelegate.managedObjectContext?.fetch(fetchRequest()) as! [Exercise]
           } catch  {
               print("show failed")
           }
           return result
       }
       
       static func deleteObject() {
           let exercise = Exercise.showObject()
           for i in exercise{
               AppDelegate.managedObjectContext?.delete(i)
           }
           do {
               try AppDelegate.managedObjectContext?.save()
           } catch  {
               print("delete failed")
           }
       }
       
       static func updateTimes(exercise: Exercise ,requiredTimes: Int) -> Exercise{
           exercise.requiredTimes = Int64(requiredTimes)
           
           do {
               try AppDelegate.managedObjectContext?.save()
           } catch  {
               print("error")
           }
           return exercise
       }
       
       static func fetchExerciseWithName(name: String) -> [Exercise] {
               var result = [Exercise]()
               let fetchData:NSFetchRequest = Exercise.fetchRequest()
               let predicate = NSPredicate(format: "name == %@ ", name)
               fetchData.predicate = predicate
               
               do {
                   result = try AppDelegate.managedObjectContext?.fetch(fetchData) as! [Exercise]
               } catch  {
                   print("error")
               }
               return result
           }
    
    static func getID(){
        let fetch = NSFetchRequest<NSManagedObjectID>(entityName: "Exercise")
        fetch.resultType = .managedObjectIDResultType
        do {
            let item = try AppDelegate.managedObjectContext?.fetch(fetch) as! [NSManagedObjectID]
            for i in item{
                print(i)
            }
        } catch  {
            print("error")
        }
        
    }

}
// MARK: Generated accessors for exerciseLog
extension Exercise {

    @objc(addExerciseLogObject:)
    @NSManaged public func addToExerciseLog(_ value: ExerciseLog)

    @objc(removeExerciseLogObject:)
    @NSManaged public func removeFromExerciseLog(_ value: ExerciseLog)

    @objc(addExerciseLog:)
    @NSManaged public func addToExerciseLog(_ values: NSSet)

    @objc(removeExerciseLog:)
    @NSManaged public func removeFromExerciseLog(_ values: NSSet)

}
