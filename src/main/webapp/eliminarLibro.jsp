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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<script>
    Swal.fire({
        icon: '<%= mensaje.contains("exitosamente") ? "success" : "error" %>',
        title: '<%= mensaje.contains("exitosamente") ? "¡Libro eliminado!" : "Error" %>',
        text: '<%= mensaje %>',
        confirmButtonText: '<i class="fas fa-check"></i> Aceptar',
        confirmButtonColor: '<%= mensaje.contains("exitosamente") ? "#2ecc71" : "#e74c3c" %>'
    }).then(() => {
        // Redirigir a la lista de libros después de mostrar el mensaje
        window.location.href = "listarLibros.jsp";
    });
</script>
</body>
</html>
