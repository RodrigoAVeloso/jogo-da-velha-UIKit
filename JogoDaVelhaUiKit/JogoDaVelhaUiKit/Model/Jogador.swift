//
//  Jogador.swift
//  JogoDaVelhaUiKit
//
//  Created by usr_prime on 20/12/22.
//

import Foundation

class Jogador: NSObject, NSCoding {
    
    let codigo: Int
    var nome: String
    var email: String
    var senha: String
    
    init(codigo: Int = 0, nome: String, email: String, senha: String) {
        self.codigo = codigo
        self.nome = nome
        self.email = email
        self.senha = senha
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(codigo, forKey: "codigo")
        coder.encode(nome, forKey: "nome")
        coder.encode(email, forKey: "email")
        coder.encode(senha, forKey: "senha")
    }
    
    required init?(coder: NSCoder) {
        codigo = coder.decodeInteger(forKey: "codigo")
        nome = coder.decodeObject(forKey: "nome") as! String
        email = coder.decodeObject(forKey: "email") as! String
        senha = coder.decodeObject(forKey: "senha") as! String
    }
    
}
