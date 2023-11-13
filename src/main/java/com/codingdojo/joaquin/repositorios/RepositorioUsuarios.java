package com.codingdojo.joaquin.repositorios;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.codingdojo.joaquin.modelos.Usuario;



public interface RepositorioUsuarios extends CrudRepository<Usuario, Long> {
	
	@Query ("SELECT u FROM Usuario u WHERE u.email = :email")
	Usuario findByEmail(@Param("email")String email);
}
