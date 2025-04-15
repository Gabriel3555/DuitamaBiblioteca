</div>

<!-- Book Details Modal -->
<div class="modal fade" id="modalDetallesLibro" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-titulo-libro">Detalles del Libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <img id="modal-portada-libro" src="/placeholder.svg?height=200&width=150" alt="Portada del libro" class="img-fluid mb-3 book-cover">
                        <div id="modal-disponibilidad-libro" class="badge bg-success mb-2">Disponible</div>
                        <p id="modal-copias-libro" class="text-muted">3 copias disponibles</p>
                    </div>
                    <div class="col-md-8">
                        <h4 id="modal-encabezado-titulo-libro">Título del Libro</h4>
                        <p class="text-muted" id="modal-autor-libro">Autor del Libro</p>

                        <div class="book-details-grid">
                            <div class="detail-item">
                                <span class="detail-label">ISBN:</span>
                                <span id="modal-isbn-libro">1234567890</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Tipo:</span>
                                <span id="modal-tipo-libro">Ficción</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Año:</span>
                                <span id="modal-anio-libro">2023</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Editorial:</span>
                                <span id="modal-editorial-libro">Editorial</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Ubicación:</span>
                                <span id="modal-ubicacion-libro">Estante A-12</span>
                            </div>
                        </div>

                        <div id="modal-detalles-especificos-libro" class="mt-3">
                            <!-- Specific details based on book type will be added here -->
                        </div>

                        <h5 class="mt-3">Descripción</h5>
                        <p id="modal-descripcion-libro">Descripción del libro...</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="btn-editar-libro">Editar</button>
                <button type="button" class="btn btn-success" id="btn-prestar-libro">Prestar</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="modalEditarLibro" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Editar Libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formulario-editar-libro">
                    <input type="hidden" id="editar-id-libro">
                    <!-- Form fields similar to add book form -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="editar-isbn-libro" class="form-label">ISBN</label>
                            <input type="text" class="form-control" id="editar-isbn-libro" required>
                        </div>
                        <div class="col-md-6">
                            <label for="editar-tipo-libro" class="form-label">Tipo de Libro</label>
                            <select class="form-select" id="editar-tipo-libro" required>
                                <option value="ficcion">Ficción</option>
                                <option value="no-ficcion">No Ficción</option>
                                <option value="referencia">Referencia</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label for="editar-titulo-libro" class="form-label">Título</label>
                            <input type="text" class="form-control" id="editar-titulo-libro" required>
                        </div>
                        <div class="col-md-4">
                            <label for="editar-anio-libro" class="form-label">Año de Publicación</label>
                            <input type="number" class="form-control" id="editar-anio-libro" min="1000" max="2099" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="editar-autor-libro" class="form-label">Autor</label>
                            <input type="text" class="form-control" id="editar-autor-libro" required>
                        </div>
                        <div class="col-md-6">
                            <label for="editar-editorial-libro" class="form-label">Editorial</label>
                            <input type="text" class="form-control" id="editar-editorial-libro" required>
                        </div>
                    </div>

                    <!-- Dynamic fields based on book type -->
                    <div id="editar-campos-dinamicos" class="mb-3">
                        <!-- Fields will be added dynamically via JavaScript -->
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="editar-descripcion-libro" class="form-label">Descripción</label>
                            <textarea class="form-control" id="editar-descripcion-libro" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="editar-copias-libro" class="form-label">Número de Copias</label>
                            <input type="number" class="form-control" id="editar-copias-libro" min="1" value="1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="editar-ubicacion-libro" class="form-label">Ubicación</label>
                            <input type="text" class="form-control" id="editar-ubicacion-libro" placeholder="Ej: Estante A-12" required>
                        </div>
                        <div class="col-md-4">
                            <label for="editar-portada-libro" class="form-label">Imagen de Portada</label>
                            <input type="file" class="form-control" id="editar-portada-libro" accept="image/*">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="btn-eliminar-libro">Eliminar</button>
                <button type="button" class="btn btn-primary" id="btn-guardar-edicion">Guardar Cambios</button>
            </div>
        </div>
    </div>
</div>

<!-- Return Book Modal -->
<div class="modal fade" id="modalDevolucionLibro" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Registrar Devolución</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formulario-devolucion">
                    <input type="hidden" id="devolucion-id-prestamo">

                    <div class="mb-3">
                        <label class="form-label">Libro</label>
                        <p id="devolucion-titulo-libro" class="form-control-static">Título del Libro</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Usuario</label>
                        <p id="devolucion-nombre-usuario" class="form-control-static">Nombre del Usuario</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fecha de Préstamo</label>
                        <p id="devolucion-fecha-prestamo" class="form-control-static">01/01/2023</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fecha de Devolución Esperada</label>
                        <p id="devolucion-fecha-esperada" class="form-control-static">15/01/2023</p>
                    </div>

                    <div class="mb-3">
                        <label for="devolucion-fecha-real" class="form-label">Fecha de Devolución Real</label>
                        <input type="date" class="form-control" id="devolucion-fecha-real" required>
                    </div>

                    <div class="mb-3">
                        <label for="devolucion-estado" class="form-label">Estado del Libro</label>
                        <select class="form-select" id="devolucion-estado" required>
                            <option value="bueno">Bueno</option>
                            <option value="dañado">Dañado</option>
                            <option value="perdido">Perdido</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="devolucion-notas" class="form-label">Notas</label>
                        <textarea class="form-control" id="devolucion-notas" rows="2"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="btn-guardar-devolucion">Registrar Devolución</button>
            </div>
        </div>
    </div>
</div>

<!-- Toast Notifications -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="notificacionToast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto" id="titulo-notificacion">Notificación</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="mensaje-notificacion">
            Mensaje de notificación
        </div>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="modalConfirmacion" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="titulo-confirmacion">Confirmar Acción</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="mensaje-confirmacion">¿Está seguro que desea realizar esta acción?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="btn-confirmar">Confirmar</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.colVis.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="script.js"></script>
</body>
</html>