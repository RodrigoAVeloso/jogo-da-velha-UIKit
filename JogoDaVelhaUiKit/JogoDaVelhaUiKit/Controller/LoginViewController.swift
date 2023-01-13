//
//  LoginViewController.swift
//  JogoDaVelhaUiKit
//
//  Created by usr_prime on 20/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Atributos
    
    private var jogadores:[Jogador] = []
    var menu: MenuViewController?
    var db: DBManager?
    var service: CadastroService?
 
    // MARK: - Init
    
    init(menu: MenuViewController, db: DBManager) {
        super.init(nibName: "LoginViewController", bundle: nil)
        self.menu = menu
        self.db = db
        self.service = CadastroService(db: db)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        senhaTextField?.isSecureTextEntry = true
        navigationController?.isNavigationBarHidden = true
        sigInButton.layer.cornerRadius = 20
        emailTextField?.keyboardType = .emailAddress
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var sigInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var senhaTextField: UITextField?
    
    // MARK: - IBAction
    
    @IBAction func cadastro(_ sender: Any) {
        let cadastro = CadastroViewController(service: service!, db: db!)
        navigationController?.pushViewController(cadastro, animated: true)
    }
    
    @IBAction func menu(_ sender: Any) {
        guard let email = emailTextField?.text else { return }
        guard let senha = senhaTextField?.text else { return }
        guard let jogadorLogado = service?.login(email, senha) else {
            let alerta = alert()
            self.present(alerta, animated: true)
            return
        }
        menu?.jogadorLogado = jogadorLogado
        menu?.logado = true
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Funções
    
    func alert() -> UIAlertController{
        let alerta = UIAlertController(title: "Login", message: "E-mail ou senha incorretos!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alerta.addAction(action)
        return alerta
    }
    
}
