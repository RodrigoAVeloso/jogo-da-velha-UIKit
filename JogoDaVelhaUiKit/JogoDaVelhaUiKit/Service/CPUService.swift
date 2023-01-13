
import Foundation

class CPUService: JogoDaVelhaService {
    
    private var cpuJogou: Bool = false
    private var feito: Bool = false
    
    override func adicionar(linha: Int, coluna: Int, jogadorDaVez: String){
        jogoDaVelha.adicionar(linha: linha, coluna: coluna, jogadorDaVez)
        if jogoDaVelha.verTabuleiro(linha: linha, coluna: coluna) == jogadorDaVez {
            if jogoDaVelha.acabou() {
                if jogoDaVelha.empate(){
                    self.jogadorDaVez = "..."
                }
                self.acabou = true
            }else{
                mudarJogador()
                jogadaCPU()
            }
        }
        
    }
    
    func jogadaCPU(){
         
       repeat {
           let linha = Int.random(in: 0..<3)
           let coluna = Int.random(in: 0..<3)
           
            if verTabuleiro(linha: linha, coluna: coluna) == "" {

                if self.cpuJogou != true { diagonalEsquerdaDireita() }
                
                if self.cpuJogou != true { diagonalDireitaEsquerda() }
                
                if self.cpuJogou != true { impedirVitoriaHorizontal() }
                
                if self.cpuJogou != true { impedirVitoriaVertical() }
                  
                if self.cpuJogou != true { jogadaAleatoria(linha: linha, coluna: coluna) }
                
                self.feito = true
            }
           
        } while feito != true
        
        feito = false
        self.cpuJogou = false
    }
    
    func jogadaAleatoria(linha: Int, coluna:Int){
        jogoDaVelha.adicionar(linha: linha, coluna: coluna,jogadorDaVez)
        jogadaFeita(linha, coluna)
    }
    
    func impedirVitoriaHorizontal(){
        
        for i in 0..<3 {
            
            if verTabuleiro(linha: i, coluna: 0) == jogadores[0] && verTabuleiro(linha: i, coluna: 0) == verTabuleiro(linha: i, coluna: 1)
                && verTabuleiro(linha: i, coluna: 2) == "" {
                jogoDaVelha.adicionar(linha: i, coluna: 2,jogadorDaVez)
                jogadaFeita(i, 2)
                self.cpuJogou = true
                return
            }
            
            if verTabuleiro(linha: i, coluna: 2) == jogadores[0] && verTabuleiro(linha: i, coluna: 0) == verTabuleiro(linha: i, coluna: 2)
                && verTabuleiro(linha: i, coluna: 1) == "" {
                jogoDaVelha.adicionar(linha: i, coluna: 1,jogadorDaVez)
                jogadaFeita(i, 1)
                self.cpuJogou = true
                return
            }
            
            if verTabuleiro(linha: i, coluna: 1) == jogadores[0] && verTabuleiro(linha: i, coluna: 1) == verTabuleiro(linha: i, coluna: 2)
                && verTabuleiro(linha: i, coluna: 0) == "" {
                jogoDaVelha.adicionar(linha: i, coluna: 0,jogadorDaVez)
                jogadaFeita(i, 0)
                self.cpuJogou = true
                return
            }
            
        }
        
    }
    
    func impedirVitoriaVertical() {
        
        for i in 0..<3 {
            if verTabuleiro(linha: 0, coluna: i) == jogadores[0] && verTabuleiro(linha: 0, coluna: i) == verTabuleiro(linha: 1, coluna: i)
                && verTabuleiro(linha: 2, coluna: i) == ""{
                jogoDaVelha.adicionar(linha: 2, coluna: i,jogadorDaVez)
                jogadaFeita(2, i)
                self.cpuJogou = true
                return
            }
            
            if verTabuleiro(linha: 2, coluna: i) == jogadores[0] && verTabuleiro(linha: 0, coluna: i) == verTabuleiro(linha: 2, coluna: i)
                && verTabuleiro(linha: 1, coluna: i) == "" {
                jogoDaVelha.adicionar(linha: 1, coluna: i,jogadorDaVez)
                jogadaFeita(1, i)
                self.cpuJogou = true
                return
            }
            
            if verTabuleiro(linha: 1, coluna: i) == jogadores[0] && verTabuleiro(linha: 1, coluna: i) == verTabuleiro(linha: 2, coluna: i)
                && verTabuleiro(linha: 0, coluna: i) == "" {
                jogoDaVelha.adicionar(linha: 0, coluna: i,jogadorDaVez)
                jogadaFeita(0, i)
                self.cpuJogou = true
                return
            }
            
        }
        
    }
    
    // impedir vitória em diagonal da esquerda para a direita
    func diagonalEsquerdaDireita(){
        
        if verTabuleiro(linha: 0, coluna: 0) == jogadores[0] && verTabuleiro(linha: 0, coluna: 0) == verTabuleiro(linha: 1, coluna: 1)
            && verTabuleiro(linha: 2, coluna: 2) == "" {
            self.cpuJogou = true
            jogoDaVelha.adicionar(linha: 2, coluna: 2, jogadorDaVez)
            jogadaFeita(2, 2)
            return
        }
        
        if verTabuleiro(linha: 0, coluna: 0) == jogadores[0] && verTabuleiro(linha: 0, coluna: 0) == verTabuleiro(linha: 2, coluna: 2)
            && verTabuleiro(linha: 1, coluna: 1) == "" {
            self.cpuJogou = true
            jogoDaVelha.adicionar(linha: 1, coluna: 1, jogadorDaVez)
            jogadaFeita(1, 1)
            return
        }
        
        if verTabuleiro(linha: 2, coluna: 2) == jogadores[0] && verTabuleiro(linha: 2, coluna: 2) == verTabuleiro(linha: 1, coluna: 1)
            && verTabuleiro(linha: 0, coluna: 0) == "" {
            self.cpuJogou = true
            jogoDaVelha.adicionar(linha: 0, coluna: 0, jogadorDaVez)
            jogadaFeita(0, 0)
            return
        }
        
    }
    
    // impedir vitória em diagonal da direita para a esquerda
    func diagonalDireitaEsquerda() {
        
        if verTabuleiro(linha: 0, coluna: 2) == jogadores[0] && verTabuleiro(linha: 0, coluna: 2) == verTabuleiro(linha: 1, coluna: 1)
            && verTabuleiro(linha: 2, coluna: 0) == "" {
            self.cpuJogou = true
            jogoDaVelha.adicionar(linha: 2, coluna: 0, jogadorDaVez)
            jogadaFeita(2, 0)
            return
        }
        
        if verTabuleiro(linha: 0, coluna: 2) == jogadores[0] && verTabuleiro(linha: 0, coluna: 2) == verTabuleiro(linha: 2, coluna: 0)
            && verTabuleiro(linha: 1, coluna: 1) == "" {
            self.cpuJogou = true
            jogoDaVelha.adicionar(linha: 1, coluna: 1, jogadorDaVez)
            jogadaFeita(1, 1)
            return
        }
        
        if verTabuleiro(linha: 2, coluna: 0) == jogadores[0] && verTabuleiro(linha: 2, coluna: 0) == verTabuleiro(linha: 1, coluna: 1)
            && verTabuleiro(linha: 0, coluna: 2) == "" {
            self.cpuJogou = true
            jogoDaVelha.adicionar(linha: 0, coluna: 2, jogadorDaVez)
            jogadaFeita(0, 2)
            return
        }
        
    }
    
    func jogadaFeita(_ linha:Int,_ coluna: Int){
        if jogoDaVelha.verTabuleiro(linha: linha, coluna: coluna) == jogadorDaVez {
            if jogoDaVelha.acabou() {
                if jogoDaVelha.empate(){
                    self.jogadorDaVez = "Empate"
                }
                self.acabou = true
            }else{
                mudarJogador()
            }
        }
    }
    
}

