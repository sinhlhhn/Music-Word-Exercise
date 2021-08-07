//
//  newViewController.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 8/6/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit
import CoreData
class newViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let keypath = NSExpression(forKeyPath: "date")
        let expression = NSExpression(forFunction: "sum:", arguments: [keypath])
        let count = NSExpressionDescription()
        count.name = "sum"
        count.expression = expression
        count.expressionResultType = .integer64AttributeType
        
        
        
        
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ExerciseLog")
        fetch.propertiesToGroupBy = ["date"]
        fetch.propertiesToFetch = [count]
        fetch.resultType = .dictionaryResultType
        var results = [Int]()
        do {
            let items = try (AppDelegate.managedObjectContext?.fetch(fetch))
            for i in 0..<items!.count{
                let item = items![i] as! [String:Int]
                print(item.keys)
                print(item.values)
                let result = item["sum"]
                results.append(result!)
            }
            for i in results{
                print(i)
            }
        } catch  {
            print("group data failed")
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
