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
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Libro</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Biblioteca Municipal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="listarLibros.jsp">Listar Libros</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">Editar Libro</h2>
    <% if (!mensaje.isEmpty()) { %>
    <script>
        Swal.fire({
            icon: '<%= mensaje.contains("exitosamente") ? "success" : "error" %>',
            title: '<%= mensaje.contains("exitosamente") ? "¡Éxito!" : "Error" %>',
            text: '<%= mensaje %>',
            confirmButtonText: 'Aceptar'
        }).then(() => {
            <% if (mensaje.contains("exitosamente")) { %>
            window.location.href = "listarLibros.jsp";
            <% } %>
        });
    </script>
    <% } %>
    <% if (libro != null) { %>
    <form method="post">
        <div class="mb-3">
            <label for="titulo" class="form-label">Título</label>
            <input type="text" class="form-control" id="titulo" name="titulo" value="<%= libro.getTitulo() %>" required>
        </div>
        <div class="mb-3">
            <label for="autor" class="form-label">Autor</label>
            <input type="text" class="form-control" id="autor" name="autor" value="<%= libro.getAutor() %>" required>
        </div>
        <% if (libro instanceof LibroFiccion) { %>
        <div class="mb-3">
            <label for="genero" class="form-label">Género</label>
            <input type="text" class="form-control" id="genero" name="genero" value="<%= ((LibroFiccion) libro).getGenero() %>" required>
        </div>
        <div class="mb-3">
            <label for="premios" class="form-label">Premios Literarios</label>
            <input type="text" class="form-control" id="premios" name="premios" value="<%= ((LibroFiccion) libro).getPremios() %>">
        </div>
        <% } else if (libro instanceof LibroNoFiccion) { %>
        <div class="mb-3">
            <label for="areaTematica" class="form-label">Área Temática</label>
            <input type="text" class="form-control" id="areaTematica" name="areaTematica" value="<%= ((LibroNoFiccion) libro).getAreaTematica() %>" required>
        </div>
        <div class="mb-3">
            <label for="publicoObjetivo" class="form-label">Público Objetivo</label>
            <input type="text" class="form-control" id="publicoObjetivo" name="publicoObjetivo" value="<%= ((LibroNoFiccion) libro).getPublicoObjetivo() %>" required>
        </div>
        <% } else if (libro instanceof LibroReferencia) { %>
        <div class="mb-3">
            <label for="campoAcademico" class="form-label">Campo Académico</label>
            <input type="text" class="form-control" id="campoAcademico" name="campoAcademico" value="<%= ((LibroReferencia) libro).getCampoAcademico() %>" required>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="prestable" name="prestable" <%= ((LibroReferencia) libro).isPrestable() ? "checked" : "" %>>
            <label class="form-check-label" for="prestable">¿Es prestable?</label>
        </div>
        <% } %>
        <button type="submit" class="btn btn-primary" name="submit">Guardar Cambios</button>
    </form>
    <% } %>
</div>

<footer class="bg-primary text-white text-center py-3 mt-5">
    <p>&copy; 2025 Biblioteca Municipal de Duitama. Todos los derechos reservados.</p>
</footer>
</body>
</html>