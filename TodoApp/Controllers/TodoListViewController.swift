//
//  ViewController.swift
//  TodoApp
//
//  Created by Barry on 4/19/20.
//  Copyright © 2020 Barry. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]();
    
    let defaults = UserDefaults.standard;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item();
        newItem.title = "Mike";
        itemArray.append(newItem);
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items;
        }
    }
    
    // MARK: - TableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath);
        
        let item = itemArray[indexPath.row];
        
        cell.textLabel?.text = item.title;
        
        cell.accessoryType = item.done ? .checkmark : .none;
        
        return cell;
    }
    
    // MARK: - Table Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done;
        
        tableView.reloadData();
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    // MARK: - Add new Item
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField();
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert);
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let title = textField.text{
                
                let newItem = Item();
                newItem.title = title;
                
                self.itemArray.append(newItem);
                
                self.defaults.set(self.itemArray, forKey: "TodoListArray");
                
                self.tableView.reloadData();
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item";
            textField = alertTextField;
        }
        
        alert.addAction(action);
        
        present(alert, animated: true, completion: nil);
    }
}

