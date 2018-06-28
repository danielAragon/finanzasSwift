//
//  BonosViewController.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/11/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class BonosCell: UITableViewCell{
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var PeriodoLabel: UILabel!
}

class BonosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return User.sharedInstance.bonos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BonosCell", for: indexPath) as! BonosCell
        cell.TitleLabel.text = "Bono \(indexPath.row + 1)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yy"
        
        let beginDate: String = dateFormatter.string(from: User.sharedInstance.bonos[indexPath.row].fechasList.first!)
        
        let endDate: String = dateFormatter.string(from: User.sharedInstance.bonos[indexPath.row].fechasList.last!)
        cell.PeriodoLabel.text = "\(beginDate) - \(endDate)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultados",
            let destination = segue.destination as? ResultadosViewController,
            let index = tableView.indexPathForSelectedRow?.row{
            destination.bonoId = index
        }
    }
}
