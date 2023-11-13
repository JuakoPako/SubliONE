package com.codingdojo.joaquin.controladores;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.joaquin.modelos.Pedido;
import com.codingdojo.joaquin.modelos.Producto;
import com.codingdojo.joaquin.modelos.Usuario;
import com.codingdojo.joaquin.servicios.ServiciosPedidos;
import com.codingdojo.joaquin.servicios.ServiciosProductos;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ControladorPagina {

	@Autowired
	private ServiciosPedidos serviciosPedidos;
	
	@Autowired
	private ServiciosProductos serviciosProductos;
	
	
    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        
        Usuario usuario = (Usuario) session.getAttribute("usuarioEnSesion");
        
        model.addAttribute("usuario", usuario);
        return "dashboard.jsp";
    }
    
    
    
    
    @GetMapping("/misproductos")
    public String mostrarMisProductos(Model model, HttpSession session) {
    	Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login";
        }
        
        List<Producto> misProductos = serviciosProductos.obtenerTodosLosProductos();
        model.addAttribute("misProductos", misProductos);
        
        return "misproductos.jsp";
    }
    
    
    @GetMapping("/subirproductos")
    public String mostrarFormularioProducto(@ModelAttribute("nuevoProducto") Producto nuevoProducto, Model model, HttpSession session) {
    	Usuario usuarioTemporal = (Usuario)session.getAttribute("usuarioEnSesion");
		if(usuarioTemporal == null) {
			return "redirect:/login";
		}
		
		return "subirproducto.jsp";
    }
    
    @PostMapping("/nuevoproducto")
    public String subirProducto(@Valid @ModelAttribute("nuevoProducto") Producto nuevoProducto, BindingResult result,
            @RequestParam("image") MultipartFile image, HttpSession session,
            RedirectAttributes redirectAttributes) {
    	
    	Usuario usuarioTemporal = (Usuario)session.getAttribute("usuarioEnSesion");
		if(usuarioTemporal == null) {
			return "redirect:/login";
		}
		
		
		if (result.hasErrors()) {
			
			return "subirproducto.jsp";
		} else {
			
			// Obtener el usuario en sesion
			Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
			
			//Asocia el producto con el usuario
			nuevoProducto.setUsuario(usuarioEnSesion);
			
			// Guardar imagen como un array de bytes
			
			if(!image.isEmpty()) {
				
				Path directorioImagenes = Paths.get("src/main/resources/static/img");
				
				String rutaAbsoluta = directorioImagenes.toFile().getAbsolutePath();
				
				try {
					byte[] bytesImg = image.getBytes();
					Path rutaCompleta = Paths.get(rutaAbsoluta+"/"+image.getOriginalFilename());
					Files.write(rutaCompleta, bytesImg);
					
					nuevoProducto.setImagen(image.getOriginalFilename());
				} catch(IOException e) {
					e.printStackTrace();
				}
				
			}
			
			serviciosProductos.guardarProducto(nuevoProducto);
			
			redirectAttributes.addFlashAttribute("mensaje", "Producto subido exitosamente.");
			
			
			return "redirect:/misproductos";
			
		}
		
    }
    
    
    @GetMapping("/editarproducto/{id}")
    public String editarProducto(@PathVariable("id") Long id, Model model, HttpSession session, @ModelAttribute("producto") Producto producto ) {
    	Usuario usuarioTemporal = (Usuario)session.getAttribute("usuarioEnSesion");
		if(usuarioTemporal == null) {
			return "redirect:/login";
		}
		
		Producto productoAEditar = serviciosProductos.encontrarProducto(id);
		
		model.addAttribute("producto", productoAEditar);
		
		return "editarproducto.jsp";
    	
    	
    }
    
    
    @PutMapping("/actualizar/{id}")
    public String actualizarProducto(@Valid @ModelAttribute("producto") Producto producto, BindingResult result) {
    	
    	if(result.hasErrors()) {
    		return "editarproducto.jsp";
    	} else {
    		serviciosProductos.guardarProducto(producto);
    		return "redirect:/misproductos";
    	}
    }
    
    
    @GetMapping("eliminarproducto/{id}")
    public String eliminarProducto(@PathVariable("id") Long id) {
    	serviciosProductos.eliminarProducto(id);
    	
    	return "redirect:/misproductos";
    }
    
    
    @GetMapping("/productos")
    public String Productos(Model model) {
    	List<Producto> productos = serviciosProductos.obtenerTodosLosProductos();
    	model.addAttribute("productos", productos);
    	
    	return "productos.jsp";
    }
    
    
    @GetMapping("/verproducto/{id}")
    public String verproducto(@PathVariable("id") Long id, Model model) {
    	Producto productoBuscado = serviciosProductos.encontrarProducto(id);
    	
    	model.addAttribute("producto", productoBuscado);
    	
    	return "productoencontrado.jsp";
    }
    
    
    @GetMapping("/agregarcarrito/{id}")
    public String agregarcarrito(@PathVariable("id") Long id, HttpSession session) {
    	List<Object> carrito = (List<Object>) session.getAttribute("carrito");
    	if(carrito == null) {
    		carrito = new ArrayList<>();
    		session.setAttribute("carrito", carrito);
    	}
    	
    	//Obtener el objeto producto
    	
    	Producto productoBuscado = serviciosProductos.encontrarProducto(id);
    	carrito.add(productoBuscado);
    	session.setAttribute("carrito", carrito);
    	
    	return "redirect:/verproducto/{id}";
    			
    	
    }
    
    
    @GetMapping("/carrito")
    public String carrito(HttpSession session, Model model, @ModelAttribute("nuevaCompra") Pedido pedido) {
    	
    	List<Producto> carrito = (List<Producto>)session.getAttribute("carrito");
    	
    	//Calcular precio final
    	
    	double total = 0;
    	if(carrito != null) {
    		for(Producto producto : carrito) {
    			total += producto.getPrecio();
    		}
    	}
    	
    	model.addAttribute("nuevaCompra", new Pedido());
    	
    	model.addAttribute("carrito", carrito);
    	
    	model.addAttribute("total", total);
    	
    	
    	return "carrito.jsp";
    	
    }
    
    
    @PostMapping("/checkout")
    public String pagar(@ModelAttribute("nuevaCompra") Pedido pedido, BindingResult result, HttpSession session, RedirectAttributes redirectAttributes) {
    	
    	// validar pedido
    	
    	if (result.hasErrors()) { System.out.println("hay error");
    		return "carrito.jsp";
    	}
    	
    	// validar usuario en sesion
    	
    	Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
	    if (usuarioEnSesion == null) {
	        
	        return "redirect:/login";
	    }
    	
	    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
	    if(carrito == null || carrito.isEmpty()) {
	    	return "redirect:/carrito";
	    }
	    
	    //Crear nuevo pedido
	    Pedido nuevoPedido = new Pedido();
	    nuevoPedido.setUsuario(usuarioEnSesion);
	    nuevoPedido.setProductos(carrito);
	    
	    //Guardar Pedido
	    serviciosPedidos.guardarPedido(nuevoPedido);
	    
	    //reducir stock de los productos
	    
	    if(nuevoPedido.getProductos() != null && !nuevoPedido.getProductos().isEmpty()) {
	    	for(Producto producto : nuevoPedido.getProductos()) {
	    		int cantidadEnCarrito = contarProductoEnCarrito(producto, carrito);
	    		if (cantidadEnCarrito <= producto.getStock()) {
	    			producto.vender(cantidadEnCarrito);
	    			serviciosProductos.guardarProducto(producto);
	    		} else {
	    			
	    		}
	    	}
	    }
	    
	    //Limpiar carrito de la sesion
	    session.removeAttribute("carrito");
	    
	    redirectAttributes.addFlashAttribute("mensaje", "¡Pedido realizado con éxito!");
	    return "redirect:/";
	    
	    
    }
	
    // Método auxiliar para contar la cantidad de un producto en el carrito
    private int contarProductoEnCarrito(Producto producto, List<Producto> carrito) {
	    int contador = 0;
	    for (Producto item : carrito) {
	        if (item.getId().equals(producto.getId())) {
	            contador++;
	        }
	    }
	    return contador;
	}
    
    @PostMapping("/checkout/{productoId}")
    public String comprarAhora(@PathVariable("productoId") Long productoId, HttpSession session, RedirectAttributes redirectAttributes) {
    	Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
	    if (usuarioEnSesion == null) {
	        
	        return "redirect:/login";
	    }
	    
	    Producto productoComprado = serviciosProductos.encontrarProducto(productoId);
	    if(productoComprado == null || productoComprado.getStock() < 1) {
	    	redirectAttributes.addFlashAttribute("mensaje", "No hay stock.");
	    	return "redirect:/producto/" + productoId;
	    }
	    
	    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
	    if(carrito == null) {
	    	carrito = new ArrayList<>();
	    	session.setAttribute("carrito", carrito);
	    }
	    
	    carrito.add(productoComprado);
	    
	    redirectAttributes.addFlashAttribute("mensaje", "Producto añadido al carrito.");
	    return "redirect:/carrito";
    	
    }
	
	
}
