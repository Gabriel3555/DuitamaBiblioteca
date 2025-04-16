<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    String mensaje = "";
    if (request.getParameter("submit") != null) {
        String isbn = request.getParameter("isbn");
        String fechaPrestamo = request.getParameter("fechaPrestamo");
        String fechaDevolucion = request.getParameter("fechaDevolucion");

        Libro libro = Biblioteca.buscarLibroPorISBN(isbn);
        if (libro != null) {
            Registro.agregarPrestamo(new Prestamo(isbn, libro.getTitulo(), fechaPrestamo, fechaDevolucion));
            mensaje = "Préstamo registrado exitosamente.";
        } else {
            mensaje = "No se encontró un libro con el ISBN proporcionado.";
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Préstamo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Registrar Préstamo</h2>
    <% if (!mensaje.isEmpty()) { %>
    <div class="alert alert-success"><%= mensaje %></div>
    <% } %>
    <form method="post">
        <div class="mb-3">
            <label for="isbn" class="form-label">ISBN del Libro</label>
            <input type="text" class="form-control" id="isbn" name="isbn" required>
        </div>
        <div class="mb-3">
            <label for="fechaPrestamo" class="form-label">Fecha de Préstamo</label>
            <input type="date" class="form-control" id="fechaPrestamo" name="fechaPrestamo" required>
        </div>
        <div class="mb-3">
            <label for="fechaDevolucion" class="form-label">Fecha de Devolución</label>
            <input type="date" class="form-control" id="fechaDevolucion" name="fechaDevolucion" required>
        </div>
        <button type="submit" class="btn btn-primary" name="submit">Registrar</button>
    </form>
</div>
</body>
</html>