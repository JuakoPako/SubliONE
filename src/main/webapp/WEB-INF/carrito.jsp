<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<html>
<head>
<meta charset="ISO-8859-1">
<title>Carro de ${usuario.nombre}</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/CSS/dashboard.css">
<link rel="stylesheet" href="/CSS/carrito.css">
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
    	
    <div class="cart-content">
			    <c:choose>
			        <c:when test="${not empty carrito}">
			            <c:forEach items="${carrito}" var="producto">
			                <div>
			                    <img src="img/${producto.imagen}" alt="${producto.nombre}" class="imagenproducto">
			                    <div class="product-info">
			                        <h4>${producto.nombre}</h4>
			                        <h4 id="precio">$${producto.precio} CLP</h4>
			                    </div>
			                </div>
			            </c:forEach>
			        </c:when>
			        <c:otherwise>
			            <div class="carritovacio">
			                <h2 class="texto">No hay productos en tu carrito.</h2>
			            </div>
			        </c:otherwise>
			    </c:choose>
			</div>

			<div class="total-container">
			<div class="total-label">Total:</div>
			<div class="total-amount">$${total} CLP</div>
		    
		    <form:form action="/checkout" method="post" modelAttribute="nuevaCompra">
			    <input type="hidden" value="${usuarioEnSesion.id}" path="usuario">
			    <input type="hidden" value="${carrito}" path="productos">
			    <input type="submit" class="btn btn-success" value="Pagar"> 
		    </form:form>
		</div>
    	
</body>
</html>