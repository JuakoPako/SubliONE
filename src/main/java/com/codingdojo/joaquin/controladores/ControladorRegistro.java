package com.codingdojo.joaquin.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.joaquin.enumeraciones.Rol;
import com.codingdojo.joaquin.modelos.Usuario;
import com.codingdojo.joaquin.servicios.ServiciosUsuarios;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ControladorRegistro {
	
	@Autowired
	public ServiciosUsuarios servicioUsuarios;
	


    @GetMapping("/registrarse")
    public String register(@ModelAttribute("nuevoUsuario") Usuario nuevoUsuario) {
        return "register.jsp";
    }

    @PostMapping("/registro")
    public String registro(@Valid @ModelAttribute("nuevoUsuario") Usuario nuevoUsuario, BindingResult result,
            HttpSession session, Model model) {
        if (result.hasErrors()) {
            return "register.jsp";
        } else {
            nuevoUsuario.setRol(Rol.USUARIO);
            servicioUsuarios.registrar(nuevoUsuario, result);
            if (result.hasErrors()) {
                return "register.jsp";
            } else {
                session.setAttribute("usuarioEnSesion", nuevoUsuario);
                // Pasar el usuario al modelo para que esté disponible en la página JSP
                model.addAttribute("usuario", nuevoUsuario);
                return "redirect:/";
            }
        }
    }
	
	@GetMapping("/login")
	public String login() {
		return "login.jsp";
	}
	
	@PostMapping("/loguear")
	public String login(@RequestParam("email") String email, @RequestParam("password") String password, RedirectAttributes redirectAttributes, HttpSession session) {
		
		Usuario usuarioInicioSesion = servicioUsuarios.login(email, password);
		
		if(usuarioInicioSesion == null) {
			//Tiene algo incorrecto
			//Flash me permite enviar errores de validacion a un form clasico
			redirectAttributes.addFlashAttribute("error_login", "El correo/contraseña es incorrecto");
			return "redirect:/login";
		} else {
			//Guardamos en sesion al usuario que quiere iniciar sesion
			session.setAttribute("usuarioEnSesion", usuarioInicioSesion);
			return "redirect:/";
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("usuarioEnSesion");
		session.removeAttribute("carrito");
		return "redirect:/login";
	
		
}
}
