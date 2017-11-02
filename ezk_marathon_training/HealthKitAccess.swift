//
//  HealthKitAccess.swift
//  ezk_marathon_training
//
//  Created by Kazuki Kanamaru on 2017/10/13.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import Foundation
import HealthKit

/// HealthKitから歩数を取得するサンプルプログラム
class HealthKitAccess {
    /// HealthKitストレージにアクセスする
    var storage:HKHealthStore = HKHealthStore()
    
    /**
     HealthKitへのアクセス許可を確認
     
     - returns:
     */
    init() {
        _ = checkAuthorization()
    }
    
    /**
     HealthKitへのアクセス許可確認
     
     - returns: true = 許可 / false = 不許可
     */
    func checkAuthorization() -> Bool {
        var isEnabled = true
        
        // 利用しているデバイスでHealthKitが利用可能か調べる
        if HKHealthStore.isHealthDataAvailable()
        {
            // 歩数の取得をリクエスト
            let distance: Set<HKObjectType> = [HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!]
            
            storage.requestAuthorization(toShare: nil, read: distance, completion: { (success, error) in
                isEnabled = success
            })
            
        } else {
            isEnabled = false
        }
        
        return isEnabled
    }
    
    /**
     指定日１日分の歩数をHealthKitから取得する
     
     - parameter findDate:   検索対象日
     - parameter completion: データ取得後に呼び出されるデリゲート関数
     */
    func recentDistance(findDate: Date, completion: @escaping ((_ distance: Double, _ error: Error?) -> Void) ) {
        let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)
        
        let calendar = Calendar.current
        let date = Date()
        let startDate = calendar.date(byAdding: .day, value: -7, to: date)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: date, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            guard let samples = results as? [HKQuantitySample] else {
                fatalError("An error occured fetching the user's tracked food. In your app, try to handle this error gracefully. The error was: \(String(describing: error?.localizedDescription))");
            }

            var distance: Double = 0
            distance = samples.reduce(distance, { $0 + $1.quantity.doubleValue(for: HKUnit.meter())})
            
            completion(distance,error)
        }
        

        storage.execute(query)
        
    }
    

}

