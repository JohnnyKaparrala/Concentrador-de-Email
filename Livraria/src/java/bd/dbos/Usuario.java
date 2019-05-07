/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd.dbos;

/**
 *
 * @author u17182
 */
public class Usuario {
    private int id;
    private String nick; //50
    private String email;//50
    private String senha;//20

    public Usuario(String nick, String email, String senha) {
        this.id = 0;
        this.nick = nick;
        this.email = email;
        this.senha = senha;
    }

    public Usuario(int id, String nick, String email, String senha) {
        this.id = id;
        this.nick = nick;
        this.email = email;
        this.senha = senha;
    }

    public Usuario() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) throws Exception{
        if(nick.length()>50)
            throw new Exception("nick muito grande: limite de 50 caracteres. . .");
        this.nick = nick;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) throws Exception{
        if(email.length()>50)
            throw new Exception("email muito grande: limite de 50 caracteres. . .");
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) throws Exception{
        if(nick.length()>20)
            throw new Exception("senha muito grande: limite de 50 caracteres. . .");
        this.senha = senha;
    }
    
    
}
