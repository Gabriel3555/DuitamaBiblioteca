<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    // Obtener el ISBN del préstamo a editar
    String isbn = request.getParameter("isbn");
    Prestamo prestamo = Registro.buscarPrestamoPorISBN(isbn);
    String mensaje = "";

    if (prestamo == null) {
        mensaje = "No se encontró el préstamo con el ISBN proporcionado.";
    }

    // Procesar el formulario si se envió
    if (request.getParameter("submit") != null && prestamo != null) {
        String fechaPrestamo = request.getParameter("fechaPrestamo");
        String fechaDevolucion = request.getParameter("fechaDevolucion");

        prestamo.setFechaPrestamo(fechaPrestamo);
        prestamo.setFechaDevolucion(fechaDevolucion);

        mensaje = "Préstamo actualizado exitosamente.";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Préstamo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Editar Préstamo</h2>
    <% if (!mensaje.isEmpty()) { %>
    <script>
        Swal.fire({
            icon: '<%= mensaje.contains("exitosamente") ? "success" : "error" %>',
            title: '<%= mensaje.contains("exitosamente") ? "¡Éxito!" : "Error" %>',
            text: '<%= mensaje %>',
            confirmButtonText: 'Aceptar'
        }).then(() => {
            <% if (mensaje.contains("exitosamente")) { %>
            window.location.href = "listarPrestamos.jsp";
            <% } %>
        });
    </script>
    <% } %>
    <% if (prestamo != null) { %>
    <form method="post">
        <div class="mb-3">
            <label for="isbn" class="form-label">ISBN del Libro</label>
            <input type="text" class="form-control" id="isbn" name="isbn" value="<%= prestamo.getIsbnLibro() %>" readonly>
        </div>
        <div class="mb-3">
            <label for="titulo" class="form-label">Título del Libro</label>
            <input type="text" class="form-control" id="titulo" name="titulo" value="<%= prestamo.getTituloLibro() %>" readonly>
        </div>
        <div class="mb-3">
            <label for="fechaPrestamo" class="form-label">Fecha de Préstamo</label>
            <input type="date" class="form-control" id="fechaPrestamo" name="fechaPrestamo" value="<%= prestamo.getFechaPrestamo() %>" required>
        </div>
        <div class="mb-3">
            <label for="fechaDevolucion" class="form-label">Fecha de Devolución</label>
            <input type="date" class="form-control" id="fechaDevolucion" name="fechaDevolucion" value="<%= prestamo.getFechaDevolucion() %>" required>
        </div>
        <button type="submit" class="btn btn-primary" name="submit">Guardar Cambios</button>
    </form>
    <% } %>
</div>
</body>
</html>