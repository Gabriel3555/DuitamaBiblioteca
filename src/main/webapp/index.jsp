<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<!-- Home Section -->
<section id="inicio-section">
    <div class="row">
        <div class="col-md-6">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <h2 class="card-title">Bienvenido al Sistema de Gestión</h2>
                    <p class="card-text">Este sistema permite administrar el inventario de libros y gestionar préstamos de la Biblioteca Municipal.</p>
                    <div class="d-flex justify-content-between mt-4">
                        <a href="agregar.jsp" class="btn btn-primary" id="btn-ir-agregar">Agregar Libro</a>
                        <a href="prestamos.jsp" class="btn btn-success" id="btn-ir-prestamos">Gestionar Préstamos</a>
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

<%@ include file="footer.jsp" %>