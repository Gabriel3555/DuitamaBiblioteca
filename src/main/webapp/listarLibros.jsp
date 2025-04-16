<%@ page import="com.app.duitamabiblioteca.modelo.Libro" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.duitamabiblioteca.modelo.Biblioteca" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Obtener la lista de libros desde la clase Biblioteca
    ArrayList<Libro> libros = Biblioteca.obtenerLibros();
%>

<jsp:include page="/resources/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2><i class="fas fa-book"></i> Catálogo de Libros</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Libros</li>
                    </ol>
                </nav>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="agregarLibro.jsp" class="btn btn-success">
                    <i class="fas fa-plus-circle"></i> Agregar Nuevo Libro
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Filtros -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title"><i class="fas fa-filter"></i> Filtros</h5>
            <div class="row">
                <div class="col-md-4">
                    <label for="filtroAutor" class="form-label">Filtrar por Autor</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" id="filtroAutor" class="form-control" placeholder="Nombre del autor">
                    </div>
                </div>
                <div class="col-md-4">
                    <label for="filtroTitulo" class="form-label">Filtrar por Título</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-heading"></i></span>
                        <input type="text" id="filtroTitulo" class="form-control" placeholder="Título del libro">
                    </div>
                </div>
                <div class="col-md-4">
                    <label for="filtroISBN" class="form-label">Filtrar por ISBN</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                        <input type="text" id="filtroISBN" class="form-control" placeholder="Código ISBN">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabla de Libros -->
    <div class="card">
        <div class="card-body">
            <table id="tablaLibros" class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>Título</th>
                    <th>Autor</th>
                    <th>ISBN</th>
                    <th>Detalles</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <% for (Libro libro : libros) { %>
                <tr>
                    <td><strong><%= libro.getTitulo() %></strong></td>
                    <td><%= libro.getAutor() %></td>
                    <td><span class="badge bg-secondary"><%= libro.getIsbn() %></span></td>
                    <td><%= libro.getDetalles() %></td>
                    <td>
                        <div class="btn-group" role="group">
                            <a href="editarLibro.jsp?isbn=<%= libro.getIsbn() %>" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit"></i> Editar
                            </a>
                            <button class="btn btn-danger btn-sm" onclick="confirmarEliminacion('<%= libro.getIsbn() %>')">
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
        // Inicializar DataTable
        var table = $('#tablaLibros').DataTable({
            dom: '<"row"<"col-md-6"B><"col-md-6"f>>rtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: '<i class="fas fa-file-excel"></i> Exportar a Excel',
                    className: 'btn btn-excel',
                    exportOptions: {
                        columns: [0, 1, 2, 3]
                    }
                },
                {
                    extend: 'print',
                    text: '<i class="fas fa-print"></i> Imprimir',
                    className: 'btn btn-print',
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

        // Filtros personalizados
        $('#filtroAutor').on('keyup', function() {
            table.column(1).search(this.value).draw();
        });

        $('#filtroTitulo').on('keyup', function() {
            table.column(0).search(this.value).draw();
        });

        $('#filtroISBN').on('keyup', function() {
            table.column(2).search(this.value).draw();
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
                window.location.href = 'eliminarLibro.jsp?isbn=' + isbn;
            }
        });
    }
</script>
<jsp:include page="bot.jsp"></jsp:include>
<jsp:include page="/resources/footer.jsp" />