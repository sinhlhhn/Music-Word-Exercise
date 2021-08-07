//
//  ExerciseModel.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 7/27/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
struct ExerciseModel {
    var name:String
    var link:String
    var requiredTimes: Int
    
    init (){
        name = ""
        link = ""
        requiredTimes = 0
    }
    init (name: String, link: String, requiredTimes: Int){
        self.name = name
        self.link = link
        self.requiredTimes = requiredTimes
    }
    static func showObject() -> [ExerciseModel] {
        var results = [ExerciseModel]()
        let items = Exercise.showObject()
        for i in items {
            var item = ExerciseModel()
            item.name = i.name ?? ""
            item.link = i.link ?? ""
            item.requiredTimes = Int(i.requiredTimes)
            results.append(item)
        }
        return results
    }
    static func updateObject(exercise: ExerciseModel, requiredTimes: Int) -> ExerciseModel{
        let items = Exercise.fetchExerciseWithName(name: exercise.name)
        let item = Exercise.updateTimes(exercise: items[0], requiredTimes: requiredTimes)
        let result = ExerciseModel(name: item.name ?? "", link: item.link ?? "", requiredTimes: Int(item.requiredTimes))
        return result
    }
}
