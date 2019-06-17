/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd.daos;

import java.sql.*;
import bd.*;
import bd.core.*;
import bd.dbos.*;

/**
 *
 * @author u17182
 */
public class Emails {
        
    public static void incluir (Email em) throws Exception
    {
        if (em==null)
            throw new Exception ("Email nao fornecido");

        try
        {
            String sql;
            
            sql = "insert into EMAIL values" +
                  "(?,?,?,?,?,?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt   (1, em.getId_dono());
            BDSQLServer.COMANDO.setString(2, em.getEmail()); 
            BDSQLServer.COMANDO.setString(3, em.getProtocolo());
            BDSQLServer.COMANDO.setString(4, em.getHost());
            BDSQLServer.COMANDO.setString(5, em.getPorta());
            BDSQLServer.COMANDO.setString(6, em.getSenha());          
            BDSQLServer.COMANDO.setBoolean(7, em.isTem_ssl());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception (erro.getMessage());
        }
    }

    public Emails() {
    }
        
    
    public static void excluir (int id) throws Exception
    {
        String sql;

        sql = "DELETE FROM EMAIL " +
              "WHERE ID=?";

        BDSQLServer.COMANDO.prepareStatement (sql);

        BDSQLServer.COMANDO.setInt(1, id);

        BDSQLServer.COMANDO.executeUpdate ();
        BDSQLServer.COMANDO.commit        ();  
    }
    
    public static void alterar (Email em) throws Exception
    {
        if (em==null)
            throw new Exception ("email nao fornecido");
        if  (em.getId()<=0)
            throw new Exception ("ID de email inválido: deve ser maior que 0");

        String sql;

        sql = "update email set id_dono=?, email=?, protocolo=?,"
                + " host=?, porta=?, senha=?, tem_ssl=? "
                + "where id = ?";
                                

        BDSQLServer.COMANDO.prepareStatement (sql);

        BDSQLServer.COMANDO.setInt    (1, em.getId_dono());
        BDSQLServer.COMANDO.setString (2, em.getEmail());
        BDSQLServer.COMANDO.setString (3, em.getProtocolo());
        BDSQLServer.COMANDO.setString (4, em.getHost());
        BDSQLServer.COMANDO.setString (5, em.getPorta());
        BDSQLServer.COMANDO.setString (6, em.getSenha());
        BDSQLServer.COMANDO.setBoolean(7, em.isTem_ssl());
        BDSQLServer.COMANDO.setInt    (8, em.getId()); 

        BDSQLServer.COMANDO.executeUpdate ();
        BDSQLServer.COMANDO.commit        ();
    }

    public static Email getEmailId (int id) throws Exception
    {
        Email em = null;

        try
        {
            String sql;

            sql = "select * from email where id = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, id);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            em = new Email (resultado.getInt("id"),
                            resultado.getInt("id_dono"),
                            resultado.getString("email"),
                            resultado.getString("protocolo"),
                            resultado.getString("host"),
                            resultado.getString("porta"),
                            resultado.getString("senha"),
                            resultado.getBoolean("tem_ssl"));
        }
        catch (SQLException erro)
        {
            throw new Exception (erro.getMessage());
        }

        return em;
    }
    
    public static Email getEmail (String email) throws Exception
    {
        MeuResultSet resultado;
        Email em;
        try
        {
            String sql;

            sql = "select * from EMAIL where email = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, email);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");
            
            em = new Email (resultado.getInt("id"),
                            resultado.getInt("id_dono"),
                            resultado.getString("email"),
                            resultado.getString("protocolo"),
                            resultado.getString("host"),
                            resultado.getString("porta"),
                            resultado.getString("senha"),
                            resultado.getBoolean("tem_ssl"));

            
        }
        catch (SQLException erro)
        {
            throw new Exception (erro.getMessage());
        }

        return em;
    }
    
    public static MeuResultSet getEmailsDono (int id) throws Exception
    {
        MeuResultSet resultado;
        
        try
        {
            String sql;

            sql = "select * from EMAIL where id_dono = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setInt (1, id);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            
        }
        catch (SQLException erro)
        {
            throw new Exception (erro.getMessage());
        }

        return resultado;
    }

}
