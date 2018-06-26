//
//  DetalleViewController.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/16/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {

    var bonoId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditar",
            let destination = segue.destination as? EditViewController{
            destination.bonoId = bonoId
            destination.pgStage = User.sharedInstance.bonos[bonoId].plazoGraciaList
            destination.ifStage = User.sharedInstance.bonos[bonoId].inflacionAnualList
        }
    }
}
