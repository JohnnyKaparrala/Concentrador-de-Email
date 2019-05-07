/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd.dbos;

/**
 *
 * @author u17182 e u17186
 */
public class Aluno {

    public Aluno(){
        this.ra = "0";
        this.nome = "null";
        this.email = "null";
    }
    
    public Aluno(String ra, String nome, String email) {
        this.ra = ra;
        this.nome = nome;
        this.email = email;
    }

    public String getRa() {
        return ra;
    }

    public void setRa(String ra) {
        this.ra = ra;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Aluno{" + "ra=" + ra + ", nome=" + nome + ", email=" + email + '}';
    }
    
    private String ra;
    private String nome;
    private String email;
}
