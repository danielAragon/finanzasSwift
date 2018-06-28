//
//  Bono.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/11/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation
extension Int{
    var d: Double{
        return Double(self)
    }
}
func frecuencia(freq: String) -> Int{
    switch freq {
    case "Mensual":
        return 30
    case "Bimestral":
        return 60
    case "Trimestral":
        return 90
    case "Cuatrimestral":
        return 120
    case "Semestral":
        return 180
    default:
        return 360
    }
}
func capitalizacion(capi: String) -> Int{
    switch capi {
    case "Diaria":
        return 1
    case "Quincenal":
        return 15
    case "Mensual":
        return 30
    case "Bimestral":
        return 60
    case "Trimestral":
        return 90
    case "Cuatrimestral":
        return 120
    case "Semestral":
        return 180
    default:
        return 360
    }
}
func tasaEfectivaAnual(tTas: String, tInt: Double, dxAñ: Int, capi: Int) -> Double{
    if tTas == "Efectiva" {
        return tInt
    }else{
        return pow(1 + tInt/(Double(dxAñ)/Double(capi)), Double((dxAñ/capi) - 1))
    }
}
func costosIniciales(vCom: Double, para: String, estr:Double, estrTipo:String, colo:Double, coloTipo: String, flot:Double, flotTipo:String, cava:Double, cavaTipo:String) -> Double{
    var costo = 0.0
    switch para {
    case "Emisor":
        costo += (estrTipo == "Emisor" || estrTipo == "Ambos") ? estr : 0.00
        costo += (coloTipo == "Emisor" || coloTipo == "Ambos") ? colo : 0.00
        costo += (flotTipo == "Emisor" || flotTipo == "Ambos") ? flot : 0.00
        costo += (cavaTipo == "Emisor" || cavaTipo == "Ambos") ? cava : 0.00
        return vCom*costo
    case "Bonista":
        costo += (estrTipo == "Bonista" || estrTipo == "Ambos") ? estr : 0.00
        costo += (coloTipo == "Bonista" || coloTipo == "Ambos") ? colo : 0.00
        costo += (flotTipo == "Bonista" || flotTipo == "Ambos") ? flot : 0.00
        costo += (cavaTipo == "Bonista" || cavaTipo == "Ambos") ? cava : 0.00
        return vCom*costo
    default:
        return vCom*costo
    }
}
class Resultados {
    
    var freqCupon: Int!
    var diasCap: Int!
    var nroPeriodosxAño: Int!
    var nroPeriodosTotal: Int!
    var tea: Double!
    var tes: Double!
    var cok: Double!
    var costIniEmisor: Double!
    var costIniBonista: Double!
    
    var precioActual: Double!
    var utilidad: Double!
    
    var duracion: Double!
    var convexidad: Double!
    var total: Double!
    var duracionModificada: Double!
    
    var tceaEmisor: Double!
    var tceaEmisorEscudo: Double!
    var treaBonista: Double!
}

class Bono{
    
    var rs = Resultados()
        
    var vNominal: Double
    var prima: Double
    var impRenta: Double
    var diasXAño: Int
    
    var periodosList: [Int]
    var fechasList: [Date]
    var inflacionAnualList: [Double]
    var inflacionSemestralList: [Double]
    var plazoGraciaList: [String]
    var bonoList: [Double]
    var bonoIndexadoList: [Double]
    var cuponList: [Double]
    var cuotaList: [Double]
    var amortList: [Double]
    var primaList: [Double]
    var escudoList: [Double]
    var flujoEmisorList: [Double]
    var flujoEmisorEscudoList: [Double]
    var flujoBonistaList: [Double]
    var flujoActList: [Double]
    var flujoActxPlazoList: [Double]
    var convexidadList: [Double]

    public init(vNom:Double, vCom:Double, nrAñ:Int, freq: String, dxAñ:Int, tTas: String, capi:String, tInt:Double, tDesc:Double, impR:Double, fEmi:Date?, prim:Double, estr:Double, estrTipo:String, colo:Double, coloTipo: String, flot:Double, flotTipo:String, cava:Double, cavaTipo:String){
        
        self.vNominal = vNom
        self.prima = prim
        self.impRenta = impR
        self.diasXAño = dxAñ
        self.rs.freqCupon = frecuencia(freq: freq)
        self.rs.diasCap = capitalizacion(capi: capi)
        self.rs.nroPeriodosxAño = dxAñ / rs.freqCupon
        self.rs.nroPeriodosTotal = rs.nroPeriodosxAño * nrAñ
        self.rs.tea = tasaEfectivaAnual(tTas: tTas, tInt: tInt, dxAñ: dxAñ, capi: rs.diasCap)
        self.rs.tes = pow(1.d + rs.tea,rs.freqCupon.d/dxAñ.d)-1
        self.rs.cok = pow(1 + tDesc,rs.freqCupon.d/dxAñ.d)-1
        self.rs.costIniEmisor = costosIniciales(vCom: vCom, para: "Emisor", estr: estr, estrTipo: estrTipo, colo: colo, coloTipo: coloTipo, flot: flot, flotTipo: flotTipo, cava: cava, cavaTipo: cavaTipo)
        self.rs.costIniBonista = costosIniciales(vCom: vCom, para: "Bonista", estr: estr, estrTipo: estrTipo, colo: colo, coloTipo: coloTipo, flot: flot, flotTipo: flotTipo, cava: cava, cavaTipo: cavaTipo)
        self.periodosList = [Int](0...rs.nroPeriodosTotal)
        self.fechasList = Array(repeating: fEmi!, count: periodosList.count)
        self.inflacionAnualList = Array(repeating: 0, count: periodosList.count)
        self.inflacionSemestralList = Array(repeating: 0, count: periodosList.count)
        self.plazoGraciaList = Array(repeating: "S", count: periodosList.count)
        self.bonoList = Array(repeating: 0, count: periodosList.count)
        self.bonoIndexadoList = Array(repeating: 0, count: periodosList.count)
        self.cuponList = Array(repeating: 0, count: periodosList.count)
        self.cuotaList = Array(repeating: 0, count: periodosList.count)
        self.amortList = Array(repeating: 0, count: periodosList.count)
        self.primaList = Array(repeating: 0, count: periodosList.count)
        self.escudoList = Array(repeating: 0, count: periodosList.count)
        self.flujoEmisorList = Array(repeating: 0, count: periodosList.count)
        self.flujoEmisorEscudoList = Array(repeating: 0, count: periodosList.count)
        self.flujoBonistaList = Array(repeating: 0, count: periodosList.count)
        self.flujoActList = Array(repeating: 0, count: periodosList.count)
        self.flujoActxPlazoList = Array(repeating: 0, count: periodosList.count)
        self.convexidadList = Array(repeating: 0, count: periodosList.count)
        self.flujoEmisorList[0] = vCom - rs.costIniEmisor
        self.flujoEmisorEscudoList[0] = flujoEmisorList[0]
        self.flujoBonistaList[0] = -vCom - rs.costIniBonista
    }

    public func Aleman(){
        for n in 1...rs.nroPeriodosTotal{
            if n != 0 {
                fechasList[n] = fechasList[n] + TimeInterval(rs.freqCupon*n*60*60*24)
            }
            inflacionSemestralList[n] = pow(1+inflacionAnualList[n], rs.freqCupon.d/diasXAño.d)-1
            bonoList[n] = (n == 1 ? vNominal : (plazoGraciaList[n-1] == "T" ? bonoIndexadoList[n-1] - cuponList[n-1] : bonoIndexadoList[n-1] + amortList[n-1]))
            bonoIndexadoList[n] = bonoList[n]*(1+inflacionSemestralList[n])
            cuponList[n] = -bonoIndexadoList[n]*rs.tes
            amortList[n] = (plazoGraciaList[n] == "S" ? -bonoIndexadoList[n]/(rs.nroPeriodosTotal.d - n.d + 1.d):0)
            cuotaList[n] = (plazoGraciaList[n] == "T" ? 0 : (plazoGraciaList[n] == "P" ? cuponList[n] : cuponList[n]+amortList[n]))
            primaList[n] = (n == rs.nroPeriodosTotal ? -prima*vNominal : 0)
            escudoList[n] = -cuponList[n]*impRenta
            flujoEmisorList[n] = cuotaList[n] + primaList[n]
            flujoEmisorEscudoList[n] = flujoEmisorList[n] + escudoList[n]
            flujoBonistaList[n] = -flujoEmisorList[n]
            flujoActList[n] = flujoBonistaList[n]/pow(1+rs.cok, n.d)
            flujoActxPlazoList[n] = flujoActList[n]*n.d*rs.freqCupon.d/diasXAño.d
            convexidadList[n] = flujoActList[n]*n.d*(1+n).d
        }
        rs.utilidad = Math.computeNPV(desc: rs.cok, cashFlows: flujoBonistaList)
        rs.precioActual = rs.utilidad - flujoBonistaList[0]
        rs.duracion = flujoActxPlazoList.reduce(0, +)/flujoActList.reduce(0, +)
        rs.convexidad = convexidadList.reduce(0, +)/(pow(1+rs.cok,2.d)*flujoActList.reduce(0, +)*pow((diasXAño.d/rs.freqCupon.d),2.d))
        rs.total = rs.duracion + rs.convexidad
        rs.duracionModificada = rs.duracion/(1+rs.cok)
        rs.tceaEmisor = pow(1 + Math.computeIRR(cashFlows: flujoEmisorList)!, rs.nroPeriodosxAño.d) - 1
        rs.tceaEmisorEscudo = pow(1 + Math.computeIRR(cashFlows: flujoEmisorEscudoList)!, rs.nroPeriodosxAño.d) - 1
        rs.treaBonista = pow(1 + Math.computeIRR(cashFlows: flujoBonistaList)!, rs.nroPeriodosxAño.d) - 1
    }
}

