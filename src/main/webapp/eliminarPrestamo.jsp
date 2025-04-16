<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
  // Obtener el ISBN del préstamo a eliminar
  String isbn = request.getParameter("isbn");
  String mensaje = "";

  if (isbn != null) {
    boolean eliminado = Registro.eliminarPrestamo(isbn);
    if (eliminado) {
      mensaje = "Préstamo eliminado exitosamente.";
    } else {
      mensaje = "No se encontró el préstamo con el ISBN proporcionado.";
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
  <title>Eliminar Préstamo</title>
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
    // Redirigir a la lista de préstamos después de mostrar el mensaje
    window.location.href = "listarPrestamos.jsp";
  });
</script>
</body>
</html>