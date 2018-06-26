//
//  createPlanTableViewController.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/10/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class DatosViewController: UITableViewController {

    var calculator: Bono!
    
    @IBOutlet weak var pvTextField: UITextField!
    @IBOutlet weak var cuotaInicialTextField: UITextField!
    @IBOutlet weak var nroAñosTextField: UITextField!
    @IBOutlet weak var frecuenciaTextField: UITextField!
    @IBOutlet weak var nroDiasxAñoTextField: UITextField!
    @IBOutlet weak var costesNotarialesTextField: UITextField!
    @IBOutlet weak var costesRegistralesTextField: UITextField!
    @IBOutlet weak var tasacionTextField: UITextField!
    @IBOutlet weak var comisionEstudioTextField: UITextField!
    @IBOutlet weak var comisionActivacionTextField: UITextField!
    @IBOutlet weak var comisionPeriodicaTextField: UITextField!
    @IBOutlet weak var portesTextField: UITextField!
    @IBOutlet weak var gastosAdminTextField: UITextField!
    @IBOutlet weak var desgravamenTextField: UITextField!
    @IBOutlet weak var riesgoTextField: UITextField!
    @IBOutlet weak var descuentoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation b+ar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func Save(_ sender: Any) {
//        let pv = Double(pvTextField.text!)!
//        let ci = Double(cuotaInicialTextField.text!)!
//        let na = Int(nroAñosTextField.text!)!
//        let fq = Int(frecuenciaTextField.text!)!
//        let da = Int(nroDiasxAñoTextField.text!)!
//        let cn = Double(costesNotarialesTextField.text!)!
//        let cr = Double(costesRegistralesTextField.text!)!
//        let ts = Double(tasacionTextField.text!)!
//        let ce = Double(comisionEstudioTextField.text!)!
//        let ca = Double(comisionActivacionTextField.text!)!
//        let cp = Double(comisionPeriodicaTextField.text!)!
//        let pt = Double(portesTextField.text!)!
//        let ga = Double(gastosAdminTextField.text!)!
//        let sd = Double(desgravamenTextField.text!)!
//        let sr = Double(riesgoTextField.text!)!
//        let dc = Double(descuentoTextField.text!)!
        
//        calculator = Bono(pv: pv, ci: ci, na: na, fq: fq, da: da, cn: cn, cr: cr, ts: ts, ce: ce, ca: ca, cp: cp, pt: pt, ga: ga, sd: sd, sr: sr, dc: dc)
//        calculator.Aleman()
    }
}
