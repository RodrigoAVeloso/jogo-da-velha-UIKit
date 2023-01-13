
import Foundation

class JogoDaVelha {
    
    var jogadorUm = "X"
    var jogadorDois = "O"
    
    private var tabuleiro = [["","",""],
                     ["","",""],
                     ["","",""]]
    
    let linhas = 3
    let colunas = 3
    
    init(){
        self.tabuleiro = [["","",""],
                         ["","",""],
                         ["","",""]]
        
    }

    func adicionar (linha: Int, coluna:Int,_ jogada: String){
        if tabuleiro[linha][coluna] == "" {
            tabuleiro[linha][coluna] = jogada
        }
        return
    }
    
    func acabou() -> Bool {
        if vitoriaHorizontal() || vitoriaVertical () || vitoriaDiagonal() || empate() { return true }
        return false
    }
    
    func vitoriaHorizontal() -> Bool {
        for i in 0..<3{
            if tabuleiro[i][0] != "" && tabuleiro[i][0] == tabuleiro[i][1] && tabuleiro[i][1] == tabuleiro[i][2]{ return true }
        }
        return false
    }
    
    func vitoriaVertical() -> Bool {
        for i in 0..<3{
            if tabuleiro[0][i] != "" && tabuleiro[0][i] == tabuleiro[1][i] && tabuleiro[1][i] == tabuleiro[2][i]{ return true }
        }
        return false
    }
    
    func vitoriaDiagonal() -> Bool {
        // Diagonal esquerda -> direita
        if tabuleiro[0][0] != "" && tabuleiro[0][0] == tabuleiro[1][1] && tabuleiro[1][1] == tabuleiro[2][2] { return true }
        
        // Diagonal direita -> esquerda
        if tabuleiro[0][2] != "" && tabuleiro[0][2] == tabuleiro[1][1] && tabuleiro[1][1] == tabuleiro[2][0] { return true }
        
        return false
    }
    
    func empate() -> Bool {
        var i = 0
        for linha in tabuleiro {
            for coluna in linha {
                if coluna == ""{
                    i += 1
                }
            }
        }
        if i == 0 {
            if vitoriaHorizontal() || vitoriaVertical () || vitoriaDiagonal(){ return false }
            return true
        }else{
            return false
        }
            
    }
    
    func verTabuleiro(linha: Int,coluna: Int) -> String {
        return tabuleiro[linha][coluna]
    }
}

