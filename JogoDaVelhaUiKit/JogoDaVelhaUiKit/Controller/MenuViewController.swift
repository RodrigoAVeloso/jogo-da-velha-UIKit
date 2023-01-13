//
//  ViewController.swift
//  JogoDaVelhaUiKit
//
//  Created by usr_prime on 15/12/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        
        if logado == false {
            let loginView = LoginViewController(menu: self, db: self.db)
            navigationController?.pushViewController(loginView, animated: true)
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    let db = DBManager()
    var jogadorLogado = Jogador(nome: "", email: "", senha: "")
    var logado: Bool = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "multiplayer" {
            guard let tabuleiro = segue.destination as? TabuleiroViewController else { return }
            tabuleiro.jogadorLogado = jogadorLogado
            tabuleiro.jogoDaVelha = MultiplayerService()
        }
        if segue.identifier == "cpu" {
            guard let tabuleiro = segue.destination as? TabuleiroViewController else { return }
            print("Codigo: \(jogadorLogado.codigo) | Nome: \(jogadorLogado.nome) | E-mail: \(jogadorLogado.email) | Senha: \(jogadorLogado.senha)")
            tabuleiro.jogadorLogado = jogadorLogado
            tabuleiro.jogoDaVelha = CPUService()
        }
    }

    @IBAction func signOut(_ sender: Any) {
        self.logado = false
        viewDidLoad()
    }
    
}

