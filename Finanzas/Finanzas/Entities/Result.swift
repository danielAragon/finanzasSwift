//
//  Results.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/10/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import Foundation

class Result{
    
//    Resultados de finanziamiento
    var saldo: Double!
    var monto: Double!
    var nroCuotasxAño: Int!
    var nroTotalCuotas: Int!
    
//    Resutlados de los costes/gastos periodicos
    var desgravamen: Double!
    var riesgo: Double!
    
//    Totales
    var interesesTotal: Double!
    var amortizacionTotal: Double!
    var desgravamenTotal: Double!
    var riesgoTotal: Double!
    var comisionesTotal: Double!
    var portesGastosTotal: Double!
    
//    Indicadores de Rentabilidad
    var descuento: Double!
    var tir: Double!
    var tcea: Double!
    var van: Double!
    
}
