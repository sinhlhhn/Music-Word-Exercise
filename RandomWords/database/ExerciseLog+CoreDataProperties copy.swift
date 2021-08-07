//
//  ExerciseLog+CoreDataProperties.swift
//  
//
//  Created by Lê Hoàng Sinh on 8/4/20.
//
//

import Foundation
import CoreData


extension ExerciseLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseLog> {
        return NSFetchRequest<ExerciseLog>(entityName: "ExerciseLog")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var finishedTimes: Int64
    @NSManaged public var date: String?
    @NSManaged public var exercise: Exercise?

    static  func insertObject(exerciseLog: ExerciseLogModel)-> ExerciseLog {
        let new = NSEntityDescription.insertNewObject(forEntityName: "ExerciseLog", into: AppDelegate.managedObjectContext!) as! ExerciseLog
        new.id = Int64(exerciseLog.id)
        new.finishedTimes = Int64(exerciseLog.finishedTimes)
        new.date = exerciseLog.date
        new.exercise = exerciseLog.exercise
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            print("insert failed")
        }
        return new
    }
    
    static func showObject() -> [ExerciseLog] {
        var result = [ExerciseLog]()
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchRequest()) as! [ExerciseLog]
        } catch  {
            print("show failed")
        }
        return result
    }
    static func deleteObject() {
        let exercise = ExerciseLog.showObject()
        for i in exercise{
            AppDelegate.managedObjectContext?.delete(i)
        }
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            print("delete failed")
        }
    }
    static func updateObject(exerciseLog: ExerciseLog, finishedTimes: Int) -> ExerciseLog {
        exerciseLog.finishedTimes += Int64(finishedTimes)
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch  {
            print("update exerciseLog failed")
        }
        return exerciseLog
    }

    static func fetchObjectWithDate(exercise: Exercise,date:String) -> [ExerciseLog] {
        var result = [ExerciseLog]()
        let fetchData:NSFetchRequest = ExerciseLog.fetchRequest()
        let predicate = NSPredicate(format: "exercise == %@ ", exercise)
        let predicate2 = NSPredicate(format: "date == %@", date)
        var predicates = [NSPredicate]()
        predicates.append(predicate)
        predicates.append(predicate2)
        let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: predicates)
        fetchData.predicate = compoundPredicates
        
        let sort = [NSSortDescriptor(key: "id", ascending: false)]
        fetchData.sortDescriptors = sort
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchData) as! [ExerciseLog]
        } catch  {
            print("fetch failed")
        }
        
        return result
    }
    static func fetchObjectWithExerciseId(exercise: Exercise) -> [ExerciseLog] {
        var result = [ExerciseLog]()
        let fetchData:NSFetchRequest = ExerciseLog.fetchRequest()
        let predicate = NSPredicate(format: "exercise == %@ ", exercise)
        fetchData.predicate = predicate
        let sort = [NSSortDescriptor(key: "id", ascending: true)]
        fetchData.sortDescriptors = sort
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchData) as! [ExerciseLog]
        } catch  {
            print("fetch failed")
        }
        
        return result
    }
    static func fetchObjectForCharts(exercise: Exercise) -> [ExerciseLog] {
        var result = [ExerciseLog]()
        let fetchData:NSFetchRequest = ExerciseLog.fetchRequest()
        let predicate = NSPredicate(format: "exercise == %@ ", exercise)
        fetchData.predicate = predicate
        let sort = [NSSortDescriptor(key: "id", ascending: true)]
        fetchData.sortDescriptors = sort
        do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchData) as! [ExerciseLog]
        } catch  {
            print("fetch failed")
        }
        if result.count > 6 {
            fetchData.fetchOffset = result.count - 7

        }
                do {
            result = try AppDelegate.managedObjectContext?.fetch(fetchData) as! [ExerciseLog]
        } catch  {
            print("fetch failed")
        }
        return result
    }
    static func getID(){
        var ex = [NSManagedObjectID]()
        let fetch = NSFetchRequest<NSManagedObjectID>(entityName: "Exercise")
        fetch.resultType = .managedObjectIDResultType
        do {
            ex = try AppDelegate.managedObjectContext?.fetch(fetch) as! [NSManagedObjectID]
//            print(item[0])
        } catch  {
            print("error")
        }
        let predicate = NSPredicate(format: "exercise == %@", ex[0])
        let fetchResult:NSFetchRequest = ExerciseLog.fetchRequest()
        fetchResult.predicate = predicate
        do {
            let result = try AppDelegate.managedObjectContext?.fetch(fetchResult) as! [ExerciseLog]
            for i in result{
                print(i)
            }
        } catch  {
            print("error")
        }
    }
    static func sumFinishedTimes() -> Int{
        var result = 0
        let sum = NSExpressionDescription()
        sum.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "finishedTimes")])
        sum.name = "sum"
        sum.expressionResultType = .integer64AttributeType
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ExerciseLog")
        fetch.propertiesToFetch = [sum]
        fetch.resultType = .dictionaryResultType
        
        do {
            let items = try AppDelegate.managedObjectContext?.fetch(fetch)
            let itemMap = items![0] as! [String:Int]
            print(itemMap.keys)
            print(itemMap.values)
            result = itemMap["sum"]!
        } catch  {
            print("sum failed")
        }
        return result
    }


    
}
