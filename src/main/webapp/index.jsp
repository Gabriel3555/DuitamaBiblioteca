<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión de Biblioteca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-book me-2"></i>Biblioteca Municipal
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#" id="nav-home">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="nav-add">Agregar Libro</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="nav-list">Catálogo</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="nav-loans">Préstamos</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="container mt-4">
    <!-- Home Section -->
    <section id="home-section" class="section-active">
        <div class="row">
            <div class="col-md-6">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h2 class="card-title">Bienvenido al Sistema de Gestión</h2>
                        <p class="card-text">Este sistema permite administrar el inventario de libros y gestionar préstamos de la Biblioteca Municipal.</p>
                        <div class="d-flex justify-content-between mt-4">
                            <button class="btn btn-primary" id="btn-to-add">Agregar Libro</button>
                            <button class="btn btn-success" id="btn-to-loans">Gestionar Préstamos</button>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <h3 class="card-title">Estadísticas</h3>
                        <div class="row text-center mt-3">
                            <div class="col-4">
                                <div class="stat-box">
                                    <i class="bi bi-book text-primary"></i>
                                    <h4 id="total-books">0</h4>
                                    <p>Libros</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-box">
                                    <i class="bi bi-bookmark text-success"></i>
                                    <h4 id="available-books">0</h4>
                                    <p>Disponibles</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-box">
                                    <i class="bi bi-person-check text-warning"></i>
                                    <h4 id="active-loans">0</h4>
                                    <p>Préstamos</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h3 class="card-title">Búsqueda Rápida</h3>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" id="quick-search" placeholder="Buscar por título, autor o ISBN...">
                            <button class="btn btn-outline-primary" type="button" id="btn-quick-search">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>

                        <div id="quick-results" class="mt-3">
                            <div class="quick-results-placeholder text-center text-muted">
                                <i class="bi bi-search display-4"></i>
                                <p>Los resultados de búsqueda aparecerán aquí</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm mt-4">
                    <div class="card-body">
                        <h3 class="card-title">Actividad Reciente</h3>
                        <ul class="list-group list-group-flush" id="recent-activity">
                            <li class="list-group-item text-center text-muted">No hay actividad reciente</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Add Book Section -->
    <section id="add-section" class="d-none">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title mb-4">Agregar Nuevo Libro</h2>

                <form id="book-form">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="book-isbn" class="form-label">ISBN</label>
                            <input type="text" class="form-control" id="book-isbn" required>
                            <div class="invalid-feedback">El ISBN es obligatorio</div>
                        </div>
                        <div class="col-md-6">
                            <label for="book-type" class="form-label">Tipo de Libro</label>
                            <select class="form-select" id="book-type" required>
                                <option value="" selected disabled>Seleccionar tipo...</option>
                                <option value="ficcion">Ficción</option>
                                <option value="no-ficcion">No Ficción</option>
                                <option value="referencia">Referencia</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label for="book-title" class="form-label">Título</label>
                            <input type="text" class="form-control" id="book-title" required>
                            <div class="invalid-feedback">El título es obligatorio</div>
                        </div>
                        <div class="col-md-4">
                            <label for="book-year" class="form-label">Año de Publicación</label>
                            <input type="number" class="form-control" id="book-year" min="1000" max="2099" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="book-author" class="form-label">Autor</label>
                            <input type="text" class="form-control" id="book-author" required>
                        </div>
                        <div class="col-md-6">
                            <label for="book-publisher" class="form-label">Editorial</label>
                            <input type="text" class="form-control" id="book-publisher" required>
                        </div>
                    </div>

                    <!-- Dynamic fields based on book type -->
                    <div id="dynamic-fields" class="mb-3">
                        <!-- Fields will be added dynamically via JavaScript -->
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="book-description" class="form-label">Descripción</label>
                            <textarea class="form-control" id="book-description" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="book-copies" class="form-label">Número de Copias</label>
                            <input type="number" class="form-control" id="book-copies" min="1" value="1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="book-location" class="form-label">Ubicación</label>
                            <input type="text" class="form-control" id="book-location" placeholder="Ej: Estante A-12" required>
                        </div>
                        <div class="col-md-4">
                            <label for="book-cover" class="form-label">Imagen de Portada</label>
                            <input type="file" class="form-control" id="book-cover" accept="image/*">
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mt-4">
                        <button type="button" class="btn btn-secondary me-2" id="btn-reset-form">Limpiar</button>
                        <button type="submit" class="btn btn-primary">Guardar Libro</button>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- Book List Section -->
    <section id="list-section" class="d-none">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title mb-4">Catálogo de Libros</h2>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" id="search-catalog" placeholder="Buscar libros...">
                            <button class="btn btn-outline-primary" type="button" id="btn-search-catalog">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <select class="form-select" id="filter-type">
                            <option value="all" selected>Todos los tipos</option>
                            <option value="ficcion">Ficción</option>
                            <option value="no-ficcion">No Ficción</option>
                            <option value="referencia">Referencia</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" id="filter-availability">
                            <option value="all" selected>Todos</option>
                            <option value="available">Disponibles</option>
                            <option value="loaned">Prestados</option>
                        </select>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ISBN</th>
                            <th>Título</th>
                            <th>Autor</th>
                            <th>Tipo</th>
                            <th>Disponible</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody id="books-table-body">
                        <tr class="text-center text-muted">
                            <td colspan="6">No hay libros registrados</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center" id="pagination">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Anterior</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item disabled">
                            <a class="page-link" href="#">Siguiente</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </section>

    <!-- Loans Section -->
    <section id="loans-section" class="d-none">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title mb-4">Gestión de Préstamos</h2>

                <ul class="nav nav-tabs mb-4" id="loansTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="new-loan-tab" data-bs-toggle="tab" data-bs-target="#new-loan" type="button" role="tab">Nuevo Préstamo</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="active-loans-tab" data-bs-toggle="tab" data-bs-target="#active-loans-tab-content" type="button" role="tab">Préstamos Activos</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="loan-history-tab" data-bs-toggle="tab" data-bs-target="#loan-history" type="button" role="tab">Historial</button>
                    </li>
                </ul>

                <div class="tab-content" id="loansTabContent">
                    <!-- New Loan Tab -->
                    <div class="tab-pane fade show active" id="new-loan" role="tabpanel">
                        <form id="loan-form" class="row g-3">
                            <div class="col-md-6">
                                <label for="patron-id" class="form-label">ID del Usuario</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="patron-id" required>
                                    <button class="btn btn-outline-primary" type="button" id="btn-search-patron">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="patron-name" class="form-label">Nombre del Usuario</label>
                                <input type="text" class="form-control" id="patron-name" readonly>
                            </div>

                            <div class="col-md-6">
                                <label for="book-id-loan" class="form-label">ISBN del Libro</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="book-id-loan" required>
                                    <button class="btn btn-outline-primary" type="button" id="btn-search-book">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="book-title-loan" class="form-label">Título del Libro</label>
                                <input type="text" class="form-control" id="book-title-loan" readonly>
                            </div>

                            <div class="col-md-6">
                                <label for="loan-date" class="form-label">Fecha de Préstamo</label>
                                <input type="date" class="form-control" id="loan-date" required>
                            </div>

                            <div class="col-md-6">
                                <label for="return-date" class="form-label">Fecha de Devolución</label>
                                <input type="date" class="form-control" id="return-date" required>
                            </div>

                            <div class="col-12 mt-4">
                                <button type="submit" class="btn btn-primary">Registrar Préstamo</button>
                            </div>
                        </form>
                    </div>

                    <!-- Active Loans Tab -->
                    <div class="tab-pane fade" id="active-loans-tab-content" role="tabpanel">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" id="search-active-loans" placeholder="Buscar por usuario o libro...">
                            <button class="btn btn-outline-primary" type="button">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID Préstamo</th>
                                    <th>Usuario</th>
                                    <th>Libro</th>
                                    <th>Fecha Préstamo</th>
                                    <th>Fecha Devolución</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                                </thead>
                                <tbody id="active-loans-table">
                                <tr class="text-center text-muted">
                                    <td colspan="7">No hay préstamos activos</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Loan History Tab -->
                    <div class="tab-pane fade" id="loan-history" role="tabpanel">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="search-loan-history" placeholder="Buscar en historial...">
                                    <button class="btn btn-outline-primary" type="button">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="history-start-date">
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="history-end-date">
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID Préstamo</th>
                                    <th>Usuario</th>
                                    <th>Libro</th>
                                    <th>Fecha Préstamo</th>
                                    <th>Fecha Devolución</th>
                                    <th>Fecha Real</th>
                                    <th>Estado</th>
                                </tr>
                                </thead>
                                <tbody id="history-loans-table">
                                <tr class="text-center text-muted">
                                    <td colspan="7">No hay registros en el historial</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center" id="history-pagination">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Anterior</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item disabled">
                                    <a class="page-link" href="#">Siguiente</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- Book Details Modal -->
<div class="modal fade" id="bookDetailsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-book-title">Detalles del Libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <img id="modal-book-cover" src="/placeholder.svg?height=200&width=150" alt="Portada del libro" class="img-fluid mb-3 book-cover">
                        <div id="modal-book-availability" class="badge bg-success mb-2">Disponible</div>
                        <p id="modal-book-copies" class="text-muted">3 copias disponibles</p>
                    </div>
                    <div class="col-md-8">
                        <h4 id="modal-book-title-header">Título del Libro</h4>
                        <p class="text-muted" id="modal-book-author">Autor del Libro</p>

                        <div class="book-details-grid">
                            <div class="detail-item">
                                <span class="detail-label">ISBN:</span>
                                <span id="modal-book-isbn">1234567890</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Tipo:</span>
                                <span id="modal-book-type">Ficción</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Año:</span>
                                <span id="modal-book-year">2023</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Editorial:</span>
                                <span id="modal-book-publisher">Editorial</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Ubicación:</span>
                                <span id="modal-book-location">Estante A-12</span>
                            </div>
                        </div>

                        <div id="modal-book-specific-details" class="mt-3">
                            <!-- Specific details based on book type will be added here -->
                        </div>

                        <h5 class="mt-3">Descripción</h5>
                        <p id="modal-book-description">Descripción del libro...</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="btn-edit-book">Editar</button>
                <button type="button" class="btn btn-success" id="btn-loan-book">Prestar</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="editBookModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Editar Libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit-book-form">
                    <input type="hidden" id="edit-book-id">
                    <!-- Form fields similar to add book form -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="edit-book-isbn" class="form-label">ISBN</label>
                            <input type="text" class="form-control" id="edit-book-isbn" required>
                        </div>
                        <div class="col-md-6">
                            <label for="edit-book-type" class="form-label">Tipo de Libro</label>
                            <select class="form-select" id="edit-book-type" required>
                                <option value="ficcion">Ficción</option>
                                <option value="no-ficcion">No Ficción</option>
                                <option value="referencia">Referencia</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label for="edit-book-title" class="form-label">Título</label>
                            <input type="text" class="form-control" id="edit-book-title" required>
                        </div>
                        <div class="col-md-4">
                            <label for="edit-book-year" class="form-label">Año de Publicación</label>
                            <input type="number" class="form-control" id="edit-book-year" min="1000" max="2099" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="edit-book-author" class="form-label">Autor</label>
                            <input type="text" class="form-control" id="edit-book-author" required>
                        </div>
                        <div class="col-md-6">
                            <label for="edit-book-publisher" class="form-label">Editorial</label>
                            <input type="text" class="form-control" id="edit-book-publisher" required>
                        </div>
                    </div>

                    <!-- Dynamic fields based on book type -->
                    <div id="edit-dynamic-fields" class="mb-3">
                        <!-- Fields will be added dynamically via JavaScript -->
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="edit-book-description" class="form-label">Descripción</label>
                            <textarea class="form-control" id="edit-book-description" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="edit-book-copies" class="form-label">Número de Copias</label>
                            <input type="number" class="form-control" id="edit-book-copies" min="1" value="1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="edit-book-location" class="form-label">Ubicación</label>
                            <input type="text" class="form-control" id="edit-book-location" placeholder="Ej: Estante A-12" required>
                        </div>
                        <div class="col-md-4">
                            <label for="edit-book-cover" class="form-label">Imagen de Portada</label>
                            <input type="file" class="form-control" id="edit-book-cover" accept="image/*">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="btn-delete-book">Eliminar</button>
                <button type="button" class="btn btn-primary" id="btn-save-edit">Guardar Cambios</button>
            </div>
        </div>
    </div>
</div>

<!-- Return Book Modal -->
<div class="modal fade" id="returnBookModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Registrar Devolución</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="return-form">
                    <input type="hidden" id="return-loan-id">

                    <div class="mb-3">
                        <label class="form-label">Libro</label>
                        <p id="return-book-title" class="form-control-static">Título del Libro</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Usuario</label>
                        <p id="return-patron-name" class="form-control-static">Nombre del Usuario</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fecha de Préstamo</label>
                        <p id="return-loan-date" class="form-control-static">01/01/2023</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fecha de Devolución Esperada</label>
                        <p id="return-expected-date" class="form-control-static">15/01/2023</p>
                    </div>

                    <div class="mb-3">
                        <label for="return-actual-date" class="form-label">Fecha de Devolución Real</label>
                        <input type="date" class="form-control" id="return-actual-date" required>
                    </div>

                    <div class="mb-3">
                        <label for="return-condition" class="form-label">Estado del Libro</label>
                        <select class="form-select" id="return-condition" required>
                            <option value="good">Bueno</option>
                            <option value="damaged">Dañado</option>
                            <option value="lost">Perdido</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="return-notes" class="form-label">Notas</label>
                        <textarea class="form-control" id="return-notes" rows="2"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="btn-save-return">Registrar Devolución</button>
            </div>
        </div>
    </div>
</div>

<!-- Toast Notifications -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="liveToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto" id="toast-title">Notificación</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toast-message">
            Mensaje de notificación
        </div>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmation-title">Confirmar Acción</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="confirmation-message">¿Está seguro que desea realizar esta acción?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="btn-confirm">Confirmar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="script.js"></script>
</body>
</html>
