//
//  EmployeeListViewController.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/3/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeTableView: UITableView!
    var employeeList: [Employee]! = [] {
        didSet {
            
            employeeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDataStack.CreateCoreStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        if employeeList.count > 0{
            employeeList.removeAll()
        }
        employeeList = AppDataStack.fetchAllEmployee()
    }
    
    @IBAction func AddEmployee(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addEmpSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        if segue.identifier == "empDetailsSegue" {
            let emp = employeeList[indexPath.row]
            
            let viewC = segue.destination as! EmpDetailViewController
            viewC.employee = emp
        }
    }
    
}

extension EmployeeListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "empCell")!
        
        cell.textLabel?.text = employeeList[indexPath.row].firstName
        cell.detailTextLabel?.text = employeeList[indexPath.row].department?.name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "empDetailsSegue", sender: indexPath)
    }

}
