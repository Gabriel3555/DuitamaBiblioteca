<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    // Procesar el formulario si se envió
    String mensaje = "";
    if (request.getParameter("submit") != null) {
        String tipo = request.getParameter("tipo");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String isbn = request.getParameter("isbn");

        if (tipo.equals("ficcion")) {
            String genero = request.getParameter("genero");
            String premios = request.getParameter("premios");
            Biblioteca.agregarLibro(new LibroFiccion(titulo, autor, isbn, genero, premios));
        } else if (tipo.equals("noFiccion")) {
            String areaTematica = request.getParameter("areaTematica");
            String publicoObjetivo = request.getParameter("publicoObjetivo");
            Biblioteca.agregarLibro(new LibroNoFiccion(titulo, autor, isbn, areaTematica, publicoObjetivo));
        } else if (tipo.equals("referencia")) {
            String campoAcademico = request.getParameter("campoAcademico");
            boolean prestable = request.getParameter("prestable") != null;
            Biblioteca.agregarLibro(new LibroReferencia(titulo, autor, isbn, campoAcademico, prestable));
        }

        mensaje = "Libro agregado exitosamente.";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Libro</title>
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
                <li class="nav-item">
                    <a class="nav-link active" href="agregarLibro.jsp">Agregar Libro</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center mb-4">Agregar Libro</h2>
    <% if (!mensaje.isEmpty()) { %>
    <script>
        Swal.fire({
            icon: 'success',
            title: '¡Éxito!',
            text: '<%= mensaje %>',
            confirmButtonText: 'Aceptar'
        });
    </script>
    <% } %>
    <form method="post" id="formLibro">
        <div class="mb-3">
            <label for="titulo" class="form-label">Título</label>
            <input type="text" class="form-control" id="titulo" name="titulo" required>
        </div>
        <div class="mb-3">
            <label for="autor" class="form-label">Autor</label>
            <input type="text" class="form-control" id="autor" name="autor" required>
        </div>
        <div class="mb-3">
            <label for="isbn" class="form-label">ISBN</label>
            <input type="text" class="form-control" id="isbn" name="isbn" required>
        </div>
        <div class="mb-3">
            <label for="tipo" class="form-label">Tipo de Libro</label>
            <select class="form-select" id="tipo" name="tipo" required>
                <option value="">Seleccione un tipo</option>
                <option value="ficcion">Ficción</option>
                <option value="noFiccion">No Ficción</option>
                <option value="referencia">Referencia</option>
            </select>
        </div>
        <div id="camposAdicionales"></div>
        <button type="submit" class="btn btn-primary" name="submit">Agregar Libro</button>
    </form>
</div>

<footer class="bg-primary text-white text-center py-3 mt-5">
    <p>&copy; 2025 Biblioteca Municipal de Duitama. Todos los derechos reservados.</p>
</footer>

<script>
    document.getElementById('tipo').addEventListener('change', function () {
        const tipo = this.value;
        const camposAdicionales = document.getElementById('camposAdicionales');
        camposAdicionales.innerHTML = '';

        if (tipo === 'ficcion') {
            camposAdicionales.innerHTML = `
                    <div class="mb-3">
                        <label for="genero" class="form-label">Género</label>
                        <input type="text" class="form-control" id="genero" name="genero" required>
                    </div>
                    <div class="mb-3">
                        <label for="premios" class="form-label">Premios Literarios</label>
                        <input type="text" class="form-control" id="premios" name="premios">
                    </div>
                `;
        } else if (tipo === 'noFiccion') {
            camposAdicionales.innerHTML = `
                    <div class="mb-3">
                        <label for="areaTematica" class="form-label">Área Temática</label>
                        <input type="text" class="form-control" id="areaTematica" name="areaTematica" required>
                    </div>
                    <div class="mb-3">
                        <label for="publicoObjetivo" class="form-label">Público Objetivo</label>
                        <input type="text" class="form-control" id="publicoObjetivo" name="publicoObjetivo" required>
                    </div>
                `;
        } else if (tipo === 'referencia') {
            camposAdicionales.innerHTML = `
                    <div class="mb-3">
                        <label for="campoAcademico" class="form-label">Campo Académico</label>
                        <input type="text" class="form-control" id="campoAcademico" name="campoAcademico" required>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="prestable" name="prestable">
                        <label class="form-check-label" for="prestable">¿Es prestable?</label>
                    </div>
                `;
        }
    });
</script>
</body>
</html>