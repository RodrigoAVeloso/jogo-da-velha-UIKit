
import Foundation
import SQLite3

class DBManager {
    
    init() {
        let createTableJogador =  "CREATE TABLE IF NOT EXISTS jogador(codigo INTEGER PRIMARY KEY AUTOINCREMENT,nome VARCHAR(100),email VARCHAR(100) UNIQUE CHECK(email LIKE '%_@__%.__%'),senha VARCHAR(20));"
        
        let createTablePartida = "CREATE TABLE IF NOT EXISTS partida(codigo INTEGER PRIMARY KEY AUTOINCREMENT, codigo_jogador INTEGER, data DATETIME, resultado VARCHAR(1), FOREIGN KEY (codigo_jogador) REFERENCES jogador(codigo));"
       
       
        self.db = openDatabase()
        createTable(createTableString: createTableJogador)
        createTable(createTableString: createTablePartida)
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    // MARK: - Criação do banco de dados
    func openDatabase() -> OpaquePointer?
    {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            debugPrint("can't open database")
            return nil
        }
        else
        {
            print("Successfully created connection to database at \(dbPath)")
            return db
        }
    }
    
    // MARK: - Criação Tabela
    func createTable(createTableString: String) {
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("table created.")
            } else {
                print("table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Inserindo dados da tabela
    func insertJogador(_ jogador: Jogador) -> Bool
    {
        let insertStatementString = "INSERT INTO jogador (nome, email, senha) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (jogador.nome as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (jogador.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (jogador.senha as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
                return false
            }
        } else {
            print("INSERT statement could not be prepared.")
            return false
        }
        sqlite3_finalize(insertStatement)
        return true
    }
    //  let insertStatementString = "INSERT INTO partida (codigo_jogador, data, resultado) VALUES (?, ?, ?);"
    func insertPartida(_ partida: Partida) -> Bool
    {
        let insertStatementString = "INSERT INTO partida (codigo_jogador, data, resultado) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(partida.codigo_jogador))
            sqlite3_bind_double(insertStatement, 2, Double(partida.data.timeIntervalSinceReferenceDate - 10800.0))
            sqlite3_bind_text(insertStatement, 3, (partida.resultado as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
                return false
            }
        } else {
            print("INSERT statement could not be prepared.")
            return false
        }
        sqlite3_finalize(insertStatement)
        return true
    }
    
    // MARK: - Select em toda tabela
    
    func readjogador() -> [Jogador] {
        let queryStatementString = "SELECT * FROM jogador;"
        var queryStatement: OpaquePointer? = nil
        var emps : [Jogador] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let codigo = sqlite3_column_int(queryStatement, 0)
                let nome = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let senha = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                emps.append(Jogador(codigo: Int(codigo), nome: String(nome), email: String(email), senha: String(senha)))
                print("Query Result:")
                print("\(codigo) | \(nome) | \(email) | \(senha)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return emps
    }
    
    func readPartidas() -> [Partida] {
        let queryStatementString = "SELECT * FROM partida;"
        var queryStatement: OpaquePointer? = nil
        var emps : [Partida] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let codigo = sqlite3_column_int(queryStatement, 0)
                let codigo_jogador = sqlite3_column_int(queryStatement, 1)
                let data = sqlite3_column_double(queryStatement, 2)
                let resultado = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                emps.append(Partida(codigo: Int(codigo), codigo_jogador: Int(codigo_jogador), data:Date(timeIntervalSinceReferenceDate: data), resultado: String(resultado)))
                print("Query Result:")
                print("\(codigo) | \(codigo_jogador) | \(Date(timeIntervalSinceReferenceDate: data)) | \(resultado)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return emps
    }
    
    // MARK: - Deletar dados da tabela
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM jogador WHERE codigo = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    // MARK: - DROP Table
    func dropTable(){
        let query = "DROP TABLE partida"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Tabela excluida")
            } else {
                print("ERRO ao excluir tablea")
            }
        } else {
            print("DROP TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

}


