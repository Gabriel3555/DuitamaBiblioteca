<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
  // Obtener el ID del libro a editar
  String idStr = request.getParameter("id");
  int id = 0;

  try {
    id = Integer.parseInt(idStr);
  } catch (NumberFormatException e) {
    // Manejar error de formato
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

  // Procesar el formulario cuando se envía
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String titulo = request.getParameter("libro-titulo");
    int anio = Integer.parseInt(request.getParameter("libro-anio"));
    String autor = request.getParameter("libro-autor");
    String editorial = request.getParameter("libro-editorial");
    String descripcion = request.getParameter("libro-descripcion");
    int copias = Integer.parseInt(request.getParameter("libro-copias"));
    String ubicacion = request.getParameter("libro-ubicacion");

    // Actualizar propiedades comunes
    libro.setTitulo(titulo);
    libro.setAnio(anio);

    // Actualizar propiedades específicas según el tipo de libro
    if (libro instanceof LibroFiccion) {
      LibroFiccion libroFiccion = (LibroFiccion) libro;
      libroFiccion.setAutor(autor);
      libroFiccion.setGenero(request.getParameter("libro-genero"));
      libroFiccion.setPremiosLiterarios(request.getParameter("libro-premios"));
    } else if (libro instanceof LibroNoFiccion) {
      LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libro;
      libroNoFiccion.setAreaTematica(request.getParameter("libro-area"));
      libroNoFiccion.setPublicoObjetivo(request.getParameter("libro-publico"));
    } else if (libro instanceof LibroReferencia) {
      LibroReferencia libroReferencia = (LibroReferencia) libro;
      libroReferencia.setCampoAcademico(request.getParameter("libro-campo"));
      libroReferencia.setSoloConsulta("No".equals(request.getParameter("libro-prestable")));
    }

    // Actualizar el libro en la biblioteca
    Biblioteca.actualizarLibro(libro);

    // Redirigir a la página de catálogo
    response.sendRedirect("catalogo.jsp");
    return;
  }

  // Determinar el tipo de libro
  String tipoLibro = "";
  if (libro instanceof LibroFiccion) {
    tipoLibro = "ficcion";
  } else if (libro instanceof LibroNoFiccion) {
    tipoLibro = "no-ficcion";
  } else if (libro instanceof LibroReferencia) {
    tipoLibro = "referencia";
  }
%>
<%@ include file="header.jsp" %>

<!-- Edit Book Section -->
<section id="editar-section">
  <div class="card shadow-sm">
    <div class="card-body">
      <h2 class="card-title mb-4">Editar Libro</h2>

      <form id="formulario-editar" method="post" action="editar.jsp?id=<%= libro.getId() %>">
        <input type="hidden" name="id" value="<%= libro.getId() %>">

        <div class="row mb-3">
          <div class="col-md-8">
            <label for="libro-titulo" class="form-label">Título</label>
            <input type="text" class="form-control" id="libro-titulo" name="libro-titulo" value="<%= libro.getTitulo() %>" required>
          </div>
          <div class="col-md-4">
            <label for="libro-anio" class="form-label">Año de Publicación</label>
            <input type="number" class="form-control" id="libro-anio" name="libro-anio" min="1000" max="2099" value="<%= libro.getAnio() %>" required>
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="libro-autor" class="form-label">Autor</label>
            <input type="text" class="form-control" id="libro-autor" name="libro-autor" value="<%= libro instanceof LibroFiccion ? ((LibroFiccion)libro).getAutor() : "" %>" required>
          </div>
          <div class="col-md-6">
            <label for="libro-editorial" class="form-label">Editorial</label>
            <input type="text" class="form-control" id="libro-editorial" name="libro-editorial" required>
          </div>
        </div>

        <!-- Campos específicos según el tipo de libro -->
        <% if (libro instanceof LibroFiccion) {
          LibroFiccion libroFiccion = (LibroFiccion) libro;
        %>
        <div class="row mb-3">
          <div class="col-md-4">
            <label for="libro-genero" class="form-label">Género</label>
            <input type="text" class="form-control" id="libro-genero" name="libro-genero" value="<%= libroFiccion.getGenero() %>">
          </div>
          <div class="col-md-4">
            <label for="libro-premios" class="form-label">Premios</label>
            <input type="text" class="form-control" id="libro-premios" name="libro-premios" value="<%= libroFiccion.getPremiosLiterarios() %>">
          </div>
          <div class="col-md-4">
            <label for="libro-audiencia" class="form-label">Audiencia</label>
            <select class="form-select" id="libro-audiencia" name="libro-audiencia">
              <option value="Niños">Niños</option>
              <option value="Jóvenes">Jóvenes</option>
              <option value="Adultos">Adultos</option>
              <option value="Todas las edades">Todas las edades</option>
            </select>
          </div>
        </div>
        <% } else if (libro instanceof LibroNoFiccion) {
          LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libro;
        %>
        <div class="row mb-3">
          <div class="col-md-4">
            <label for="libro-area" class="form-label">Área Temática</label>
            <input type="text" class="form-control" id="libro-area" name="libro-area" value="<%= libroNoFiccion.getAreaTematica() %>">
          </div>
          <div class="col-md-4">
            <label for="libro-publico" class="form-label">Público Objetivo</label>
            <input type="text" class="form-control" id="libro-publico" name="libro-publico" value="<%= libroNoFiccion.getPublicoObjetivo() %>">
          </div>
          <div class="col-md-4">
            <label for="libro-nivel" class="form-label">Nivel</label>
            <select class="form-select" id="libro-nivel" name="libro-nivel">
              <option value="Básico">Básico</option>
              <option value="Intermedio">Intermedio</option>
              <option value="Avanzado">Avanzado</option>
            </select>
          </div>
        </div>
        <% } else if (libro instanceof LibroReferencia) {
          LibroReferencia libroReferencia = (LibroReferencia) libro;
        %>
        <div class="row mb-3">
          <div class="col-md-4">
            <label for="libro-campo" class="form-label">Campo Académico</label>
            <input type="text" class="form-control" id="libro-campo" name="libro-campo" value="<%= libroReferencia.getCampoAcademico() %>">
          </div>
          <div class="col-md-4">
            <label for="libro-prestable" class="form-label">¿Puede ser prestado?</label>
            <select class="form-select" id="libro-prestable" name="libro-prestable">
              <option value="Sí" <%= !libroReferencia.isSoloConsulta() ? "selected" : "" %>>Sí</option>
              <option value="No" <%= libroReferencia.isSoloConsulta() ? "selected" : "" %>>No</option>
            </select>
          </div>
          <div class="col-md-4">
            <label for="libro-edicion" class="form-label">Edición</label>
            <input type="text" class="form-control" id="libro-edicion" name="libro-edicion">
          </div>
        </div>
        <% } %>

        <div class="row mb-3">
          <div class="col-md-12">
            <label for="libro-descripcion" class="form-label">Descripción</label>
            <textarea class="form-control" id="libro-descripcion" name="libro-descripcion" rows="3"></textarea>
          </div>
        </div>

        <div class="row mb-3">
          <div class="col-md-4">
            <label for="libro-copias" class="form-label">Número de Copias</label>
            <input type="number" class="form-control" id="libro-copias" name="libro-copias" min="1" value="1" required>
          </div>
          <div class="col-md-4">
            <label for="libro-ubicacion" class="form-label">Ubicación</label>
            <input type="text" class="form-control" id="libro-ubicacion" name="libro-ubicacion" placeholder="Ej: Estante A-12" required>
          </div>
          <div class="col-md-4">
            <label for="libro-portada" class="form-label">Imagen de Portada</label>
            <input type="file" class="form-control" id="libro-portada" name="libro-portada" accept="image/*">
          </div>
        </div>

        <div class="d-flex justify-content-end mt-4">
          <a href="catalogo.jsp" class="btn btn-secondary me-2">Cancelar</a>
          <button type="submit" class="btn btn-primary">Guardar Cambios</button>
        </div>
      </form>
    </div>
  </div>
</section>

<%@ include file="footer.jsp" %>