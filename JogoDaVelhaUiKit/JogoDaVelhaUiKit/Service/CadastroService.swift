//
//  CadastroService.swift
//  CadastroDB
//
//  Created by usr_prime on 23/12/22.
//

import Foundation

struct CadastroService {
    
    let db: DBManager
    
    func salvarJogador(jogador: Jogador) -> Bool{
        if db.insertJogador(jogador) {
            print("Salvo com sucesso!")
            return true
        } else {
            print("Erro ao salvar!")
            return false
        }
    }
    
    func mostrar() {
        let jogadores = db.readjogador()
        
        for jogador in jogadores {
            print("codigo: \(jogador.codigo)")
            print("nome: \(jogador.nome)")
            print("email: \(jogador.email)")
            print("senha: \(jogador.senha)")
        }
    }
    
    func existeEmail(email: String) -> Bool{
        let jogadores = db.readjogador()
        
        for jogador in jogadores {
            if (email.caseInsensitiveCompare(jogador.email) == .orderedSame){
                return true
            }
        }
        return false
    }
    
    private func existeSenha(_ senha: String) -> Bool {
        let jogadores = db.readjogador()
        
        for jogador in jogadores {
            if (senha.caseInsensitiveCompare(jogador.senha) == .orderedSame){
                return true
            }
        }
        return false
    }
    
    func login(_ email: String,_ senha: String) -> Jogador? {
        let jogadores = db.readjogador()
        
        for jogador in jogadores {
            if (email.caseInsensitiveCompare(jogador.email) == .orderedSame){
                print("Email correto")
                if (senha.caseInsensitiveCompare(jogador.senha) == .orderedSame){
                    return jogador
                }
            }
        }
        return nil
    }
    
    func salvarPartida(_ partida: Partida){
        var emps = Array<Partida>()
        if db.insertPartida(partida) {
            print("Salvo com sucesso!")
            emps = db.readPartidas()
            print("Count: \(emps.count)")
        } else {
            print("Erro ao salvar!")
        }
        
        for partidaJogada in emps {
            print("codigo: \(partidaJogada.codigo)")
            print("codigo_jogador: \(partidaJogada.codigo_jogador)")
            print("data: \(partidaJogada.data)")
            print("Resultado: \(partidaJogada.resultado)")
        }
    }
    
    func excluirTabela(){
        db.dropTable()
    }
}
