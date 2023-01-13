//
//  CadastroViewController.swift
//  JogoDaVelhaUiKit
//
//  Created by usr_prime on 20/12/22.
//

import UIKit

class CadastroViewController: UIViewController {
    
    private var jogadores:[Jogador] = []
    var service: CadastroService?
    var db: DBManager?
    
    // MARK: - Init
    
    init(service: CadastroService, db: DBManager) {
        super.init(nibName: "CadastroViewController", bundle: nil)
        self.service = service
        self.db = db
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - IBOutlets

    @IBOutlet weak var salvarButton: UIButton!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var emaiTextLabel: UITextField!
    @IBOutlet weak var nomeTextLabel: UITextField!
    @IBOutlet weak var confirmaSenhaTextField: UITextField!
    
    // MARK: - Life view cycle
    
    override func viewDidLoad() {
        senhaTextField.isSecureTextEntry = true
        confirmaSenhaTextField.isSecureTextEntry = true
        salvarButton.layer.cornerRadius = 20
        emaiTextLabel.keyboardType = .emailAddress
    }

    // MARK: - IBActions
    
    @IBAction func salvar(_ sender: Any) {
        guard let nome = nomeTextLabel.text, let email = emaiTextLabel.text, let senha = senhaTextField.text, let confirmaSenha = confirmaSenhaTextField.text else { return }
        
        if senha != confirmaSenha {
            let alerta = alert("Erro", "senhas incompativeis!")
            self.present(alerta, animated: true)
            return
        }
        
        guard let existeEmail = service?.existeEmail(email: email) else { return }
        
        if existeEmail {
            let alerta = alert("Erro", "E-mail já cadastrado!")
            self.present(alerta, animated: true)
            return
        }
        
        guard let jogadorSalvo = service?.salvarJogador(jogador: Jogador(nome: nome, email: email, senha: senha)) else { return }
        
        if jogadorSalvo {
            navigationController?.popViewController(animated: true)
        }else{
            let alerta = alert("Erro", "E-mail incorreto!")
            self.present(alerta, animated: true)
        }
    }
    
    
    @IBAction func voltar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func alert(_ titulo:String,_ message:String) -> UIAlertController{
        let alerta = UIAlertController(title: titulo, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(action)
        return alerta
    }
}
