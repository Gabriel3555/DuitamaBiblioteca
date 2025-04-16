<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%
    // Obtener el ISBN del préstamo a editar
    String isbn = request.getParameter("isbn");
    Prestamo prestamo = Registro.buscarPrestamoPorISBN(isbn);
    String mensaje = "";

    if (prestamo == null) {
        mensaje = "No se encontró el préstamo con el ISBN proporcionado.";
    }

    // Procesar el formulario si se envió
    if (request.getParameter("submit") != null && prestamo != null) {
        String fechaPrestamo = request.getParameter("fechaPrestamo");
        String fechaDevolucion = request.getParameter("fechaDevolucion");

        prestamo.setFechaPrestamo(fechaPrestamo);
        prestamo.setFechaDevolucion(fechaDevolucion);

        mensaje = "Préstamo actualizado exitosamente.";
    }
%>

<jsp:include page="/resources/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2><i class="fas fa-edit"></i> Editar Préstamo</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item"><a href="listarPrestamos.jsp">Préstamos</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Editar Préstamo</li>
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
            title: '<%= mensaje.contains("exitosamente") ? "¡Préstamo actualizado!" : "Error" %>',
            text: '<%= mensaje %>',
            confirmButtonText: '<i class="fas fa-check"></i> Aceptar',
            confirmButtonColor: '<%= mensaje.contains("exitosamente") ? "#2ecc71" : "#e74c3c" %>'
        }).then(() => {
            <% if (mensaje.contains("exitosamente")) { %>
            window.location.href = "listarPrestamos.jsp";
            <% } %>
        });
    </script>
    <% } %>

    <% if (prestamo != null) { %>
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <div class="card shadow">
                <div class="card-header bg-warning text-white">
                    <h4 class="mb-0"><i class="fas fa-edit"></i> Editar Información del Préstamo</h4>
                </div>
                <div class="card-body">
                    <form method="post">
                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-info-circle"></i> Información del Libro</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="isbn" class="form-label">ISBN del Libro</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                                        <input type="text" class="form-control" id="isbn" name="isbn" value="<%= prestamo.getIsbnLibro() %>" readonly>
                                    </div>
                                    <div class="form-text">El ISBN no se puede modificar</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="titulo" class="form-label">Título del Libro</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-book"></i></span>
                                        <input type="text" class="form-control" id="titulo" name="titulo" value="<%= prestamo.getTituloLibro() %>" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <h5 class="border-bottom pb-2"><i class="fas fa-calendar-alt"></i> Fechas del Préstamo</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="fechaPrestamo" class="form-label">Fecha de Préstamo</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-plus"></i></span>
                                        <input type="date" class="form-control" id="fechaPrestamo" name="fechaPrestamo" value="<%= prestamo.getFechaPrestamo() %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="fechaDevolucion" class="form-label">Fecha de Devolución</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-check"></i></span>
                                        <input type="date" class="form-control" id="fechaDevolucion" name="fechaDevolucion" value="<%= prestamo.getFechaDevolucion() %>" required>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-warning btn-lg" name="submit">
                                <i class="fas fa-save"></i> Guardar Cambios
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
    <% } else { %>
    <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i> <%= mensaje %>
        <div class="mt-3">
            <a href="listarPrestamos.jsp" class="btn btn-primary">
                <i class="fas fa-arrow-left"></i> Volver a la lista de préstamos
            </a>
        </div>
    </div>
    <% } %>
</div>
<jsp:include page="bot.jsp"></jsp:include>
<jsp:include page="/resources/footer.jsp" />