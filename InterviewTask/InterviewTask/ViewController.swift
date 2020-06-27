//
//  ViewController.swift
//  InterviewTask
//
//  Created by Ahammed on 26/06/20.
//  Copyright © 2020 Ahammed. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var people = [Person]()
    var searchTodolist = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        textViewName.layer.borderWidth = 2
//              textViewName.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//              textViewName.layer.masksToBounds = true
//        
        
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let people = try PersistenceServce.context.fetch(fetchRequest)
            self.people = people
            self.tableView.reloadData()
        } catch {}
        
    }
    
    @IBAction func onPlusTapped() {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            if alert.textFields?.first?.text == "" || alert.textFields?.last?.text == ""{
                 applicationController?.SHOW_POPUP_MESSAGE(on: self, withMessage: ApplicationMessage.BlankTextFeild.rawValue)
                
            }else{
                let name = alert.textFields?.first?.text
                           let age = alert.textFields?.last?.text
                           let person = Person(context: PersistenceServce.context)
                           person.name = name
                           person.age = Int64(age!) ?? 00
                           PersistenceServce.saveContext()
                           self.people.append(person)
                           self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        return cell
    }
}
extension ViewController: UISearchBarDelegate,UISearchDisplayDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            var pr : NSPredicate = NSPredicate()
            pr = NSPredicate(format: "name contains[c] '\(searchText)'")
            let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
                   fetchRequest.predicate = pr
                   do {
                        people = try PersistenceServce.context.fetch(fetchRequest)
                   } catch {
                    print("Could not get search data")
            }
            }else{
            let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
                  
                  do {
                      let people = try PersistenceServce.context.fetch(fetchRequest)
                      self.people = people
                      self.tableView.reloadData()
                  } catch {
                     print("Could not get search data")
            }
        }
         self.tableView.reloadData()
    }
}
