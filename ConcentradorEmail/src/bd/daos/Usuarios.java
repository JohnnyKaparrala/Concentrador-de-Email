/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd.daos;

import bd.*;
import bd.core.*;
import bd.dbos.*;
import java.sql.*;

/**
 *
 * @author u17182
 */
public class Usuarios {

    public Usuarios() {
    }        
    
    
    public static void incluir (Usuario usu) throws Exception
    {
        if (usu==null)
            throw new Exception ("Usuario nao fornecido");

        try
        {
            /* desnecessário, pois não é uma plataforma social. . .
            //verifica se já existe um usuário com o mesmo nick
            try{
                Usuario teste = getUsuarioNick(usu.getNick());
                //se chegou aqui, é porque existe um usuario com o mesmo nick
                throw new Exception("tentativa de cadastro de nick já cadastrado. . .");
            }catch(Exception ex){
                //lançamento de exception = não possui usuario.
                //então, o código prossegue como esperado.
            }
            */
            
            //verifica se já existe um usuário com o mesmo email
            try{
                Usuario teste = getUsuarioEmail(usu.getEmail());
                //se chegou aqui, é porque existe um usuario com o mesmo email
            }catch(Exception ex){
	            String sql;
	            
	            sql = "insert into USUARIO (nick,senha,email)values" +
	                  "(?,?,?)";
	
	            BDSQLServer.COMANDO.prepareStatement (sql);
	
	            BDSQLServer.COMANDO.setString(1, usu.getNick()); 
	            BDSQLServer.COMANDO.setString(2, usu.getSenha());
	            BDSQLServer.COMANDO.setString(3, usu.getEmail());
	
	            BDSQLServer.COMANDO.executeUpdate ();
	            BDSQLServer.COMANDO.commit        ();
            }       
            
        }
        catch (SQLException erro)
        {
            throw new Exception (erro.getMessage());
        }
    }
        
    public static void excluir (int id) throws Exception
    {
        try
        {
            String sql;

            sql = "DELETE FROM USUARIO " +
                  "WHERE ID=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt(1, id);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir usuario");
        }    
    }
    
    public static void alterar (Usuario usu) throws Exception
    {
        if (usu==null)
            throw new Exception ("usuario nao fornecido");
        if (usu.getId()<=0)
            throw new Exception ("ID de usuario inválido: deve ser menor que 0");

        try
        {
            String sql;

            sql = "update USUARIO set nick=?, email=?, senha=? "
                    + "where id = ?";
                                    

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, usu.getNick());
            BDSQLServer.COMANDO.setString (2, usu.getEmail());
            BDSQLServer.COMANDO.setString (3, usu.getSenha());
            BDSQLServer.COMANDO.setInt    (4, usu.getId()); 

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception (erro.getMessage());
        }
    }

    public static Usuario getUsuarioId (int id) throws Exception
    {
        Usuario usu = null;

        try
        {
            String sql;

            sql = "select * from USUARIO where id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, id);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            usu = new Usuario  (resultado.getInt("id"),
                                resultado.getString("nick"),
                                resultado.getString("email"),
                                resultado.getString("senha"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar usuario");
        }

        return usu;
    }
    
    public static Usuario getUsuarioEmail (String email) throws Exception
    {
        Usuario usu;
        
        try
        {
            String sql;

            sql = "select * from USUARIO where email = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");
            
            usu = new Usuario  (resultado.getInt("id"),
                                resultado.getString("nick"),
                                resultado.getString("email"),
                                resultado.getString("senha"));
            
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar usuario");
        }

        return usu;
    }   
    
    //talvez não vá ser usado. . .
    public static Usuario getUsuarioNick (String nick) throws Exception
    {
        Usuario usu;
        
        try
        {
            String sql;

            sql = "select * from USUARIO where nick = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, nick);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");
            
            usu = new Usuario  (resultado.getInt("id"),
                                resultado.getString("nick"),
                                resultado.getString("email"),
                                resultado.getString("senha"));
            
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar usuario");
        }

        return usu;
    }   
       
}
