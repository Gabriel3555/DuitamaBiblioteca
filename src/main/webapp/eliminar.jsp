<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
  // Obtener el ID del libro a eliminar
  String idStr = request.getParameter("id");
  int id = 0;

  try {
    id = Integer.parseInt(idStr);
  } catch (NumberFormatException e) {
    // Manejar error de formato
    response.sendRedirect("catalogo.jsp");
    return;
  }

  // Verificar si se debe confirmar la eliminación
  String confirmar = request.getParameter("confirmar");

  if ("si".equals(confirmar)) {
    // Eliminar el libro
    Biblioteca.eliminarLibro(id);

    // Redirigir a la página de catálogo
    response.sendRedirect("catalogo.jsp");
    return;
  }

  // Buscar el libro por ID
  Libro libro = Biblioteca.buscarPorId(id);

  if (libro == null) {
    // Libro no encontrado
    response.sendRedirect("catalogo.jsp");
    return;
  }
%>
<%@ include file="header.jsp" %>

<!-- Delete Book Section -->
<section id="eliminar-section">
  <div class="card shadow-sm">
    <div class="card-body">
      <h2 class="card-title mb-4">Eliminar Libro</h2>

      <div class="alert alert-danger">
        <h4 class="alert-heading">¿Está seguro que desea eliminar este libro?</h4>
        <p>Esta acción no se puede deshacer.</p>
        <hr>
        <p class="mb-0">
          <strong>Título:</strong> <%= libro.getTitulo() %><br>
          <strong>Año:</strong> <%= libro.getAnio() %><br>
          <strong>Tipo:</strong> <%= libro.getTipo() %>
        </p>
      </div>

      <div class="d-flex justify-content-end mt-4">
        <a href="catalogo.jsp" class="btn btn-secondary me-2">Cancelar</a>
        <a href="eliminar.jsp?id=<%= libro.getId() %>&confirmar=si" class="btn btn-danger">Confirmar Eliminación</a>
      </div>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>