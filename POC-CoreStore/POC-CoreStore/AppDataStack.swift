//
//  AppDataStack.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/3/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import CoreStore

class AppDataStack {
    
    static let dataStack = DataStack(xcodeModelName: "POC-CoreStore") // keep reference to the stack
    
    static func CreateCoreStore() {
        
        let sqLiteStore = SQLiteStore(fileName: "POC-CoreStore.sqlite")
        print(sqLiteStore.fileURL)
        
        do {
            try AppDataStack.dataStack.addStorageAndWait(sqLiteStore)
        }
        catch { // ...
            print("CreateCoreStore() error")
        }
        
    }

    
    static func createEmployee(person: [String:Any]) {
        
        AppDataStack.dataStack.perform(asynchronous: { (transaction) -> Void in
            let employee = transaction.create(Into<Employee>())
            employee.identity = person["id"] as? String
            employee.firstName = person["fName"] as? String
            employee.lastName = person["lName"] as? String
            employee.gender = Int16((person["gender"] as? Int16)!)
            employee.hireDate = NSDate()
            employee.birthDate = person["bod"] as? NSDate
            employee.empNo = Int16((person["empNumber"] as? Int16)!)

            let department = transaction.create(Into<Department>())
            department.name = "Mobile"
            department.number = 1
            employee.department = department
            
            let salary = transaction.create(Into<Salary>())
            salary.salary = Int16.max
            employee.salary = salary
            
        }) { (s) in
            print(s)
        }
        
    }
    
    static func fetchAllEmployee() -> [Employee] {
        if let people: [Employee] = AppDataStack.dataStack.fetchAll(From(Employee.self)) {
            return people
        }
        return []
    }
    
    
    
    
}
