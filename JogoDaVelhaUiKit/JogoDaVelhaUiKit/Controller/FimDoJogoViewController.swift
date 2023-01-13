//
//  FimDoJogoViewController.swift
//  JogoDaVelhaUiKit
//
//  Created by usr_prime on 16/12/22.
//

import UIKit

class FimDoJogoViewController: UIViewController {
    
    var vencedor: String = ""
    let service = CadastroService(db: DBManager())
    var jogador: Jogador?
    
    init(jogador: Jogador){
        super.init(nibName: "FimDoJogoViewController", bundle: nil)
        self.jogador = jogador
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet var vencedorLabel: UILabel?
    
    override func viewDidLoad() {
        guard let jogador = jogador else { return }
        if vencedor == "..." {
            vencedor = "Empate"
        }
        let partida = Partida(codigo_jogador: jogador.codigo, data: Date(), resultado: vencedor)
        service.salvarPartida(partida)
        vencedorLabel?.text = vencedor
        navigationController?.isNavigationBarHidden = true
        
    }

    @IBAction func reiniciarJogo(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: true)
    }
}
