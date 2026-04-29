//
//  HealthKitManager.swift
//  Stepper
//
//  Created by Ram Devakumar on 4/27/26.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    let healthStore = HKHealthStore()
    
    func requestPermission(completion: @escaping (Bool) -> Void)
    {
        let stepType = HKQuantityType(.stepCount)
        healthStore.requestAuthorization(toShare: [], read: [stepType])
        {
            success, error in
            completion(success)
        }
    }
    
    func fetchTodaySteps(completion: @escaping (Double) -> Void) {
        let stepType = HKQuantityType(.stepCount)
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            let steps = result?.sumQuantity()?.doubleValue(for: .count()) ?? 0
            completion(steps)
        }
        
        healthStore.execute(query)
    }
}
