<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    // Procesar el formulario cuando se envía
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String isbn = request.getParameter("libro-isbn");
        String titulo = request.getParameter("libro-titulo");
        String autor = request.getParameter("libro-autor");
        int anio = Integer.parseInt(request.getParameter("libro-anio"));
        String editorial = request.getParameter("libro-editorial");
        String tipo = request.getParameter("libro-tipo");
        String descripcion = request.getParameter("libro-descripcion");
        int copias = Integer.parseInt(request.getParameter("libro-copias"));
        String ubicacion = request.getParameter("libro-ubicacion");

        Libro libro = null;

        if ("ficcion".equals(tipo)) {
            String genero = request.getParameter("libro-genero");
            String premios = request.getParameter("libro-premios");
            String audiencia = request.getParameter("libro-audiencia");
            libro = new LibroFiccion(titulo, anio, genero, autor, premios);
        } else if ("no-ficcion".equals(tipo)) {
            String area = request.getParameter("libro-area");
            String publico = request.getParameter("libro-publico");
            libro = new LibroNoFiccion(titulo, anio, area, publico);
        } else if ("referencia".equals(tipo)) {
            String campo = request.getParameter("libro-campo");
            boolean soloConsulta = "No".equals(request.getParameter("libro-prestable"));
            libro = new LibroReferencia(titulo, anio, campo, soloConsulta);
        }

        if (libro != null) {
            Biblioteca.agregarLibro(libro);
            // Redirigir a la página de catálogo
            response.sendRedirect("catalogo.jsp");
        }
    }
%>
<%@ include file="header.jsp" %>

<!-- Add Book Section -->
<section id="agregar-section">
    <div class="card shadow-sm">
        <div class="card-body">
            <h2 class="card-title mb-4">Agregar Nuevo Libro</h2>

            <form id="formulario-libro" method="post" action="agregar.jsp">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="libro-isbn" class="form-label">ISBN</label>
                        <input type="text" class="form-control" id="libro-isbn" name="libro-isbn" required>
                        <div class="invalid-feedback">El ISBN es obligatorio</div>
                    </div>
                    <div class="col-md-6">
                        <label for="libro-tipo" class="form-label">Tipo de Libro</label>
                        <select class="form-select" id="libro-tipo" name="libro-tipo" required>
                            <option value="" selected disabled>Seleccionar tipo...</option>
                            <option value="ficcion">Ficción</option>
                            <option value="no-ficcion">No Ficción</option>
                            <option value="referencia">Referencia</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-8">
                        <label for="libro-titulo" class="form-label">Título</label>
                        <input type="text" class="form-control" id="libro-titulo" name="libro-titulo" required>
                        <div class="invalid-feedback">El título es obligatorio</div>
                    </div>
                    <div class="col-md-4">
                        <label for="libro-anio" class="form-label">Año de Publicación</label>
                        <input type="number" class="form-control" id="libro-anio" name="libro-anio" min="1000" max="2099" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="libro-autor" class="form-label">Autor</label>
                        <input type="text" class="form-control" id="libro-autor" name="libro-autor" required>
                    </div>
                    <div class="col-md-6">
                        <label for="libro-editorial" class="form-label">Editorial</label>
                        <input type="text" class="form-control" id="libro-editorial" name="libro-editorial" required>
                    </div>
                </div>

                <!-- Dynamic fields based on book type -->
                <div id="campos-dinamicos" class="mb-3">
                    <!-- Fields will be added dynamically via JavaScript -->
                </div>

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
                    <button type="button" class="btn btn-secondary me-2" id="btn-limpiar-formulario">Limpiar</button>
                    <button type="submit" class="btn btn-primary">Guardar Libro</button>
                </div>
            </form>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>