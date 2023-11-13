<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/registerlogin.css">
</head>

<body>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body text-center">
                        <img src="/img/logosublione.png" alt="Logo" class="mb-4" width="100" height="100">
                        <h1 class="h3 mb-3">Registrarse</h1>

                        <form action="/registro" method="post">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre:</label>
                                <input type="text" id="nombre" name="nombre" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido:</label>
                                <input type="text" id="apellido" name="apellido" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Correo:</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="region" class="form-label">Región:</label>
                                <input type="text" id="region" name="region" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label for="ciudad" class="form-label">Ciudad:</label>
                                <input type="text" id="ciudad" name="ciudad" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label for="calle" class="form-label">Calle:</label>
                                <input type="text" id="calle" name="calle" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label for="numero" class="form-label">Número:</label>
                                <input type="text" id="numero" name="numero" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña:</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="confirmacion" class="form-label">Confirmar Contraseña:</label>
                                <input type="password" id="confirmacion" name="confirmacion" class="form-control"
                                    required>
                            </div>

                            <button class="btn btn-primary btn-lg btn-block lila-btn" type="submit">Registrarse</button>
                        </form>

                        <div class="mt-3">
                            <a href="/login">¿Ya tiene cuenta?</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>


</html>