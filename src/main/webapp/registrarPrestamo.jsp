<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    String mensaje = "";
    if (request.getParameter("submit") != null) {
        String isbn = request.getParameter("isbn");
        String fechaPrestamo = request.getParameter("fechaPrestamo");
        String fechaDevolucion = request.getParameter("fechaDevolucion");

        Libro libro = Biblioteca.buscarLibroPorISBN(isbn);
        if (libro != null) {
            Registro.agregarPrestamo(new Prestamo(isbn, libro.getTitulo(), fechaPrestamo, fechaDevolucion));
            mensaje = "Préstamo registrado exitosamente.";
        } else {
            mensaje = "No se encontró un libro con el ISBN proporcionado.";
        }
    }
%>

<jsp:include page="/resources/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2><i class="fas fa-handshake"></i> Registrar Préstamo</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item"><a href="listarPrestamos.jsp">Préstamos</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Registrar Préstamo</li>
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
            title: '<%= mensaje.contains("exitosamente") ? "¡Préstamo registrado!" : "Error" %>',
            text: '<%= mensaje %>',
            confirmButtonText: '<i class="fas fa-check"></i> Aceptar',
            confirmButtonColor: '<%= mensaje.contains("exitosamente") ? "#2ecc71" : "#e74c3c" %>'
        }).then(() => {
            <% if (mensaje.contains("exitosamente")) { %>
            // Limpiar el formulario después de registrar
            document.getElementById('formPrestamo').reset();
            <% } %>
        });
    </script>
    <% } %>

    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="fas fa-book"></i> Información del Préstamo</h4>
                </div>
                <div class="card-body">
                    <form method="post" id="formPrestamo">
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-info-circle"></i> Detalles del Préstamo</h5>

                            <div class="mb-3">
                                <label for="isbn" class="form-label">ISBN del Libro</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                                    <input type="text" class="form-control" id="isbn" name="isbn" required>
                                    <button type="button" class="btn btn-outline-secondary" onclick="buscarLibro()">
                                        <i class="fas fa-search"></i> Buscar
                                    </button>
                                </div>
                                <div class="form-text">Ingrese el ISBN del libro que desea prestar</div>
                            </div>

                            <div id="infoLibro" class="alert alert-info d-none mb-3">
                                <h6><i class="fas fa-info-circle"></i> Información del Libro</h6>
                                <div id="detallesLibro"></div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="fechaPrestamo" class="form-label">Fecha de Préstamo</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
                                        <input type="date" class="form-control" id="fechaPrestamo" name="fechaPrestamo" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="fechaDevolucion" class="form-label">Fecha de Devolución</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-check"></i></span>
                                        <input type="date" class="form-control" id="fechaDevolucion" name="fechaDevolucion" required>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary btn-lg" name="submit">
                                <i class="fas fa-save"></i> Registrar Préstamo
                            </button>
                            <a href="listarPrestamos.jsp" class="btn btn-secondary btn-lg ms-2">
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
    // Establecer la fecha actual como valor predeterminado para la fecha de préstamo
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('fechaPrestamo').value = today;

        // Establecer la fecha de devolución predeterminada (15 días después)
        const devolucion = new Date();
        devolucion.setDate(devolucion.getDate() + 15);
        document.getElementById('fechaDevolucion').value = devolucion.toISOString().split('T')[0];
    });

    // Función para simular la búsqueda de un libro por ISBN
    function buscarLibro() {
        const isbn = document.getElementById('isbn').value;
        if (!isbn) {
            Swal.fire({
                icon: 'warning',
                title: 'Campo vacío',
                text: 'Por favor, ingrese un ISBN para buscar',
                confirmButtonText: 'Entendido'
            });
            return;
        }

        // Aquí normalmente harías una petición AJAX para buscar el libro
        // Como es una simulación, mostraremos un mensaje de carga y luego información ficticia

        Swal.fire({
            title: 'Buscando libro...',
            text: 'Espere un momento',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            },
            timer: 1000,
            timerProgressBar: true
        }).then(() => {
            // Simulamos que encontramos el libro
            document.getElementById('infoLibro').classList.remove('d-none');
            document.getElementById('detallesLibro').innerHTML = `
                <p><strong>Título:</strong> Ejemplo de libro con ISBN ${isbn}</p>
                <p><strong>Autor:</strong> Autor de ejemplo</p>
                <p><strong>Disponible:</strong> <span class="badge bg-success">Sí</span></p>
            `;
        });
    }
</script>
<jsp:include page="bot.jsp"></jsp:include>
<jsp:include page="resources/footer.jsp" />