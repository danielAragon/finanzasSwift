//
//  EditViewController.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/16/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class EditViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    var bonoId: Int!
    var bono: Bono!
    var pgStage: [String]!
    var ifStage: [Double?]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bono = User.sharedInstance.bonos[bonoId]
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bono.periodosList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row != 0{
            let periodCell = tableView.dequeueReusableCell(withIdentifier: "PeriodViewCell", for: indexPath) as! PeriodViewCell
            periodCell.periodLabel.text =  String(bono.periodosList[indexPath.row])
            
            periodCell.pgField.text = String(bono.plazoGraciaList[indexPath.row])
            periodCell.pgField.delegate = self
            periodCell.pgField.tag = indexPath.row*10+1
            
            periodCell.ifField.text = String(bono.inflacionAnualList[indexPath.row])
            periodCell.ifField.delegate = self
            periodCell.ifField.tag = indexPath.row*10+2
            
            periodCell.cuotaLabel.text = String(format: "%.2f" ,bono.cuotaList[indexPath.row])
            return periodCell
        }else{
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewCell", for: indexPath)
            return headerCell
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.tag%10 == 1){
            pgStage[textField.tag/10] = textField.text!
        }else{
            ifStage[textField.tag/10] = Double(textField.text!)!
        }
    }

    
    @IBAction func Actualizar(_ sender: Any) {
        self.tableView.endEditing(true)
        bono.plazoGraciaList = pgStage
        bono.inflacionAnualList = ifStage as! [Double]
        bono.Aleman()
        User.sharedInstance.bonos[bonoId] =  bono
        self.tableView.reloadData()
    }
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
}
