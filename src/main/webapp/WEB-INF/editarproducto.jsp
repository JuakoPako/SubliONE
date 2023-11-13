<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editar Producto</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/CSS/dashboard.css">
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
    
    
    <form:form modelAttribute="producto" action="/actualizar/${producto.id}" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="_method" value="PUT">
    	<div class="mb-3">
    		<form:label path="nombre">Nombre:</form:label>
    		<form:input path="nombre" class="form-control"/>
    		<form:errors path="nombre"/>
    	</div>
    	
    	<div class="mb-3">
    		<form:label path="descripcion">Descripción:</form:label>
    		<form:input path="descripcion" class="form-control"/>
    		<form:errors path="descripcion"/>
    	</div>
    	
    	<div class="mb-3">
    		<form:label path="precio">Precio:</form:label>
    		<form:input type="number" path="precio" class="form-control"/>
    		<form:errors path="precio"/>
    	</div>
    	
    	<div class="mb-3">
    		<form:label path="stock">Stock:</form:label>
    		<form:input type="number" path="stock" class="form-control"/>
    		<form:errors path="stock"/>
    	</div>
    	
    	<div class="mb-3">
    		<label>Imagen del Producto:</label>
    		<input type="file" class="form-control" id="imagenProducto" name="image">
    	</div>
    	
    	<button type="submit" class="btn btn-primary">Subir Producto.</button>
    	
    </form:form>
    
</body>
</html>