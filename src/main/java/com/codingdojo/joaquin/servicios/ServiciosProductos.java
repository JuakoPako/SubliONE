package com.codingdojo.joaquin.servicios;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.joaquin.modelos.Producto;
import com.codingdojo.joaquin.modelos.Usuario;
import com.codingdojo.joaquin.repositorios.RepositorioProductos;

@Service
public class ServiciosProductos {

	@Autowired
	public RepositorioProductos repoProductos;
	
	 public List<Producto> obtenerTodosLosProductos() {
	        return repoProductos.findAll();
	    }
	 
		 public Producto encontrarProducto(Long id) {
			 return repoProductos.findById(id).orElse(null);
		 }



	    public Producto guardarProducto(Producto producto) {
	        return repoProductos.save(producto);
	    }

	    public void eliminarProducto(Long id) {
	        repoProductos.deleteById(id);
	    }
	    
	    public List<Producto> obtenerProductosPorUsuario(Usuario usuario) {
	        return repoProductos.findByUsuario(usuario);
	    }
	
	    public List<Producto> buscarPorNombre(String nombre) {
	    	return repoProductos.findByNombreContaining(nombre);
	    }
}
