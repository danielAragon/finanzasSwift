//
//  DetalleViewController.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/16/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit
import SpreadsheetView

class DetalleCell: Cell{
    let label = UILabel()
    
    var title = "" {
        didSet {
            label.text = title
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DetalleViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate {
    var bonoId: Int!
    var bono: Bono!
    @IBOutlet weak var spreadSheet: SpreadsheetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spreadSheet.dataSource = self
        self.spreadSheet.delegate = self
        
        spreadSheet.register(DetalleCell.self, forCellWithReuseIdentifier: String(describing: DetalleCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bono = User.sharedInstance.bonos[bonoId]
        self.spreadSheet.reloadData()
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 18
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return User.sharedInstance.bonos[bonoId].periodosList.count + 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 80
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        
        if indexPath.row == 0 {
            return nil
        }
        
        let cell = spreadSheet.dequeueReusableCell(withReuseIdentifier: String(describing: DetalleCell.self), for: indexPath) as! DetalleCell
        
        switch indexPath.column {
        case 0:
            cell.title = String(bono.periodosList[indexPath.row - 1])
        case 1:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/mm/yy"
            cell.title = "\(dateFormatter.string(from: bono.fechasList[indexPath.row - 1]))"
        case 2:
            cell.title = String(format: "%.2f", bono.inflacionAnualList[indexPath.row -  1])
        case 3:
            cell.title = String(format: "%.3f", bono.inflacionSemestralList[indexPath.row -  1])
        case 4:
            cell.title = String(bono.plazoGraciaList[indexPath.row -  1])
        case 5:
            cell.title = String(format: "%.2f", bono.bonoList[indexPath.row -  1])
        case 6:
            cell.title = String(format: "%.2f", bono.bonoIndexadoList[indexPath.row -  1])
        case 7:
            cell.title = String(format: "%.2f", bono.cuponList[indexPath.row -  1])
        case 8:
            cell.title = String(format: "%.2f", bono.cuotaList[indexPath.row -  1])
        case 9:
            cell.title = String(format: "%.2f", bono.amortList[indexPath.row -  1])
        case 10:
            cell.title = String(format: "%.2f", bono.primaList[indexPath.row -  1])
        case 11:
            cell.title = String(format: "%.2f", bono.escudoList[indexPath.row -  1])
        case 12:
            cell.title = String(format: "%.2f", bono.flujoEmisorList[indexPath.row -  1])
        case 13:
            cell.title = String(format: "%.2f", bono.flujoEmisorEscudoList[indexPath.row -  1])
        case 14:
            cell.title = String(format: "%.2f", bono.flujoBonistaList[indexPath.row -  1])
        case 15:
            cell.title = String(format: "%.2f", bono.flujoActList[indexPath.row -  1])
        case 16:
            cell.title = String(format: "%.2f", bono.flujoActxPlazoList[indexPath.row -  1])
        case 17:
            cell.title = String(format: "%.2f", bono.convexidadList[indexPath.row -  1])
        default:
            cell.title = "0"
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditar",
            let destination = segue.destination as? EditViewController{
            destination.bonoId = bonoId
            destination.pgStage = User.sharedInstance.bonos[bonoId].plazoGraciaList
            destination.ifStage = User.sharedInstance.bonos[bonoId].inflacionAnualList
        }
    }
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
}
