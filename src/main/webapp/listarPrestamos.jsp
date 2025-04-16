<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Obtener la lista de préstamos
    ArrayList<Prestamo> prestamos = Registro.obtenerPrestamos();
%>

<jsp:include page="/resources/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2><i class="fas fa-handshake"></i> Gestión de Préstamos</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Préstamos</li>
                    </ol>
                </nav>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="registrarPrestamo.jsp" class="btn btn-success">
                    <i class="fas fa-plus-circle"></i> Registrar Nuevo Préstamo
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Estadísticas -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white">
                <div class="card-body text-center">
                    <i class="fas fa-book fa-3x mb-3"></i>
                    <h5 class="card-title">Total Préstamos</h5>
                    <p class="card-text display-6"><%= prestamos.size() %></p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white">
                <div class="card-body text-center">
                    <i class="fas fa-check-circle fa-3x mb-3"></i>
                    <h5 class="card-title">Activos</h5>
                    <p class="card-text display-6">
                        <%= prestamos.stream().filter(p -> {
                            try {
                                return java.time.LocalDate.parse(p.getFechaDevolucion()).isAfter(java.time.LocalDate.now());
                            } catch (Exception e) {
                                return false;
                            }
                        }).count() %>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-warning text-white">
                <div class="card-body text-center">
                    <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                    <h5 class="card-title">Por Vencer</h5>
                    <p class="card-text display-6">
                        <%= prestamos.stream().filter(p -> {
                            try {
                                java.time.LocalDate fechaDevolucion = java.time.LocalDate.parse(p.getFechaDevolucion());
                                return fechaDevolucion.isAfter(java.time.LocalDate.now()) &&
                                        fechaDevolucion.isBefore(java.time.LocalDate.now().plusDays(3));
                            } catch (Exception e) {
                                return false;
                            }
                        }).count() %>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-danger text-white">
                <div class="card-body text-center">
                    <i class="fas fa-clock fa-3x mb-3"></i>
                    <h5 class="card-title">Vencidos</h5>
                    <p class="card-text display-6">
                        <%= prestamos.stream().filter(p -> {
                            try {
                                return java.time.LocalDate.parse(p.getFechaDevolucion()).isBefore(java.time.LocalDate.now());
                            } catch (Exception e) {
                                return false;
                            }
                        }).count() %>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabla de Préstamos -->
    <div class="card">
        <div class="card-body">
            <table id="tablaPrestamos" class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>ISBN</th>
                    <th>Título</th>
                    <th>Fecha de Préstamo</th>
                    <th>Fecha de Devolución</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <% for (Prestamo prestamo : prestamos) {
                    String estado = "";
                    String badgeClass = "";
                    try {
                        java.time.LocalDate fechaDevolucion = java.time.LocalDate.parse(prestamo.getFechaDevolucion());
                        if (fechaDevolucion.isBefore(java.time.LocalDate.now())) {
                            estado = "Vencido";
                            badgeClass = "bg-danger";
                        } else if (fechaDevolucion.isBefore(java.time.LocalDate.now().plusDays(3))) {
                            estado = "Por vencer";
                            badgeClass = "bg-warning";
                        } else {
                            estado = "Activo";
                            badgeClass = "bg-success";
                        }
                    } catch (Exception e) {
                        estado = "Error en fecha";
                        badgeClass = "bg-secondary";
                    }
                %>
                <tr>
                    <td><span class="badge bg-secondary"><%= prestamo.getIsbnLibro() %></span></td>
                    <td><strong><%= prestamo.getTituloLibro() %></strong></td>
                    <td><i class="fas fa-calendar-plus text-primary"></i> <%= prestamo.getFechaPrestamo() %></td>
                    <td><i class="fas fa-calendar-check text-info"></i> <%= prestamo.getFechaDevolucion() %></td>
                    <td><span class="badge <%= badgeClass %>"><%= estado %></span></td>
                    <td>
                        <div class="btn-group" role="group">
                            <a href="editarPrestamo.jsp?isbn=<%= prestamo.getIsbnLibro() %>" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Editar
                            </a>
                            <button class="btn btn-danger btn-sm" onclick="confirmarEliminacion('<%= prestamo.getIsbnLibro() %>')">
                                <i class="fas fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        var table = $('#tablaLibros').DataTable({
            dom: '<"row"<"col-md-6"B><"col-md-6"f>>rtip',
            buttons: [
                {
                    extend: 'pdfHtml5',
                    text: '<i class="fas fa-file-pdf"></i> Exportar a PDF',
                    className: 'btn btn-soft-danger me-2',
                    exportOptions: {
                        columns: [0, 1, 2, 3]
                    },
                    customize: function(doc) {
                        doc.defaultStyle.fontSize = 10;
                        doc.styles.tableHeader.fontSize = 11;
                        doc.styles.tableHeader.alignment = 'left';
                        doc.content[1].table.widths = ['*', '*', '*', '*'];
                    }
                },
                {
                    extend: 'excelHtml5',
                    text: '<i class="fas fa-file-excel"></i> Exportar a Excel',
                    className: 'btn btn-soft-success me-2',
                    exportOptions: {
                        columns: [0, 1, 2, 3]
                    }
                },
                {
                    extend: 'print',
                    text: '<i class="fas fa-print"></i> Imprimir',
                    className: 'btn btn-soft-info',
                    exportOptions: {
                        columns: [0, 1, 2, 3]
                    }
                }
            ],
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.5/i18n/es-ES.json'
            },
            responsive: true
        });
    });

    // Confirmar eliminación con SweetAlert
    function confirmarEliminacion(isbn) {
        Swal.fire({
            title: '¿Estás seguro?',
            text: "Esta acción no se puede deshacer.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#e74c3c',
            cancelButtonColor: '#3498db',
            confirmButtonText: '<i class="fas fa-trash"></i> Sí, eliminar',
            cancelButtonText: '<i class="fas fa-times"></i> Cancelar',
            backdrop: `rgba(0,0,0,0.4)`
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'eliminarPrestamo.jsp?isbn=' + isbn;
            }
        });
    }
</script>
<jsp:include page="bot.jsp"></jsp:include>
<jsp:include page="/resources/footer.jsp" />