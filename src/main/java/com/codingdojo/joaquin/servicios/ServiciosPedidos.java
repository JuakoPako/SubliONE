package com.codingdojo.joaquin.servicios;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.joaquin.modelos.Pedido;

import com.codingdojo.joaquin.repositorios.RepositorioPedidos;

@Service
public class ServiciosPedidos {

	@Autowired
	private RepositorioPedidos repoPedidos;	
	
	public Pedido guardarPedido(Pedido pedido) {
        return repoPedidos.save(pedido);
    }
	
	
	
}
