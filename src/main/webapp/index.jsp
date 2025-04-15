<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión de Biblioteca</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css">
    <!-- Font Awesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
                    <a class="nav-link active" href="#" id="nav-inicio">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="nav-agregar">Agregar Libro</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="nav-lista">Catálogo</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="nav-prestamos">Préstamos</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="container mt-4">
    <!-- Home Section -->
    <section id="inicio-section" class="section-active">
        <div class="row">
            <div class="col-md-6">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h2 class="card-title">Bienvenido al Sistema de Gestión</h2>
                        <p class="card-text">Este sistema permite administrar el inventario de libros y gestionar préstamos de la Biblioteca Municipal.</p>
                        <div class="d-flex justify-content-between mt-4">
                            <button class="btn btn-primary" id="btn-ir-agregar">Agregar Libro</button>
                            <button class="btn btn-success" id="btn-ir-prestamos">Gestionar Préstamos</button>
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
                                    <h4 id="total-libros">0</h4>
                                    <p>Libros</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-box">
                                    <i class="bi bi-bookmark text-success"></i>
                                    <h4 id="libros-disponibles">0</h4>
                                    <p>Disponibles</p>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-box">
                                    <i class="bi bi-person-check text-warning"></i>
                                    <h4 id="prestamos-activos">0</h4>
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
                            <input type="text" class="form-control" id="busqueda-rapida" placeholder="Buscar por título, autor o ISBN...">
                            <button class="btn btn-outline-primary" type="button" id="btn-busqueda-rapida">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>

                        <div id="resultados-rapidos" class="mt-3">
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
                        <ul class="list-group list-group-flush" id="actividad-reciente">
                            <li class="list-group-item text-center text-muted">No hay actividad reciente</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Add Book Section -->
    <section id="agregar-section" class="d-none">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title mb-4">Agregar Nuevo Libro</h2>

                <form id="formulario-libro">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="libro-isbn" class="form-label">ISBN</label>
                            <input type="text" class="form-control" id="libro-isbn" required>
                            <div class="invalid-feedback">El ISBN es obligatorio</div>
                        </div>
                        <div class="col-md-6">
                            <label for="libro-tipo" class="form-label">Tipo de Libro</label>
                            <select class="form-select" id="libro-tipo" required>
                                <option value="" selected disabled>Seleccionar tipo...</option>
                                <option value="ficcion">Ficción</option>
                                <option value="no-ficcion">No Ficción</option>
                                <option value="referencia">Referencia</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label for="libro-titulo" class="form-label">Título</label>
                            <input type="text" class="form-control" id="libro-titulo" required>
                            <div class="invalid-feedback">El título es obligatorio</div>
                        </div>
                        <div class="col-md-4">
                            <label for="libro-anio" class="form-label">Año de Publicación</label>
                            <input type="number" class="form-control" id="libro-anio" min="1000" max="2099" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="libro-autor" class="form-label">Autor</label>
                            <input type="text" class="form-control" id="libro-autor" required>
                        </div>
                        <div class="col-md-6">
                            <label for="libro-editorial" class="form-label">Editorial</label>
                            <input type="text" class="form-control" id="libro-editorial" required>
                        </div>
                    </div>

                    <!-- Dynamic fields based on book type -->
                    <div id="campos-dinamicos" class="mb-3">
                        <!-- Fields will be added dynamically via JavaScript -->
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="libro-descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="libro-descripcion" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="libro-copias" class="form-label">Número de Copias</label>
                            <input type="number" class="form-control" id="libro-copias" min="1" value="1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="libro-ubicacion" class="form-label">Ubicación</label>
                            <input type="text" class="form-control" id="libro-ubicacion" placeholder="Ej: Estante A-12" required>
                        </div>
                        <div class="col-md-4">
                            <label for="libro-portada" class="form-label">Imagen de Portada</label>
                            <input type="file" class="form-control" id="libro-portada" accept="image/*">
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mt-4">
                        <button type="button" class="btn btn-secondary me-2" id="btn-limpiar-formulario">Limpiar</button>
                        <button type="submit" class="btn btn-primary">Guardar Libro</button>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- Book List Section -->
    <section id="lista-section" class="d-none">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title mb-4">Catálogo de Libros</h2>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" id="buscar-catalogo" placeholder="Buscar libros...">
                            <button class="btn btn-outline-primary" type="button" id="btn-buscar-catalogo">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <select class="form-select" id="filtro-tipo">
                            <option value="all" selected>Todos los tipos</option>
                            <option value="ficcion">Ficción</option>
                            <option value="no-ficcion">No Ficción</option>
                            <option value="referencia">Referencia</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" id="filtro-disponibilidad">
                            <option value="all" selected>Todos</option>
                            <option value="available">Disponibles</option>
                            <option value="loaned">Prestados</option>
                        </select>
                    </div>
                </div>

                <div class="table-responsive">
                    <table id="tabla-libros" class="table table-hover">
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
                        <tbody id="cuerpo-tabla-libros">
                        <tr class="text-center text-muted">
                            <td colspan="6">No hay libros registrados</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>

    <!-- Loans Section -->
    <section id="prestamos-section" class="d-none">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title mb-4">Gestión de Préstamos</h2>

                <ul class="nav nav-tabs mb-4" id="tabPrestamos" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="nuevo-prestamo-tab" data-bs-toggle="tab" data-bs-target="#nuevo-prestamo" type="button" role="tab">Nuevo Préstamo</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="prestamos-activos-tab" data-bs-toggle="tab" data-bs-target="#prestamos-activos-contenido" type="button" role="tab">Préstamos Activos</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="historial-prestamos-tab" data-bs-toggle="tab" data-bs-target="#historial-prestamos" type="button" role="tab">Historial</button>
                    </li>
                </ul>

                <div class="tab-content" id="contenidoTabPrestamos">
                    <!-- New Loan Tab -->
                    <div class="tab-pane fade show active" id="nuevo-prestamo" role="tabpanel">
                        <form id="formulario-prestamo" class="row g-3">
                            <div class="col-md-6">
                                <label for="id-usuario" class="form-label">ID del Usuario</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="id-usuario" required>
                                    <button class="btn btn-outline-primary" type="button" id="btn-buscar-usuario">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="nombre-usuario" class="form-label">Nombre del Usuario</label>
                                <input type="text" class="form-control" id="nombre-usuario" readonly>
                            </div>

                            <div class="col-md-6">
                                <label for="id-libro-prestamo" class="form-label">ISBN del Libro</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="id-libro-prestamo" required>
                                    <button class="btn btn-outline-primary" type="button" id="btn-buscar-libro">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label for="titulo-libro-prestamo" class="form-label">Título del Libro</label>
                                <input type="text" class="form-control" id="titulo-libro-prestamo" readonly>
                            </div>

                            <div class="col-md-6">
                                <label for="fecha-prestamo" class="form-label">Fecha de Préstamo</label>
                                <input type="date" class="form-control" id="fecha-prestamo" required>
                            </div>

                            <div class="col-md-6">
                                <label for="fecha-devolucion" class="form-label">Fecha de Devolución</label>
                                <input type="date" class="form-control" id="fecha-devolucion" required>
                            </div>

                            <div class="col-12 mt-4">
                                <button type="submit" class="btn btn-primary">Registrar Préstamo</button>
                            </div>
                        </form>
                    </div>

                    <!-- Active Loans Tab -->
                    <div class="tab-pane fade" id="prestamos-activos-contenido" role="tabpanel">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" id="buscar-prestamos-activos" placeholder="Buscar por usuario o libro...">
                            <button class="btn btn-outline-primary" type="button">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>

                        <div class="table-responsive">
                            <table id="tabla-prestamos-activos" class="table table-hover">
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
                                <tbody id="cuerpo-tabla-prestamos-activos">
                                <tr class="text-center text-muted">
                                    <td colspan="7">No hay préstamos activos</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Loan History Tab -->
                    <div class="tab-pane fade" id="historial-prestamos" role="tabpanel">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="buscar-historial-prestamos" placeholder="Buscar en historial...">
                                    <button class="btn btn-outline-primary" type="button">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="fecha-inicio-historial">
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="fecha-fin-historial">
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table id="tabla-historial-prestamos" class="table table-hover">
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
                                <tbody id="cuerpo-tabla-historial-prestamos">
                                <tr class="text-center text-muted">
                                    <td colspan="7">No hay registros en el historial</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- Book Details Modal -->
<div class="modal fade" id="modalDetallesLibro" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-titulo-libro">Detalles del Libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <img id="modal-portada-libro" src="/placeholder.svg?height=200&width=150" alt="Portada del libro" class="img-fluid mb-3 book-cover">
                        <div id="modal-disponibilidad-libro" class="badge bg-success mb-2">Disponible</div>
                        <p id="modal-copias-libro" class="text-muted">3 copias disponibles</p>
                    </div>
                    <div class="col-md-8">
                        <h4 id="modal-encabezado-titulo-libro">Título del Libro</h4>
                        <p class="text-muted" id="modal-autor-libro">Autor del Libro</p>

                        <div class="book-details-grid">
                            <div class="detail-item">
                                <span class="detail-label">ISBN:</span>
                                <span id="modal-isbn-libro">1234567890</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Tipo:</span>
                                <span id="modal-tipo-libro">Ficción</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Año:</span>
                                <span id="modal-anio-libro">2023</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Editorial:</span>
                                <span id="modal-editorial-libro">Editorial</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Ubicación:</span>
                                <span id="modal-ubicacion-libro">Estante A-12</span>
                            </div>
                        </div>

                        <div id="modal-detalles-especificos-libro" class="mt-3">
                            <!-- Specific details based on book type will be added here -->
                        </div>

                        <h5 class="mt-3">Descripción</h5>
                        <p id="modal-descripcion-libro">Descripción del libro...</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="btn-editar-libro">Editar</button>
                <button type="button" class="btn btn-success" id="btn-prestar-libro">Prestar</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="modalEditarLibro" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Editar Libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formulario-editar-libro">
                    <input type="hidden" id="editar-id-libro">
                    <!-- Form fields similar to add book form -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="editar-isbn-libro" class="form-label">ISBN</label>
                            <input type="text" class="form-control" id="editar-isbn-libro" required>
                        </div>
                        <div class="col-md-6">
                            <label for="editar-tipo-libro" class="form-label">Tipo de Libro</label>
                            <select class="form-select" id="editar-tipo-libro" required>
                                <option value="ficcion">Ficción</option>
                                <option value="no-ficcion">No Ficción</option>
                                <option value="referencia">Referencia</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label for="editar-titulo-libro" class="form-label">Título</label>
                            <input type="text" class="form-control" id="editar-titulo-libro" required>
                        </div>
                        <div class="col-md-4">
                            <label for="editar-anio-libro" class="form-label">Año de Publicación</label>
                            <input type="number" class="form-control" id="editar-anio-libro" min="1000" max="2099" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="editar-autor-libro" class="form-label">Autor</label>
                            <input type="text" class="form-control" id="editar-autor-libro" required>
                        </div>
                        <div class="col-md-6">
                            <label for="editar-editorial-libro" class="form-label">Editorial</label>
                            <input type="text" class="form-control" id="editar-editorial-libro" required>
                        </div>
                    </div>

                    <!-- Dynamic fields based on book type -->
                    <div id="editar-campos-dinamicos" class="mb-3">
                        <!-- Fields will be added dynamically via JavaScript -->
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="editar-descripcion-libro" class="form-label">Descripción</label>
                            <textarea class="form-control" id="editar-descripcion-libro" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="editar-copias-libro" class="form-label">Número de Copias</label>
                            <input type="number" class="form-control" id="editar-copias-libro" min="1" value="1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="editar-ubicacion-libro" class="form-label">Ubicación</label>
                            <input type="text" class="form-control" id="editar-ubicacion-libro" placeholder="Ej: Estante A-12" required>
                        </div>
                        <div class="col-md-4">
                            <label for="editar-portada-libro" class="form-label">Imagen de Portada</label>
                            <input type="file" class="form-control" id="editar-portada-libro" accept="image/*">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="btn-eliminar-libro">Eliminar</button>
                <button type="button" class="btn btn-primary" id="btn-guardar-edicion">Guardar Cambios</button>
            </div>
        </div>
    </div>
</div>

<!-- Return Book Modal -->
<div class="modal fade" id="modalDevolucionLibro" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Registrar Devolución</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formulario-devolucion">
                    <input type="hidden" id="devolucion-id-prestamo">

                    <div class="mb-3">
                        <label class="form-label">Libro</label>
                        <p id="devolucion-titulo-libro" class="form-control-static">Título del Libro</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Usuario</label>
                        <p id="devolucion-nombre-usuario" class="form-control-static">Nombre del Usuario</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fecha de Préstamo</label>
                        <p id="devolucion-fecha-prestamo" class="form-control-static">01/01/2023</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fecha de Devolución Esperada</label>
                        <p id="devolucion-fecha-esperada" class="form-control-static">15/01/2023</p>
                    </div>

                    <div class="mb-3">
                        <label for="devolucion-fecha-real" class="form-label">Fecha de Devolución Real</label>
                        <input type="date" class="form-control" id="devolucion-fecha-real" required>
                    </div>

                    <div class="mb-3">
                        <label for="devolucion-estado" class="form-label">Estado del Libro</label>
                        <select class="form-select" id="devolucion-estado" required>
                            <option value="bueno">Bueno</option>
                            <option value="dañado">Dañado</option>
                            <option value="perdido">Perdido</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="devolucion-notas" class="form-label">Notas</label>
                        <textarea class="form-control" id="devolucion-notas" rows="2"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="btn-guardar-devolucion">Registrar Devolución</button>
            </div>
        </div>
    </div>
</div>

<!-- Toast Notifications -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="notificacionToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto" id="titulo-notificacion">Notificación</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="mensaje-notificacion">
            Mensaje de notificación
        </div>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="titulo-confirmacion">Confirmar Acción</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="mensaje-confirmacion">¿Está seguro que desea realizar esta acción?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="btn-confirmar">Confirmar</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.colVis.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="script.js"></script>
</body>
</html>