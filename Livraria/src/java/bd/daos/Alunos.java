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
 * @author u17182 e u17186
 */
public class Alunos {
        
    public static void incluir (Aluno aluno) throws Exception
    {
        if (aluno==null)
            throw new Exception ("Aluno nao fornecido");

        try
        {
            String sql;
            
            sql = "insert into aluno values" +
                  "(?,?,?)";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, aluno.getRa());
            BDSQLServer.COMANDO.setString(2, aluno.getNome());
            BDSQLServer.COMANDO.setString(3, aluno.getEmail());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao inserir aluno");
        }
    }
        
    public static void excluir (String ra) throws Exception
    {
        try
        {
            String sql;

            sql = "DELETE FROM aluno " +
                  "WHERE RA=?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, ra);

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao excluir aluno");
        }    
    }
    
    public static void alterar (Aluno aluno) throws Exception
    {
        if (aluno==null)
            throw new Exception ("aluno nao fornecido");

        try
        {
            String sql;

            sql = "update aluno set ra=?, nome=?, email=? where ra = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, aluno.getRa());
            BDSQLServer.COMANDO.setString (2, aluno.getNome());
            BDSQLServer.COMANDO.setString (3, aluno.getEmail());
            BDSQLServer.COMANDO.setString (4, aluno.getRa());

            BDSQLServer.COMANDO.executeUpdate ();
            BDSQLServer.COMANDO.commit        ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao atualizar dados de alunos");
        }
    }

    public static Aluno getAlunoRa (String ra) throws Exception
    {
        Aluno aluno = null;

        try
        {
            String sql;

            sql = "select * from aluno where ra = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, ra);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            aluno = new Aluno (resultado.getString("ra"),
                               resultado.getString("nome"),
                               resultado.getString("email"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar aluno");
        }

        return aluno;
    }
    
    public static Aluno getAlunoNome (String nome) throws Exception
    {
        Aluno aluno = null;

        try
        {
            String sql;

            sql = "select * from aluno where nome = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString (1, nome);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();

            if (!resultado.first())
                throw new Exception ("Nao cadastrado");

            aluno = new Aluno (resultado.getString("ra"),
                               resultado.getString("nome"),
                               resultado.getString("email"));
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao procurar aluno");
        }

        return aluno;
    }

    public static MeuResultSet getAlunos () throws Exception
    {
        MeuResultSet resultado = null;

        try
        {
            String sql;

            sql = "select * from aluno order by ra";

            BDSQLServer.COMANDO.prepareStatement (sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
        }
        catch (SQLException erro)
        {
            throw new Exception ("Erro ao recuperar alunos");
        }

        return resultado;
    }
    
}
