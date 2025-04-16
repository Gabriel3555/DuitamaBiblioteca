<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    // Obtener el ISBN del libro a editar
    String isbn = request.getParameter("isbn");
    Libro libro = Biblioteca.buscarLibroPorISBN(isbn);
    String mensaje = "";

    if (libro == null) {
        mensaje = "No se encontró el libro con el ISBN proporcionado.";
    }

    // Procesar el formulario si se envió
    if (request.getParameter("submit") != null && libro != null) {
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");

        if (libro instanceof LibroFiccion) {
            String genero = request.getParameter("genero");
            String premios = request.getParameter("premios");
            LibroFiccion libroFiccion = (LibroFiccion) libro;
            libroFiccion.setTitulo(titulo);
            libroFiccion.setAutor(autor);
            libroFiccion.setGenero(genero);
            libroFiccion.setPremios(premios);
        } else if (libro instanceof LibroNoFiccion) {
            String areaTematica = request.getParameter("areaTematica");
            String publicoObjetivo = request.getParameter("publicoObjetivo");
            LibroNoFiccion libroNoFiccion = (LibroNoFiccion) libro;
            libroNoFiccion.setTitulo(titulo);
            libroNoFiccion.setAutor(autor);
            libroNoFiccion.setAreaTematica(areaTematica);
            libroNoFiccion.setPublicoObjetivo(publicoObjetivo);
        } else if (libro instanceof LibroReferencia) {
            String campoAcademico = request.getParameter("campoAcademico");
            boolean prestable = request.getParameter("prestable") != null;
            LibroReferencia libroReferencia = (LibroReferencia) libro;
            libroReferencia.setTitulo(titulo);
            libroReferencia.setAutor(autor);
            libroReferencia.setCampoAcademico(campoAcademico);
            libroReferencia.setPrestable(prestable);
        }

        mensaje = "Libro actualizado exitosamente.";
    }
%>

<jsp:include page="/resources/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2><i class="fas fa-edit"></i> Editar Libro</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item"><a href="listarLibros.jsp">Libros</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Editar Libro</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <% if (!mensaje.isEmpty()) { %>
    <script>
        Swal.fire({
            icon: '<%= mensaje.contains("exitosamente") ? "success" : "error" %>',
            title: '<%= mensaje.contains("exitosamente") ? "¡Libro actualizado!" : "Error" %>',
            text: '<%= mensaje %>',
            confirmButtonText: '<i class="fas fa-check"></i> Aceptar',
            confirmButtonColor: '<%= mensaje.contains("exitosamente") ? "#2ecc71" : "#e74c3c" %>'
        }).then(() => {
            <% if (mensaje.contains("exitosamente")) { %>
            window.location.href = "listarLibros.jsp";
            <% } %>
        });
    </script>
    <% } %>

    <% if (libro != null) { %>
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card shadow">
                <div class="card-header bg-warning text-white">
                    <h4 class="mb-0"><i class="fas fa-edit"></i> Editar Información del Libro</h4>
                </div>
                <div class="card-body">
                    <form method="post">
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-info-circle"></i> Información Básica</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="titulo" class="form-label">Título</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-heading"></i></span>
                                        <input type="text" class="form-control" id="titulo" name="titulo" value="<%= libro.getTitulo() %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="autor" class="form-label">Autor</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user-edit"></i></span>
                                        <input type="text" class="form-control" id="autor" name="autor" value="<%= libro.getAutor() %>" required>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="isbn" class="form-label">ISBN</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                                    <input type="text" class="form-control" id="isbn" name="isbn" value="<%= libro.getIsbn() %>" readonly>
                                </div>
                                <div class="form-text">El ISBN no se puede modificar</div>
                            </div>
                        </div>

                        <% if (libro instanceof LibroFiccion) { %>
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-book-open"></i> Detalles de Ficción</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="genero" class="form-label">Género</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-theater-masks"></i></span>
                                        <input type="text" class="form-control" id="genero" name="genero" value="<%= ((LibroFiccion) libro).getGenero() %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="premios" class="form-label">Premios Literarios</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-award"></i></span>
                                        <input type="text" class="form-control" id="premios" name="premios" value="<%= ((LibroFiccion) libro).getPremios() %>">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } else if (libro instanceof LibroNoFiccion) { %>
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-book-reader"></i> Detalles de No Ficción</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="areaTematica" class="form-label">Área Temática</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-tags"></i></span>
                                        <input type="text" class="form-control" id="areaTematica" name="areaTematica" value="<%= ((LibroNoFiccion) libro).getAreaTematica() %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="publicoObjetivo" class="form-label">Público Objetivo</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-users"></i></span>
                                        <input type="text" class="form-control" id="publicoObjetivo" name="publicoObjetivo" value="<%= ((LibroNoFiccion) libro).getPublicoObjetivo() %>" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } else if (libro instanceof LibroReferencia) { %>
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-university"></i> Detalles de Referencia</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="campoAcademico" class="form-label">Campo Académico</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-graduation-cap"></i></span>
                                        <input type="text" class="form-control" id="campoAcademico" name="campoAcademico" value="<%= ((LibroReferencia) libro).getCampoAcademico() %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="form-check mt-4">
                                        <input class="form-check-input" type="checkbox" id="prestable" name="prestable" <%= ((LibroReferencia) libro).isPrestable() ? "checked" : "" %>>
                                        <label class="form-check-label" for="prestable">
                                            <i class="fas fa-handshake"></i> ¿Es prestable?
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>

                        <div class="text-center">
                            <button type="submit" class="btn btn-warning btn-lg" name="submit">
                                <i class="fas fa-save"></i> Guardar Cambios
                            </button>
                            <a href="listarLibros.jsp" class="btn btn-secondary btn-lg ms-2">
                                <i class="fas fa-times"></i> Cancelar
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i> <%= mensaje %>
        <div class="mt-3">
            <a href="listarLibros.jsp" class="btn btn-primary">
                <i class="fas fa-arrow-left"></i> Volver a la lista de libros
            </a>
        </div>
    </div>
    <% } %>
</div>
<jsp:include page="bot.jsp"></jsp:include>
<jsp:include page="/resources/footer.jsp" />