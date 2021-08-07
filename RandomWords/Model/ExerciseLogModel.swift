//
//  ExerciseLogModel.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 8/4/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import Foundation
struct ExerciseLogModel {
    var id: Int
    var date: String
    var finishedTimes: Int
    var exercise: Exercise
    
    init() {
        self.id = 0
        self.date = ""
        self.finishedTimes = 0
        self.exercise = Exercise()
    }
    
    init(id: Int, date: String, finishedTimes: Int, exercise: Exercise) {
        self.id = id
        self.date = date
        self.finishedTimes = finishedTimes
        self.exercise = exercise
    }
    
    static func showObject() -> [ExerciseLogModel] {
        var results = [ExerciseLogModel]()
        let items = ExerciseLog.showObject()
        for i in items {
            var item = ExerciseLogModel()
            item.id = Int(i.id)
            item.date = i.date ?? ""
            item.finishedTimes = Int(i.finishedTimes)
            item.exercise = i.exercise ?? Exercise()
            results.append(item)
        }
        return results
    }
    static func findExercise(exercise: ExerciseModel) -> [ExerciseLogModel] {
        var results = [ExerciseLogModel]()
        let exerciseNeedFind = Exercise.fetchExerciseWithName(name: exercise.name)
        let items = ExerciseLog.fetchObjectWithExerciseId(exercise: exerciseNeedFind[0] )
        for i in items {
            var item = ExerciseLogModel()
            item.date = i.date ?? ""
            item.finishedTimes = Int(i.finishedTimes)
            item.id = Int(i.id)
            item.exercise = i.exercise ?? Exercise()
            results.append(item)
        }
        return results
    }
}
