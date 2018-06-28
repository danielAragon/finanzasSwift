//
//  DetalleViewController.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/16/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit
import SpreadsheetView

class HeaderCell: Cell{
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
        label.backgroundColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class PeriodCell: Cell{
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
        label.backgroundColor = UIColor(hex: "7D9232")
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
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
        label.numberOfLines = 1
        
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
        
        spreadSheet.layer.cornerRadius = 10
        spreadSheet.layer.shadowColor = UIColor.init(hex: "25265E").cgColor
        spreadSheet.layer.shadowOpacity = 0.1
        spreadSheet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        spreadSheet.layer.shadowRadius = 4
        
        super.viewDidLoad()
        self.spreadSheet.dataSource = self
        self.spreadSheet.delegate = self
        
        spreadSheet.register(DetalleCell.self, forCellWithReuseIdentifier: String(describing: DetalleCell.self))
        spreadSheet.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadSheet.register(PeriodCell.self, forCellWithReuseIdentifier: String(describing: PeriodCell.self))

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
        if column == 0{
            return 40
        }else{
            return 80
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        
        if indexPath.row == 0 {
            let header = spreadSheet.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell

            switch indexPath.column {
            case 0:
                header.title = "Nro"
            case 1:
                header.title = "Fecha\nProgramada"
            case 2:
                header.title = "Inflacion\nAnual"
            case 3:
                header.title = "Inflacion\nSemestral"
            case 4:
                header.title = "Plazo de\nGracia"
            case 5:
                header.title = "Bono"
            case 6:
                header.title = "Bono\nIndexado"
            case 7:
                header.title = "Cupon"
            case 8:
                header.title = "Cuota"
            case 9:
                header.title = "Amortizacion"
            case 10:
                header.title = "Prima"
            case 11:
                header.title = "Escudo"
            case 12:
                header.title = "Flujo\nEmisor"
            case 13:
                header.title = "Flujo Emisor\nc/Escudo"
            case 14:
                header.title = "Flujo\nBonista"
            case 15:
                header.title = "Flujo\nActivo"
            case 16:
                header.title = "Flujo activo\nX plazo"
            case 17:
                header.title = "Convexidad"
            default:
                header.title = " "
            }
            return header
        }
        
        let cell = spreadSheet.dequeueReusableCell(withReuseIdentifier: String(describing: DetalleCell.self), for: indexPath) as! DetalleCell
        
        switch indexPath.column {
        case 0:
            let header = spreadSheet.dequeueReusableCell(withReuseIdentifier: String(describing: PeriodCell.self), for: indexPath) as! PeriodCell
            header.title = String(bono.periodosList[indexPath.row - 1])
            return header
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
