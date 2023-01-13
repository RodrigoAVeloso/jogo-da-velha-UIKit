
import Foundation

class JogoDaVelhaService{
    
    let linhas: Int
    let colunas: Int
    
    var jogoDaVelha: JogoDaVelha
    
    let jogadores: [String]
    
    var jogadorDaVez: String
    var acabou: Bool = false
    var inicio: Bool = false
    
    init(){
        self.jogoDaVelha = JogoDaVelha()
        self.jogadores = [jogoDaVelha.jogadorUm, jogoDaVelha.jogadorDois]
        self.jogadorDaVez = jogoDaVelha.jogadorUm
        self.linhas = jogoDaVelha.linhas
        self.colunas = jogoDaVelha.colunas
    }
    
    func verTabuleiro(linha: Int, coluna: Int) -> String {
        return jogoDaVelha.verTabuleiro(linha: linha, coluna: coluna)
    }
    
    func adicionar(linha: Int, coluna: Int, jogadorDaVez: String){}
    
    func mudarJogador(){
        self.jogadorDaVez = jogadorDaVez == jogadores[0] ? jogadores[1] : jogadores[0]
    }
    
    func reiniciar() {
        self.acabou = false
        self.jogoDaVelha = JogoDaVelha()
        self.jogadorDaVez = jogadores[0]
    }
    
    func iniciar(){
        self.jogoDaVelha = JogoDaVelha()
        self.inicio = true
    }
    
    func acabar(){
        self.inicio = false
        self.jogadorDaVez = jogadores[0]
    }
    
    
}

