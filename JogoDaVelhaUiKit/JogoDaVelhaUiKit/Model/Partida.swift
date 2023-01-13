//
//  Partida.swift
//  JogoDaVelhaUiKit
//
//  Created by usr_prime on 20/12/22.
//

import Foundation

struct Partida {
    var codigo: Int
    var codigo_jogador: Int
    var data: Date
    var resultado: String
    
    init(codigo: Int = 0, codigo_jogador: Int, data: Date, resultado: String) {
        self.codigo = codigo
        self.codigo_jogador = codigo_jogador
        self.data = data
        self.resultado = resultado
    }
}
