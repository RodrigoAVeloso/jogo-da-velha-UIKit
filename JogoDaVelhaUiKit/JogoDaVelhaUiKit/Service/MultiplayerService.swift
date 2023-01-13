
import Foundation

class MultiplayerService: JogoDaVelhaService {
    
    override func adicionar(linha: Int, coluna: Int, jogadorDaVez: String){
        jogoDaVelha.adicionar(linha: linha, coluna: coluna, jogadorDaVez)
        if jogoDaVelha.verTabuleiro(linha: linha, coluna: coluna) == jogadorDaVez {
            
            if jogoDaVelha.acabou(){
                if jogoDaVelha.empate(){
                    self.jogadorDaVez = "Empate"
                }
                acabou = true
            }else{
                mudarJogador()
            }
        }
    }
    
}

