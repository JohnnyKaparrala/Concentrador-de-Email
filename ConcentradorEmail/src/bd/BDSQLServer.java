package bd;

import bd.core.*;
import bd.daos.*;

public class BDSQLServer
{
    public static final MeuPreparedStatement COMANDO;

    static
    {
    	MeuPreparedStatement comando = null;

    	try
        {
            comando =
            new MeuPreparedStatement (
            "com.microsoft.sqlserver.jdbc.SQLServerDriver",
            "jdbc:sqlserver://regulus.cotuca.unicamp.br:1433;databasename=BD17186",
            "BD17186", "BD17186");
        }
        catch (Exception erro)
        {
            System.err.println (erro.getMessage() + "Visual é neoNazista");
            System.exit(0); // aborta o programa
        }
        
        COMANDO = comando;
    }
}