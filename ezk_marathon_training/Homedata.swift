//
//  Homedata.swift
//  ezk_marathon_training
//
//  Created by Kazuki Kanamaru on 2017/10/07.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import Foundation
import Realm

// Define your models like regular Swift classes
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var lv = 0
    @objc dynamic var coin = 0
}
class Status: Object {
    @objc dynamic var hp = 0
    @objc dynamic var atk = 0
    @objc dynamic var dfe = 0
}
class distance: Object {
    @objc dynamic var distance = 0
}

// Use them like regular Swift objects
let person = Person()
person.name = ""
person.lv = 0
person.coin = 0

// Get the default Realm
let realm = try! Realm()


// Persist your data easily
try! realm.write {
    realm.add(person)
}

// Query and update from any thread
DispatchQueue(label: "background").async {
    autoreleasepool {
        let realm = try! Realm()
        let person = realm.objects(Person.self).filter("age == 1").first
        try! realm.write {
            person!.age = 3
        }
    }
}
