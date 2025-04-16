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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<script>
  Swal.fire({
    icon: '<%= mensaje.contains("exitosamente") ? "success" : "error" %>',
    title: '<%= mensaje.contains("exitosamente") ? "¡Préstamo eliminado!" : "Error" %>',
    text: '<%= mensaje %>',
    confirmButtonText: '<i class="fas fa-check"></i> Aceptar',
    confirmButtonColor: '<%= mensaje.contains("exitosamente") ? "#2ecc71" : "#e74c3c" %>'
  }).then(() => {
    // Redirigir a la lista de préstamos después de mostrar el mensaje
    window.location.href = "listarPrestamos.jsp";
  });
</script>
</body>
</html>