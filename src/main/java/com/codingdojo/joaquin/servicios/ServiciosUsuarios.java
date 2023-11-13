package com.codingdojo.joaquin.servicios;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.joaquin.modelos.Usuario;
import com.codingdojo.joaquin.repositorios.RepositorioUsuarios;

@Service
public class ServiciosUsuarios {
	
	@Autowired
	private RepositorioUsuarios repoUsuarios;

	public Usuario registrar(Usuario nuevoUsuario, BindingResult result) {
		//Comparar contraseñas
		String contrasena = nuevoUsuario.getPassword();
		String confirmacion = nuevoUsuario.getConfirmacion();
		if(!contrasena.equals(confirmacion)) {
			result.rejectValue("confirmacion", "Matches", "Las contraseñas no coinciden");
		}
		
		String email = nuevoUsuario.getEmail();
		Usuario existeUsuario = repoUsuarios.findByEmail(email);
		if(existeUsuario != null ) {
			result.rejectValue("email", "Unique", "El correo ingresado ya se encuentra registrado.");
		}
		
		//Si existe error, entonces regresamos null
		if(result.hasErrors()) {
			return null;
		} else {
			//Si NO hay error GUARDAMOS!
			String contra_encriptada = BCrypt.hashpw(contrasena, BCrypt.gensalt() );
			nuevoUsuario.setPassword(contra_encriptada);
			return repoUsuarios.save(nuevoUsuario);
		}
		
	}
	
	public Usuario login(String email, String password) {
		//Revisamos que el correo que recibimos está en la base de datos
		Usuario usuarioInicioSesion = repoUsuarios.findByEmail(email); //Objeto Usuario o null
		if(usuarioInicioSesion == null ) {
			return null;
		}
		
		//Comparamos contraseñas
		//BCrypt.checkpw(Contra NO encriptada, Contra SI Encriptada);
		if(BCrypt.checkpw(password, usuarioInicioSesion.getPassword())) {
			return usuarioInicioSesion;
		}  
		
		return null;
		
	}
}
