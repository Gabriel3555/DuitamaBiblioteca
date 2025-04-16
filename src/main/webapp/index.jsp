<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="resources/header.jsp" />

<!-- Hero Section -->
<section class="hero-section">
  <div class="container text-center">
    <div class="row justify-content-center">
      <div class="col-md-10 animate-fade-in">
        <h1><i class="fas fa-book-reader"></i> Biblioteca Municipal de Duitama</h1>
        <p class="lead">Sistema de gestión bibliotecaria para facilitar el control y préstamo de libros.</p>
        <div class="mt-5">
          <a href="listarLibros.jsp" class="btn btn-light btn-lg me-3">
            <i class="fas fa-book"></i> Ver Catálogo
          </a>
          <a href="registrarPrestamo.jsp" class="btn btn-outline-light btn-lg">
            <i class="fas fa-handshake"></i> Registrar Préstamo
          </a>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Features Section -->
<section class="container my-5">
  <div class="row justify-content-center">
    <div class="col-md-4 mb-4">
      <div class="card feature-card h-100">
        <i class="fas fa-book"></i>
        <h3>Gestión de Libros</h3>
        <p>Administra fácilmente el catálogo de libros de la biblioteca, incluyendo libros de ficción, no ficción y referencia.</p>
        <a href="listarLibros.jsp" class="btn btn-primary mt-auto">Explorar Libros</a>
      </div>
    </div>
    <div class="col-md-4 mb-4">
      <div class="card feature-card h-100">
        <i class="fas fa-handshake"></i>
        <h3>Control de Préstamos</h3>
        <p>Registra y gestiona los préstamos de libros, con fechas de entrega y devolución para un mejor control.</p>
        <a href="listarPrestamos.jsp" class="btn btn-primary mt-auto">Ver Préstamos</a>
      </div>
    </div>
  </div>
</section>

<!-- Recent Books Section -->
<section class="container my-5">
  <div class="row">
    <div class="col-12 text-center mb-4">
      <h2><i class="fas fa-star"></i> Acciones Rápidas</h2>
      <p class="text-muted">Accede rápidamente a las funciones más utilizadas del sistema</p>
    </div>
  </div>
  <div class="row justify-content-center">
    <div class="col-md-3 mb-4">
      <div class="card text-center h-100">
        <div class="card-body">
          <i class="fas fa-plus-circle fa-3x text-success mb-3"></i>
          <h5 class="card-title">Agregar Libro</h5>
          <p class="card-text">Registra un nuevo libro en el sistema</p>
          <a href="agregarLibro.jsp" class="btn btn-success">Agregar</a>
        </div>
      </div>
    </div>
    <div class="col-md-3 mb-4">
      <div class="card text-center h-100">
        <div class="card-body">
          <i class="fas fa-list fa-3x text-primary mb-3"></i>
          <h5 class="card-title">Listar Libros</h5>
          <p class="card-text">Consulta el catálogo completo</p>
          <a href="listarLibros.jsp" class="btn btn-primary">Consultar</a>
        </div>
      </div>
    </div>
    <div class="col-md-3 mb-4">
      <div class="card text-center h-100">
        <div class="card-body">
          <i class="fas fa-handshake fa-3x text-warning mb-3"></i>
          <h5 class="card-title">Nuevo Préstamo</h5>
          <p class="card-text">Registra un nuevo préstamo</p>
          <a href="registrarPrestamo.jsp" class="btn btn-warning">Registrar</a>
        </div>
      </div>
    </div>
    <div class="col-md-3 mb-4">
      <div class="card text-center h-100">
        <div class="card-body">
          <i class="fas fa-clipboard-list fa-3x text-danger mb-3"></i>
          <h5 class="card-title">Listar Préstamos</h5>
          <p class="card-text">Consulta todos los préstamos</p>
          <a href="listarPrestamos.jsp" class="btn btn-danger">Consultar</a>
        </div>
      </div>
    </div>
  </div>
</section>
<jsp:include page="bot.jsp"></jsp:include>
<jsp:include page="/resources/footer.jsp" />