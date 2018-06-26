//
//  ResultadosViewController.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/11/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

class ResultadosViewController: UITableViewController {

    var bonoId: Int!

    @IBOutlet weak var freqCupon: UILabel!
    @IBOutlet weak var diasCap: UILabel!
    @IBOutlet weak var periodosxAño: UILabel!
    @IBOutlet weak var totalPeriodos: UILabel!
    @IBOutlet weak var tea: UILabel!
    @IBOutlet weak var tes: UILabel!
    @IBOutlet weak var cok: UILabel!
    @IBOutlet weak var ciEmisor: UILabel!
    @IBOutlet weak var ciBonista: UILabel!
    @IBOutlet weak var precioActual: UILabel!
    @IBOutlet weak var utilidad: UILabel!
    @IBOutlet weak var duracion: UILabel!
    @IBOutlet weak var convexidad: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var duracionModificada: UILabel!
    @IBOutlet weak var tceaEmisor: UILabel!
    @IBOutlet weak var tceaEmisorEscudo: UILabel!
    @IBOutlet weak var treaBonista: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let bono = User.sharedInstance.bonos[bonoId]
        
        freqCupon.text = String(bono.rs.freqCupon)
        diasCap.text = String(bono.rs.diasCap)
        periodosxAño.text = String(bono.rs.nroPeriodosxAño)
        totalPeriodos.text = String(bono.rs.nroPeriodosTotal)
        tea.text = String(format: "%.4f", bono.rs.tea*100) + " %"
        tes.text = String(format: "%.3f", bono.rs.tes*100) + " %"
        cok.text = String(format: "%.3f", bono.rs.cok*100) + " %"
        ciEmisor.text = String(format: "%.2f", bono.rs.costIniEmisor)
        ciBonista.text = String(format: "%.2f", bono.rs.costIniBonista)
        precioActual.text = String(format: "%.2f", bono.rs.precioActual)
        utilidad.text = String(format: "%.2f", bono.rs.utilidad)
        duracion.text = String(format: "%.2f", bono.rs.duracion)
        convexidad.text = String(format: "%.2f", bono.rs.convexidad)
        total.text = String(format: "%.2f", bono.rs.total)
        duracionModificada.text = String(format: "%.2f", bono.rs.duracionModificada)
        tceaEmisor.text = String(format: "%.5f", bono.rs.tceaEmisor*100) + " %"
        tceaEmisorEscudo.text = String(format: "%.5f", bono.rs.tceaEmisorEscudo*100) + " %"
        treaBonista.text = String(format: "%.5f", bono.rs.treaBonista*100) + " %"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetalles",
            let destination = segue.destination as? DetalleViewController{
            destination.bonoId = self.bonoId
        }
    }
}
