<%@ page import="com.app.duitamabiblioteca.modelo.Libro" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.duitamabiblioteca.modelo.Biblioteca" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Obtener la lista de libros desde la clase Biblioteca
    ArrayList<Libro> libros = Biblioteca.obtenerLibros();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Libros</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Estilo para los botones de acción */
        .btn-editar {
            background-color: #ffc107 !important;
            color: white !important;
            border: none !important;
        }
        .btn-editar:hover {
            background-color: #e0a800 !important;
            color: white !important;
        }
        .btn-eliminar {
            background-color: #dc3545 !important;
            color: white !important;
            border: none !important;
        }
        .btn-eliminar:hover {
            background-color: #c82333 !important;
            color: white !important;
        }
        /* Estilo para la tabla */
        table.dataTable thead {
            background-color: #343a40;
            color: white;
        }

        /* Estilo personalizado para los botones de exportación */
        .btn-excel {
            background-color: #28a745 !important;
            color: white !important;
            border: none !important;
        }
        .btn-excel:hover {
            background-color: #218838 !important;
            color: white !important;
        }
        .btn-print {
            background-color: #007bff !important;
            color: white !important;
            border: none !important;
        }
        .btn-print:hover {
            background-color: #0056b3 !important;
            color: white !important;
        }
    </style>
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
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="listarLibros.jsp">Listar Libros</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="agregarLibro.jsp">Agregar Libro</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">Lista de Libros</h2>

    <!-- Menú de filtros -->
    <div class="row mb-3">
        <div class="col-md-4">
            <label for="filtroAutor" class="form-label">Filtrar por Autor</label>
            <input type="text" id="filtroAutor" class="form-control" placeholder="Escribe el nombre del autor">
        </div>
    </div>

    <table id="tablaLibros" class="table table-striped table-bordered">
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
            <td><%= libro.getTitulo() %></td>
            <td><%= libro.getAutor() %></td>
            <td><%= libro.getIsbn() %></td>
            <td><%= libro.getDetalles() %></td>
            <td>
                <!-- Botón Editar -->
                <a href="editarLibro.jsp?isbn=<%= libro.getIsbn() %>" class="btn btn-editar btn-sm">
                    <i class="fas fa-edit"></i> Editar
                </a>
                <!-- Botón Eliminar -->
                <button class="btn btn-eliminar btn-sm" onclick="confirmarEliminacion('<%= libro.getIsbn() %>')">
                    <i class="fas fa-trash"></i> Eliminar
                </button>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<footer class="bg-primary text-white text-center py-3 mt-5">
    <p>&copy; 2025 Biblioteca Municipal de Duitama. Todos los derechos reservados.</p>
</footer>

<!-- Scripts necesarios -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function() {
        // Inicializar DataTable
        var table = $('#tablaLibros').DataTable({
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: '<i class="fas fa-file-excel"></i> Exportar a Excel',
                    className: 'btn btn-excel'
                },
                {
                    extend: 'print',
                    text: '<i class="fas fa-print"></i> Imprimir',
                    className: 'btn btn-print'
                }
            ],
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.5/i18n/es-ES.json'
            }
        });

        // Filtro por autor
        $('#filtroAutor').on('keyup', function() {
            var autor = $(this).val();
            table.column(1).search(autor).draw();
        });
    });

    // Confirmar eliminación con SweetAlert
    function confirmarEliminacion(isbn) {
        Swal.fire({
            title: '¿Estás seguro?',
            text: "Esta acción no se puede deshacer.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirigir a la página de eliminación
                window.location.href = 'eliminarLibro.jsp?isbn=' + isbn;
            }
        });
    }
</script>
</body>
</html>