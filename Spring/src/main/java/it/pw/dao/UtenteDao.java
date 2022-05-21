package it.pw.dao;

import java.util.List;

import it.pw.model.Utente;


public interface UtenteDao {
	void create(Utente u);
	boolean verificaLogin(String username,String password);
	boolean verficaUsername(String username);
	List<Utente>leggiTutti();
}
