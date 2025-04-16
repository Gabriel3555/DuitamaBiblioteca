<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Obtener la lista de préstamos
    ArrayList<Prestamo> prestamos = Registro.obtenerPrestamos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Préstamos</title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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
<div class="container mt-5">
    <h2 class="text-center mb-4">Lista de Préstamos</h2>
    <table id="tablaPrestamos" class="table table-striped table-bordered">
        <thead>
        <tr>
            <th>ISBN</th>
            <th>Título</th>
            <th>Fecha de Préstamo</th>
            <th>Fecha de Devolución</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% for (Prestamo prestamo : prestamos) { %>
        <tr>
            <td><%= prestamo.getIsbnLibro() %></td>
            <td><%= prestamo.getTituloLibro() %></td>
            <td><%= prestamo.getFechaPrestamo() %></td>
            <td><%= prestamo.getFechaDevolucion() %></td>
            <td>
                <a href="editarPrestamo.jsp?isbn=<%= prestamo.getIsbnLibro() %>" class="btn btn-warning btn-sm">
                    <i class="fas fa-edit"></i> Editar
                </a>
                <a href="eliminarPrestamo.jsp?isbn=<%= prestamo.getIsbnLibro() %>" class="btn btn-danger btn-sm">
                    <i class="fas fa-trash"></i> Eliminar
                </a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Scripts necesarios -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
<script>
    $(document).ready(function() {
        $('#tablaPrestamos').DataTable({
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    text: '<i class="fas fa-file-excel"></i> Exportar a Excel',
                    className: 'btn btn-excel' // Clase personalizada
                },
                {
                    extend: 'print',
                    text: '<i class="fas fa-print"></i> Imprimir',
                    className: 'btn btn-print' // Clase personalizada
                }
            ],
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.5/i18n/es-ES.json'
            }
        });
    });
</script>
</body>
</html>