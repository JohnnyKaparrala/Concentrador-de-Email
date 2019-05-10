/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd.dbos;

import java.util.Objects;

/**
 *
 * @author u17182
 */
public class Email {
    
    private int id;
    private int id_dono;
    private String email;       //50
    private String protocolo;   //20
    private String host;        //20
    private String porta;       //20
    private String senha;       //20
    private boolean tem_ssl;
    
    
    public Email() {
    }

    public Email(int id, int id_dono, String email, String protocolo, String host, String porta, String senha, boolean tem_ssl) {
        this.id = id;
        this.id_dono = id_dono;
        this.email = email;
        this.protocolo = protocolo;
        this.host = host;
        this.porta = porta;
        this.senha = senha;
        this.tem_ssl = tem_ssl;
    }

    public Email(int id_dono, String email, String protocolo, String host, String porta, String senha, boolean tem_ssl) {
        this.id = 0; //indica que é um email feito no programa, e não pego no BD
        this.id_dono = id_dono;
        this.email = email;
        this.protocolo = protocolo;
        this.host = host;
        this.porta = porta;
        this.senha = senha;
        this.tem_ssl = tem_ssl;
    }
       
    public int getId() {
        return id;
    }

    public void setId(int id) throws Exception{
        this.id = id;
    }
    public boolean isTem_ssl() {
        return tem_ssl;
    }

    public void setTem_ssl(boolean tem_ssl) {
        this.tem_ssl = tem_ssl;
    }
    
    public int getId_dono() {
        return id_dono;
    }

    public void setId_dono(int id_dono) {
        this.id_dono = id_dono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) throws Exception{
        if(email.length()>50)
            throw new Exception("email muito grande: limite de 50 caracteres. . .");
        this.email = email;
    }

    public String getProtocolo() {
        return protocolo;
    }

    public void setProtocolo(String protocolo) throws Exception{
        if(protocolo.length()>20)
            throw new Exception("protocolo muito grande: limite de 20 caracteres. . .");
        this.protocolo = protocolo;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) throws Exception{
        if(host.length()>20)
            throw new Exception("host muito grande: limite de 20 caracteres. . .");
        this.host = host;
    }

    public String getPorta() {
        return porta;
    }

    public void setPorta(String porta) throws Exception{
        if(porta.length()>20)
            throw new Exception("porta muito grande: limite de 20 caracteres. . .");
        this.porta = porta;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) throws Exception{
        if(senha.length()>20)
            throw new Exception("senha muito grande: limite de 20 caracteres. . .");
        this.senha = senha;
    }

    @Override
    public String toString() {
        return "Email{" + "id=" + id + "id_dono=" + id_dono + ", email=" + email + ", protocolo=" + protocolo + ", host=" + host + ", porta=" + porta + ", senha=" + senha + "ssl=" + tem_ssl +'}';
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 17 * hash + this.id_dono;
        hash = 17 * hash + Objects.hashCode(this.email);
        hash = 17 * hash + Objects.hashCode(this.protocolo);
        hash = 17 * hash + Objects.hashCode(this.host);
        hash = 17 * hash + Objects.hashCode(this.porta);
        hash = 17 * hash + Objects.hashCode(this.senha);
        hash = 17 * hash + Objects.hashCode(this.tem_ssl);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Email other = (Email) obj;
        if (this.id_dono != other.id_dono) {
            return false;
        }
        if (!Objects.equals(this.email, other.email)) {
            return false;
        }
        if (!Objects.equals(this.protocolo, other.protocolo)) {
            return false;
        }
        if (!Objects.equals(this.host, other.host)) {
            return false;
        }
        if (!Objects.equals(this.porta, other.porta)) {
            return false;
        }
        if (!Objects.equals(this.senha, other.senha)) {
            return false;
        }
        if (!Objects.equals(this.tem_ssl, other.tem_ssl)) {
            return false;
        }
        return true;
    }
    
    
}
