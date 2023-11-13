package com.codingdojo.joaquin.repositorios;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.joaquin.modelos.Producto;
import com.codingdojo.joaquin.modelos.Usuario;

public interface RepositorioProductos extends CrudRepository<Producto, Long>{
	
	List<Producto> findAll();
	
	List<Producto> findByUsuario(Usuario usuario);
	
	List<Producto> findByNombreContaining(String nombre);
	
	
}
