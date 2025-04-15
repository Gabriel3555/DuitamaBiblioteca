<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.app.duitamabiblioteca.modelo.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="header.jsp" %>

<!-- Book List Section -->
<section id="lista-section">
    <div class="card shadow-sm">
        <div class="card-body">
            <h2 class="card-title mb-4">Catálogo de Libros</h2>

            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="text" class="form-control" id="buscar-catalogo" placeholder="Buscar libros...">
                        <button class="btn btn-outline-primary" type="button" id="btn-buscar-catalogo">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-4">
                    <select class="form-select" id="filtro-tipo">
                        <option value="all" selected>Todos los tipos</option>
                        <option value="ficcion">Ficción</option>
                        <option value="no-ficcion">No Ficción</option>
                        <option value="referencia">Referencia</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="filtro-disponibilidad">
                        <option value="all" selected>Todos</option>
                        <option value="available">Disponibles</option>
                        <option value="loaned">Prestados</option>
                    </select>
                </div>
            </div>

            <div class="table-responsive">
                <table id="tabla-libros" class="table table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Tipo</th>
                        <th>Disponible</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody id="cuerpo-tabla-libros">
                    <%
                        ArrayList<Libro> libros = Biblioteca.getLibros();
                        if (libros != null && !libros.isEmpty()) {
                            for (Libro libro : libros) {
                                String autor = "";
                                if (libro instanceof LibroFiccion) {
                                    autor = ((LibroFiccion) libro).getAutor();
                                }
                    %>
                    <tr>
                        <td><%= libro.getId() %></td>
                        <td><%= libro.getTitulo() %></td>
                        <td><%= autor %></td>
                        <td><%= libro.getTipo() %></td>
                        <td>
                            <span class="badge <%= libro.isDisponible() ? "bg-success" : "bg-danger" %>">
                                <%= libro.isDisponible() ? "Disponible" : "No disponible" %>
                            </span>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <button class="btn btn-sm btn-primary btn-ver-libro" data-book-id="<%= libro.getId() %>">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <a href="editar.jsp?id=<%= libro.getId() %>" class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="eliminar.jsp?id=<%= libro.getId() %>" class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr class="text-center text-muted">
                        <td colspan="6">No hay libros registrados</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>