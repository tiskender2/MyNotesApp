//
//  ListNotesViewController.swift
//  MyNotesApp
//
//  Created by tolga iskender on 17.08.2018.
//  Copyright © 2018 tolga iskender. All rights reserved.
//

import UIKit
import CoreData
class ListNotesViewController: UIViewController {

   
    @IBOutlet weak var tableView: UITableView!
    var listNotes = [MyNotes]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        loadNotes()
        
    }

    func loadNotes(){
        
        let fetchRequest:NSFetchRequest<MyNotes> =  MyNotes.fetchRequest()
        do
        {
        listNotes = try context.fetch(fetchRequest)
            if listNotes.count == 0{
               control()
            }else {
                
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }
        }catch {
            print("cannot read from database")
        }
    }

    
    func control()  {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Attention", message: "You don't have any Note", preferredStyle: .alert)
            let alert2 = UIAlertAction(title: "Add Note", style: .default, handler: { (alert) in
                 self.performSegue(withIdentifier: "segue", sender: nil)
            })
            alert.addAction(alert2)
            self.present(alert, animated: true, completion: nil)
            
        }
      
    }
    @IBAction func addNote(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    @objc func deleteNote(_ sender: UIButton) {
        context.delete(listNotes[sender.tag])
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        loadNotes()
    }
    @objc func editNote(_ sender: UIButton) {
        performSegue(withIdentifier: "segue", sender: listNotes[sender.tag])
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let edit = segue.destination as? ViewController {
                if let mynote = sender as? MyNotes  {
                    edit.editNotes = mynote
                }
            }
        }
    }
    
}
extension ListNotesViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotes.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! listNoteTableViewCell
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteNote(_:)), for: .touchUpInside)
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editNote(_:)), for: .touchUpInside)
        cell.setNotes(note: listNotes[indexPath.row])
        
        return cell
    }
    
    
}
