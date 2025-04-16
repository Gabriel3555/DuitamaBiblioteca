<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Biblioteca Municipal</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">Biblioteca Municipal</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <!-- Opciones de Libros -->
        <li class="nav-item">
          <a class="nav-link" href="listarLibros.jsp">Listar Libros</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="agregarLibro.jsp">Agregar Libro</a>
        </li>

        <!-- Opciones de Préstamos -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Gestión de Préstamos
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="listarPrestamos.jsp">Listar Préstamos</a></li>
            <li><a class="dropdown-item" href="registrarPrestamo.jsp">Registrar Préstamo</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-5">
  <div class="text-center">
    <h1 class="display-4">Bienvenido a la Biblioteca Municipal</h1>
    <p class="lead">Gestiona los libros de la biblioteca de manera sencilla y eficiente.</p>
    <a href="listarLibros.jsp" class="btn btn-primary btn-lg">Ver Libros</a>
    <a href="agregarLibro.jsp" class="btn btn-success btn-lg">Agregar Libro</a>
  </div>
</div>

<footer class="bg-primary text-white text-center py-3 mt-5">
  <p>&copy; 2025 Biblioteca Municipal de Duitama. Todos los derechos reservados.</p>
</footer>

<jsp:include page="bot.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>