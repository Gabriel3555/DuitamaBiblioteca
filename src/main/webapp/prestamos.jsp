<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<!-- Loans Section -->
<section id="prestamos-section">
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

<%@ include file="footer.jsp" %>