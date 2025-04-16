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

<jsp:include page="resources/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2><i class="fas fa-plus-circle"></i> Agregar Nuevo Libro</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item"><a href="listarLibros.jsp">Libros</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Agregar Libro</li>
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
            icon: 'success',
            title: '¡Libro agregado!',
            text: '<%= mensaje %>',
            confirmButtonText: '<i class="fas fa-check"></i> Aceptar',
            confirmButtonColor: '#2ecc71'
        }).then(() => {
            // Limpiar el formulario después de agregar
            document.getElementById('formLibro').reset();
            document.getElementById('camposAdicionales').innerHTML = '';
        });
    </script>
    <% } %>

    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="fas fa-book"></i> Información del Libro</h4>
                </div>
                <div class="card-body">
                    <form method="post" id="formLibro">
                        <!-- Información básica -->
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-info-circle"></i> Información Básica</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="titulo" class="form-label">Título</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-heading"></i></span>
                                        <input type="text" class="form-control" id="titulo" name="titulo" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="autor" class="form-label">Autor</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user-edit"></i></span>
                                        <input type="text" class="form-control" id="autor" name="autor" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="isbn" class="form-label">ISBN</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                                        <input type="text" class="form-control" id="isbn" name="isbn" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="tipo" class="form-label">Tipo de Libro</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-bookmark"></i></span>
                                        <select class="form-select" id="tipo" name="tipo" required>
                                            <option value="">Seleccione un tipo</option>
                                            <option value="ficcion">Ficción</option>
                                            <option value="noFiccion">No Ficción</option>
                                            <option value="referencia">Referencia</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Campos adicionales según el tipo -->
                        <div id="camposAdicionales" class="mb-4"></div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary btn-lg" name="submit">
                                <i class="fas fa-save"></i> Guardar Libro
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
</div>

<script>
    document.getElementById('tipo').addEventListener('change', function () {
        const tipo = this.value;
        const camposAdicionales = document.getElementById('camposAdicionales');
        camposAdicionales.innerHTML = '';

        if (tipo === 'ficcion') {
            camposAdicionales.innerHTML = `
                <h5 class="border-bottom pb-2"><i class="fas fa-book-open"></i> Detalles de Ficción</h5>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="genero" class="form-label">Género</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-theater-masks"></i></span>
                            <input type="text" class="form-control" id="genero" name="genero" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="premios" class="form-label">Premios Literarios</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-award"></i></span>
                            <input type="text" class="form-control" id="premios" name="premios">
                        </div>
                    </div>
                </div>
            `;
        } else if (tipo === 'noFiccion') {
            camposAdicionales.innerHTML = `
                <h5 class="border-bottom pb-2"><i class="fas fa-book-reader"></i> Detalles de No Ficción</h5>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="areaTematica" class="form-label">Área Temática</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-tags"></i></span>
                            <input type="text" class="form-control" id="areaTematica" name="areaTematica" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="publicoObjetivo" class="form-label">Público Objetivo</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-users"></i></span>
                            <input type="text" class="form-control" id="publicoObjetivo" name="publicoObjetivo" required>
                        </div>
                    </div>
                </div>
            `;
        } else if (tipo === 'referencia') {
            camposAdicionales.innerHTML = `
                <h5 class="border-bottom pb-2"><i class="fas fa-university"></i> Detalles de Referencia</h5>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="campoAcademico" class="form-label">Campo Académico</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-graduation-cap"></i></span>
                            <input type="text" class="form-control" id="campoAcademico" name="campoAcademico" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="form-check mt-4">
                            <input class="form-check-input" type="checkbox" id="prestable" name="prestable">
                            <label class="form-check-label" for="prestable">
                                <i class="fas fa-handshake"></i> ¿Es prestable?
                            </label>
                        </div>
                    </div>
                </div>
            `;
        }
    });
</script>
<jsp:include page="bot.jsp"></jsp:include>
<jsp:include page="resources/footer.jsp" />