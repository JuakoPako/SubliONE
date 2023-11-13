<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Bienvenid@, ${usuario.nombre}! - SubliONE</title>
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

    <div class="container mt-5">
	    <div class="row">
	    	
	        <div class="col-md-6">
	        	<c:choose>
		        	<c:when test="${usuarioEnSesion == null }">
			            <div class="d-flex align-items-center mb-3">
			                <h1>Bienvenid@!</h1>
			            </div>
		            </c:when>
		            <c:otherwise>
		            	<div class="d-flex align-items-center mb-3">
			                <h1>Bienvenid@, ${usuario.nombre}!</h1>
			            </div>
		            </c:otherwise>
	            </c:choose>
	            <p class="h3">¡Envíos a todo Chile por mayor! Somos una pequeña pyme ubicada en Rengo, Chile, especializada en creaciones propias, sublimación, estampados, plastificados y costuras.</p>
	        </div>
	        
		        <div class="col-md-6 text-center">
		            <img src="/img/1.png" alt="Vestido" width="300">
		            <div class="mt-3">
		                <a class="btn btn-success" href="/productos" role="button">Ver Productos</a>
		        </div>
	        </div>
	    </div>
	</div>

			<br>
		
		<br>
		
		<br>
		
		<br>

		<div class="container mt-5">
		    <div class="row">
		        <div class="col-md-6">
		            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3291.8501260145235!2d-70.85086588737592!3d-34.40515514692856!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x96649fb76628138f%3A0x67361d0e4ea14d80!2sPje.%20J%C3%BApiter%20681%2C%20Rengo%2C%20O&#39;Higgins!5e0!3m2!1ses!2scl!4v1698954673021!5m2!1ses!2scl" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
		        </div>
		        <div class="col-md-6">
		            <h2>¿Dónde Encontrarnos?</h2>
		            <p class="h3">¡Si eres de lugares cercanos, te invitamos a visitarnos en nuestra tienda y descubrir nuestros productos en persona! También aceptamos pedidos personalizados para que obtengas exactamente lo que deseas.</p>
		        </div>
		    </div>
		</div>

		<br>
		
		<br>
		
		<br>
		
		<br>

	<h2 class="text-center mb-4">Galería de Imágenes</h2>
	
	<div class="container-3 mt-5">
    
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="/img/1.png" class="d-block w-100" alt="Imagen 1">
                    </div>
                    <div class="carousel-item">
                        <img src="/img/2.png" class="d-block w-100" alt="Imagen 2">
                    </div>
                    <div class="carousel-item">
                        <img src="/img/3.png" class="d-block w-100" alt="Imagen 3">
                    </div>
                    <div class="carousel-item">
                        <img src="/img/4.png" class="d-block w-100" alt="Imagen 4">
                    </div>
                    <div class="carousel-item">
                        <img src="/img/5.png" class="d-block w-100" alt="Imagen 5">
                    </div>
                    <!-- Agrega más imágenes siguiendo el mismo formato -->
                </div>
                <!-- Controles del carrusel -->
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls"
                    data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Anterior</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls"
                    data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Siguiente</span>
                </button>
            </div>
        </div>
    </div>
</div>



			

    <footer class="bg-secondary mt-5">
    <div class="container-2">
        <p class="mt-2 text-center">&copy; 2023 SubliONE. Todos los derechos reservados. <a href="https://www.instagram.com/subli.one1.official/" target="_blank">Síguenos en Instagram</a></p>
    </div>
	</footer>




    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
