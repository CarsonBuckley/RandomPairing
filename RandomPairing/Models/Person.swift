//
//  Randomizer.swift
//  RandomPairing
//
//  Created by Carson Buckley on 4/19/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation
import CloudKit

class Person {
    
    let name: String
    let ckRecordID: CKRecord.ID
    
    init(name: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[PersonConstants.NameKey] as? String else { return nil }
        self.init(name: name, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init(person: Person) {
        self.init(recordType: PersonConstants.RecordType, recordID: person.ckRecordID)
        self.setValue(person.name, forKey: PersonConstants.NameKey)
    }
}

struct PersonConstants {
    static let NameKey = "Name"
    static let RecordType = "Person"
}


