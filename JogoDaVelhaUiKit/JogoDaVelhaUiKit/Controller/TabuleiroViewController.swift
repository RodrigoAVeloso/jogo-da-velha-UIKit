//
//  TabuleiroViewController.swift
//  JogoDaVelhaUiKit
//
//  Created by usr_prime on 15/12/22.
//

import UIKit

class TabuleiroViewController: UIViewController {
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        guard let jogada = jogoDaVelha?.jogadorDaVez else { return }
        jogadorDaVezLabel.text = jogada
        button00.setTitle(jogoDaVelha?.verTabuleiro(linha: 0, coluna: 0), for: .normal)
        button01.setTitle(jogoDaVelha?.verTabuleiro(linha: 0, coluna: 1), for: .normal)
        button02.setTitle(jogoDaVelha?.verTabuleiro(linha: 0, coluna: 2), for: .normal)
        button10.setTitle(jogoDaVelha?.verTabuleiro(linha: 1, coluna: 0), for: .normal)
        button11.setTitle(jogoDaVelha?.verTabuleiro(linha: 1, coluna: 1), for: .normal)
        button12.setTitle(jogoDaVelha?.verTabuleiro(linha: 1, coluna: 2), for: .normal)
        button20.setTitle(jogoDaVelha?.verTabuleiro(linha: 2, coluna: 0), for: .normal)
        button21.setTitle(jogoDaVelha?.verTabuleiro(linha: 2, coluna: 1), for: .normal)
        button22.setTitle(jogoDaVelha?.verTabuleiro(linha: 2, coluna: 2), for: .normal)
       
    }
    
//    button00.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 0, coluna: 0)
//    button01.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 0, coluna: 1)
//    button02.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 0, coluna: 2)
//    button10.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 1, coluna: 0)
//    button11.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 1, coluna: 1)
//    button12.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 1, coluna: 2)
//    button20.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 2, coluna: 0)
//    button21.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 2, coluna: 1)
//    button22.titleLabel?.text = jogoDaVelha?.verTabuleiro(linha: 2, coluna: 2)
    
//    private func textLabel(_ linha: Int, coluna: Int) -> String{
//        uiLabel.font = UIFont(name: "Arial", size: 5)
//        uiLabel.text =
//        return uiLabel.text!
//    }
    
    
    // MARK: - Atributos
    
    var jogoDaVelha: JogoDaVelhaService?
    var jogadorLogado: Jogador?
    
    // MARK: - IBOutlets
    
    @IBOutlet var jogadorDaVezLabel: UILabel!
    @IBOutlet var button00: UIButton!
    @IBOutlet var button01: UIButton!
    @IBOutlet var button02: UIButton!
    @IBOutlet var button10: UIButton!
    @IBOutlet var button11: UIButton!
    @IBOutlet var button12: UIButton!
    @IBOutlet var button20: UIButton!
    @IBOutlet var button21: UIButton!
    @IBOutlet var button22: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func ReiniciarBarButton(_ sender: Any) {
        reiniciar()
    }
    
    @IBAction func botao00(){
        jogada(linha: 0, coluna: 0, button: button00)
    }
    
    @IBAction func botao01(){
        jogada(linha: 0, coluna: 1, button: button01)
    }
    
    @IBAction func botao02(){
        jogada(linha: 0, coluna: 2, button: button02)
    }
    
    @IBAction func botao10(){
        jogada(linha: 1, coluna: 0, button: button10)
    }
    
    @IBAction func botao11(){
        jogada(linha: 1, coluna: 1, button: button11)
    }
    
    @IBAction func botao12(){
        jogada(linha: 1, coluna: 2, button: button12)
    }
    
    @IBAction func botao20(){
        jogada(linha: 2, coluna: 0, button: button20)
    }
    
    @IBAction func botao21(){
       jogada(linha: 2, coluna: 1, button: button21)
    }
    
    @IBAction func botao22(){
        jogada(linha: 2, coluna: 2, button: button22)
    }
    
    // MARK: - funções
    
    private func reiniciar(){
        jogoDaVelha?.reiniciar()
        viewDidLoad()
    }
    
    func jogada(linha: Int, coluna: Int, button: UIButton){
        guard let jogada = jogoDaVelha?.jogadorDaVez else { return }
        if jogada == jogoDaVelha?.verTabuleiro(linha: linha, coluna: coluna){ return }
        jogoDaVelha?.adicionar(linha: linha, coluna: coluna, jogadorDaVez: jogada)
        if jogoDaVelha?.acabou == true {
            guard let vencedor = jogoDaVelha?.jogadorDaVez else { return }
            guard let jogador = jogadorLogado else { return }
            let fimDeJogo = FimDoJogoViewController(jogador: jogador)
            fimDeJogo.vencedor = vencedor
            navigationController?.pushViewController(fimDeJogo, animated: true)
            reiniciar()
        }
        viewDidLoad()
    }
    
    
}
