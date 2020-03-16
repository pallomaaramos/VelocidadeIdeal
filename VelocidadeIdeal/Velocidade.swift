//
//  Velocidade.swift
//  VelocidadeIdeal
//
//  Created by Palloma Ramos on 10/03/20.
//  Copyright © 2020 Palloma Ramos. All rights reserved.
//

import Foundation
class Velocidade {
var maxima: Int

/// usa isso para documentar
var metros: Int

var segundos: Int
var modo: String

init(maxima:Int, metros:Int, segundos:Int) {
    self.maxima = maxima
    self.metros = metros
    self.segundos = segundos
    modo = ""
}

func velocidadeIdeal() -> Int {
    let velocidadeIdeal:Int
    let speed:Int
    speed = (metros/segundos)*Int(3.6)
    
    
    
    if modo == "carro"{
        velocidadeIdeal = speed
    }
    else {
        velocidadeIdeal = speed - 10
    }
    
    return velocidadeIdeal
    
}
}
