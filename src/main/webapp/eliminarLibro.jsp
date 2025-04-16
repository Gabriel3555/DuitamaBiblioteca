<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    // Obtener el ISBN del libro a eliminar
    String isbn = request.getParameter("isbn");
    String mensaje = "";

    if (isbn != null) {
        boolean eliminado = Biblioteca.eliminarLibro(isbn);
        if (eliminado) {
            mensaje = "Libro eliminado exitosamente.";
        } else {
            mensaje = "No se encontró el libro con el ISBN proporcionado.";
        }
    } else {
        mensaje = "No se proporcionó un ISBN válido.";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Libro</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<script>
    Swal.fire({
        icon: '<%= mensaje.contains("exitosamente") ? "success" : "error" %>',
        title: '<%= mensaje.contains("exitosamente") ? "¡Éxito!" : "Error" %>',
        text: '<%= mensaje %>',
        confirmButtonText: 'Aceptar'
    }).then(() => {
        // Redirigir a la lista de libros después de mostrar el mensaje
        window.location.href = "listarLibros.jsp";
    });
</script>
</body>
</html>