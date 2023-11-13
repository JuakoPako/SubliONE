<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>${producto.nombre}</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/CSS/productoencontrado.css">
</head>
<body>
	<header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd;">
            <div class="container">
                <a class="navbar-brand" href="/">SubliONE</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/productos">Productos</a>
                        </li>
                        <c:choose>
                        	
                            <c:when test="${usuarioEnSesion != null}">
								<c:if test="${usuarioEnSesion.rol == 'ADMINISTRADOR'}">
									<a href="/misproductos" class="nav-link">Ver Mis Productos</a>
									<a href="/subirproductos" class="nav-link">Subir Nuevos Productos</a>
								</c:if>
									<li class="nav-item">
                                    	<a class="nav-link" href="/logout">Cerrar Sesión</a>
                                	</li>
                            </c:when>
                            <c:otherwise>
                            	<li class="nav-item">
                                    <a class="nav-link" href="/login">Iniciar Sesión</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/registrarse">Registrarse</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    
    
    <div class="product-details">
        <div class="product-image">
            <img src="/img/${producto.imagen}" alt="${producto.nombre}">
        </div>
        <div class="product-info">
            <h1>${producto.nombre}</h1>
            <p>${producto.descripcion}</p>
            <p>Precio: $${producto.precio} CLP</p>
            <p>Disponibilidad: ${producto.stock} en stock</p>
            
            <div class="product-actions">
                
                
    
    			<a href="https://api.whatsapp.com/send?phone=56963889818" _blank><button type="submit" class="btn btn-success">Comprar</button></a>
				
                
                
            </div>
        </div>
    </div>
    
    
</body>
</html>