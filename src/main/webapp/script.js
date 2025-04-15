// Elementos del DOM
document.addEventListener("DOMContentLoaded", () => {
    // Resaltar la opción de menú activa según la página actual
    const currentPage = window.location.pathname.split('/').pop();

    // Quitar la clase active de todos los enlaces del menú
    document.querySelectorAll('.nav-link').forEach(link => {
        link.classList.remove('active');
    });

    // Agregar la clase active al enlace correspondiente a la página actual
    if (currentPage === 'index.jsp' || currentPage === '' || currentPage === '/') {
        document.getElementById('nav-inicio')?.classList.add('active');
    } else if (currentPage === 'agregar.jsp') {
        document.getElementById('nav-agregar')?.classList.add('active');
    } else if (currentPage === 'catalogo.jsp') {
        document.getElementById('nav-lista')?.classList.add('active');
    } else if (currentPage === 'prestamos.jsp') {
        document.getElementById('nav-prestamos')?.classList.add('active');
    }

    // Botones de navegación en la página de inicio
    const btnIrAgregar = document.getElementById("btn-ir-agregar");
    const btnIrPrestamos = document.getElementById("btn-ir-prestamos");

    if (btnIrAgregar) {
        btnIrAgregar.addEventListener("click", function() {
            window.location.href = 'agregar.jsp';
        });
    }

    if (btnIrPrestamos) {
        btnIrPrestamos.addEventListener("click", function() {
            window.location.href = 'prestamos.jsp';
        });
    }

    // Formulario de Libro
    const formularioLibro = document.getElementById("formulario-libro")
    const selectTipoLibro = document.getElementById("libro-tipo")
    const camposDinamicos = document.getElementById("campos-dinamicos")
    const btnLimpiarFormulario = document.getElementById("btn-limpiar-formulario")

    // Lista de Libros
    const buscarCatalogo = document.getElementById("buscar-catalogo")
    const filtroTipo = document.getElementById("filtro-tipo")
    const filtroDisponibilidad = document.getElementById("filtro-disponibilidad")
    const cuerpoTablaLibros = document.getElementById("cuerpo-tabla-libros")

    // Búsqueda Rápida
    const busquedaRapida = document.getElementById("busqueda-rapida")
    const btnBusquedaRapida = document.getElementById("btn-busqueda-rapida")
    const resultadosRapidos = document.getElementById("resultados-rapidos")

    // Modales
    const modalDetallesLibro = new bootstrap.Modal(document.getElementById("modalDetallesLibro"))
    const modalEditarLibro = new bootstrap.Modal(document.getElementById("modalEditarLibro"))
    const modalDevolucionLibro = new bootstrap.Modal(document.getElementById("modalDevolucionLibro"))
    const modalConfirmacion = new bootstrap.Modal(document.getElementById("modalConfirmacion"))

    // Toast
    const notificacion = new bootstrap.Toast(document.getElementById("notificacionToast"))

    // Almacenamiento de Datos (simulando base de datos)
    let libros = []
    let prestamos = []
    let usuarios = []
    const actividades = []

    // Inicializar con datos de ejemplo
    inicializarDatosEjemplo()

    // Cargar datos específicos según la página actual
    if (currentPage === 'index.jsp' || currentPage === '' || currentPage === '/') {
        actualizarEstadisticas();
        actualizarActividadReciente();
    } else if (currentPage === 'catalogo.jsp') {
        renderizarListaLibros();
    } else if (currentPage === 'prestamos.jsp') {
        // Verificar qué pestaña está activa
        const tabActiva = document.querySelector('#tabPrestamos .nav-link.active');
        if (tabActiva && tabActiva.id === 'prestamos-activos-tab') {
            renderizarPrestamosActivos();
        } else if (tabActiva && tabActiva.id === 'historial-prestamos-tab') {
            renderizarHistorialPrestamos();
        }
    }

    // Configuración común para DataTables
    const configDataTables = {
        dom: 'Bfrtip',
        buttons: [
            {
                extend: 'excel',
                text: '<i class="fas fa-file-excel"></i> Excel',
                className: 'btn btn-success btn-sm',
                titleAttr: 'Exportar a Excel',
                exportOptions: {
                    columns: ':visible'
                }
            },
            {
                extend: 'pdf',
                text: '<i class="fas fa-file-pdf"></i> PDF',
                className: 'btn btn-danger btn-sm',
                titleAttr: 'Exportar a PDF',
                exportOptions: {
                    columns: ':visible'
                }
            },
            {
                extend: 'print',
                text: '<i class="fas fa-print"></i> Imprimir',
                className: 'btn btn-info btn-sm',
                titleAttr: 'Imprimir',
                exportOptions: {
                    columns: ':visible'
                }
            },
            {
                extend: 'colvis',
                text: '<i class="fas fa-columns"></i> Columnas',
                className: 'btn btn-secondary btn-sm',
                titleAttr: 'Mostrar/Ocultar columnas'
            }
        ],
        language: {
            "sProcessing":     "Procesando...",
            "sLengthMenu":     "Mostrar _MENU_ registros",
            "sZeroRecords":    "No se encontraron resultados",
            "sEmptyTable":     "Ningún dato disponible en esta tabla",
            "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
            "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
            "sInfoPostFix":    "",
            "sSearch":         "Buscar:",
            "sUrl":            "",
            "sInfoThousands":  ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst":    "Primero",
                "sLast":     "Último",
                "sNext":     "Siguiente",
                "sPrevious": "Anterior"
            },
            "oAria": {
                "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            },
            "buttons": {
                "copy": "Copiar",
                "colvis": "Visibilidad",
                "collection": "Colección",
                "colvisRestore": "Restaurar visibilidad",
                "copyKeys": "Presione ctrl o u2318 + C para copiar los datos de la tabla al portapapeles del sistema. <br><br>Para cancelar, haga clic en este mensaje o presione escape.",
                "copySuccess": {
                    "1": "Copiada 1 fila al portapapeles",
                    "_": "Copiadas %d filas al portapapeles"
                },
                "copyTitle": "Copiar al portapapeles",
                "csv": "CSV",
                "excel": "Excel",
                "pageLength": {
                    "-1": "Mostrar todas las filas",
                    "_": "Mostrar %d filas"
                },
                "pdf": "PDF",
                "print": "Imprimir"
            }
        }
    };

    // Cambio de Tipo de Libro - Campos Dinámicos
    if (selectTipoLibro) {
        selectTipoLibro.addEventListener("change", function () {
            generarCamposDinamicos(this.value, camposDinamicos)
        })
    }

    // Cambio de Tipo de Libro en Edición
    const editarTipoLibro = document.getElementById("editar-tipo-libro");
    if (editarTipoLibro) {
        editarTipoLibro.addEventListener("change", function () {
            generarCamposDinamicos(this.value, document.getElementById("editar-campos-dinamicos"))
        })
    }

    // Botón Limpiar Formulario
    if (btnLimpiarFormulario) {
        btnLimpiarFormulario.addEventListener("click", () => {
            formularioLibro.reset()
            camposDinamicos.innerHTML = ""
        })
    }

    // Envío de Formulario de Libro
    if (formularioLibro) {
        formularioLibro.addEventListener("submit", function (e) {
            e.preventDefault()

            // Validar formulario
            if (!this.checkValidity()) {
                e.stopPropagation()
                this.classList.add("was-validated")
                return
            }

            // Obtener datos del formulario
            const nuevoLibro = {
                id: generarId(),
                isbn: document.getElementById("libro-isbn").value,
                titulo: document.getElementById("libro-titulo").value,
                autor: document.getElementById("libro-autor").value,
                anio: document.getElementById("libro-anio").value,
                editorial: document.getElementById("libro-editorial").value,
                tipo: document.getElementById("libro-tipo").value,
                descripcion: document.getElementById("libro-descripcion").value,
                copias: Number.parseInt(document.getElementById("libro-copias").value),
                copiasDisponibles: Number.parseInt(document.getElementById("libro-copias").value),
                ubicacion: document.getElementById("libro-ubicacion").value,
                portada:
                    document.getElementById("libro-portada").files.length > 0
                        ? URL.createObjectURL(document.getElementById("libro-portada").files[0])
                        : "/placeholder.svg?height=200&width=150",
                detallesEspecificos: obtenerDetallesEspecificos(document.getElementById("libro-tipo").value),
            }

            // Agregar libro a la colección
            libros.push(nuevoLibro)

            // Agregar a actividad reciente
            agregarActividad(`Libro agregado: "${nuevoLibro.titulo}" por ${nuevoLibro.autor}`)

            // Mostrar mensaje de éxito
            mostrarNotificacion("Éxito", "Libro agregado correctamente", "success")

            // Resetear formulario
            formularioLibro.reset()
            camposDinamicos.innerHTML = ""
            formularioLibro.classList.remove("was-validated")

            // Actualizar estadísticas
            actualizarEstadisticas()
        })
    }

    // Búsqueda Rápida
    if (btnBusquedaRapida) {
        btnBusquedaRapida.addEventListener("click", realizarBusquedaRapida)
    }

    if (busquedaRapida) {
        busquedaRapida.addEventListener("keyup", (e) => {
            if (e.key === "Enter") {
                realizarBusquedaRapida()
            }
        })
    }

    // Búsqueda en Catálogo y Filtros
    const btnBuscarCatalogo = document.getElementById("btn-buscar-catalogo");
    if (btnBuscarCatalogo) {
        btnBuscarCatalogo.addEventListener("click", () => {
            renderizarListaLibros()
        })
    }

    if (buscarCatalogo) {
        buscarCatalogo.addEventListener("keyup", (e) => {
            if (e.key === "Enter") {
                renderizarListaLibros()
            }
        })
    }

    if (filtroTipo) {
        filtroTipo.addEventListener("change", renderizarListaLibros)
    }

    if (filtroDisponibilidad) {
        filtroDisponibilidad.addEventListener("change", renderizarListaLibros)
    }

    // Formulario de Préstamo
    const formularioPrestamo = document.getElementById("formulario-prestamo");
    if (formularioPrestamo) {
        formularioPrestamo.addEventListener("submit", function (e) {
            e.preventDefault()

            // Validar formulario
            if (!this.checkValidity()) {
                e.stopPropagation()
                this.classList.add("was-validated")
                return
            }

            // Obtener datos del formulario
            const nuevoPrestamo = {
                id: generarId(),
                idUsuario: document.getElementById("id-usuario").value,
                nombreUsuario: document.getElementById("nombre-usuario").value,
                idLibro: document.getElementById("id-libro-prestamo").value,
                tituloLibro: document.getElementById("titulo-libro-prestamo").value,
                fechaPrestamo: document.getElementById("fecha-prestamo").value,
                fechaDevolucion: document.getElementById("fecha-devolucion").value,
                fechaDevolucionReal: null,
                estado: "activo",
            }

            // Encontrar libro y actualizar copias disponibles
            const libro = libros.find((b) => b.isbn === nuevoPrestamo.idLibro)
            if (libro && libro.copiasDisponibles > 0) {
                libro.copiasDisponibles--

                // Agregar préstamo a la colección
                prestamos.push(nuevoPrestamo)

                // Agregar a actividad reciente
                agregarActividad(`Préstamo registrado: "${libro.titulo}" a ${nuevoPrestamo.nombreUsuario}`)

                // Mostrar mensaje de éxito
                mostrarNotificacion("Éxito", "Préstamo registrado correctamente", "success")

                // Resetear formulario
                this.reset()
                document.getElementById("nombre-usuario").value = ""
                document.getElementById("titulo-libro-prestamo").value = ""
                this.classList.remove("was-validated")

                // Actualizar estadísticas y lista de préstamos
                actualizarEstadisticas()
                renderizarPrestamosActivos()
            } else {
                mostrarNotificacion("Error", "No hay copias disponibles de este libro", "danger")
            }
        })
    }

    // Botón Buscar Usuario
    const btnBuscarUsuario = document.getElementById("btn-buscar-usuario");
    if (btnBuscarUsuario) {
        btnBuscarUsuario.addEventListener("click", () => {
            const idUsuario = document.getElementById("id-usuario").value
            const usuario = usuarios.find((p) => p.id === idUsuario)

            if (usuario) {
                document.getElementById("nombre-usuario").value = usuario.nombre
            } else {
                document.getElementById("nombre-usuario").value = ""
                mostrarNotificacion("Información", "Usuario no encontrado", "warning")
            }
        })
    }

    // Botón Buscar Libro
    const btnBuscarLibro = document.getElementById("btn-buscar-libro");
    if (btnBuscarLibro) {
        btnBuscarLibro.addEventListener("click", () => {
            const idLibro = document.getElementById("id-libro-prestamo").value
            const libro = libros.find((b) => b.isbn === idLibro)

            if (libro) {
                if (libro.copiasDisponibles > 0) {
                    document.getElementById("titulo-libro-prestamo").value = libro.titulo
                } else {
                    document.getElementById("titulo-libro-prestamo").value = ""
                    mostrarNotificacion("Información", "No hay copias disponibles de este libro", "warning")
                }
            } else {
                document.getElementById("titulo-libro-prestamo").value = ""
                mostrarNotificacion("Información", "Libro no encontrado", "warning")
            }
        })
    }

    // Botón Editar Libro (en modal)
    const btnEditarLibro = document.getElementById("btn-editar-libro");
    if (btnEditarLibro) {
        btnEditarLibro.addEventListener("click", () => {
            const idLibro = document.getElementById("modal-isbn-libro").textContent
            const libro = libros.find((b) => b.isbn === idLibro)

            if (libro) {
                // Llenar formulario de edición
                document.getElementById("editar-id-libro").value = libro.id
                document.getElementById("editar-isbn-libro").value = libro.isbn
                document.getElementById("editar-titulo-libro").value = libro.titulo
                document.getElementById("editar-autor-libro").value = libro.autor
                document.getElementById("editar-anio-libro").value = libro.anio
                document.getElementById("editar-editorial-libro").value = libro.editorial
                document.getElementById("editar-tipo-libro").value = libro.tipo
                document.getElementById("editar-descripcion-libro").value = libro.descripcion
                document.getElementById("editar-copias-libro").value = libro.copias
                document.getElementById("editar-ubicacion-libro").value = libro.ubicacion

                // Generar campos dinámicos
                generarCamposDinamicos(libro.tipo, document.getElementById("editar-campos-dinamicos"), libro.detallesEspecificos)

                // Ocultar modal de detalles y mostrar modal de edición
                modalDetallesLibro.hide()
                modalEditarLibro.show()
            }
        })
    }

    // Botón Guardar Edición
    const btnGuardarEdicion = document.getElementById("btn-guardar-edicion");
    if (btnGuardarEdicion) {
        btnGuardarEdicion.addEventListener("click", () => {
            const idLibro = document.getElementById("editar-id-libro").value
            const indiceLibro = libros.findIndex((b) => b.id === idLibro)

            if (indiceLibro !== -1) {
                const libroActualizado = {
                    id: idLibro,
                    isbn: document.getElementById("editar-isbn-libro").value,
                    titulo: document.getElementById("editar-titulo-libro").value,
                    autor: document.getElementById("editar-autor-libro").value,
                    anio: document.getElementById("editar-anio-libro").value,
                    editorial: document.getElementById("editar-editorial-libro").value,
                    tipo: document.getElementById("editar-tipo-libro").value,
                    descripcion: document.getElementById("editar-descripcion-libro").value,
                    copias: Number.parseInt(document.getElementById("editar-copias-libro").value),
                    copiasDisponibles: libros[indiceLibro].copiasDisponibles,
                    ubicacion: document.getElementById("editar-ubicacion-libro").value,
                    portada:
                        document.getElementById("editar-portada-libro").files.length > 0
                            ? URL.createObjectURL(document.getElementById("editar-portada-libro").files[0])
                            : libros[indiceLibro].portada,
                    detallesEspecificos: obtenerDetallesEspecificos(document.getElementById("editar-tipo-libro").value),
                }

                // Actualizar libro
                libros[indiceLibro] = libroActualizado

                // Agregar a actividad reciente
                agregarActividad(`Libro actualizado: "${libroActualizado.titulo}"`)

                // Mostrar mensaje de éxito
                mostrarNotificacion("Éxito", "Libro actualizado correctamente", "success")

                // Ocultar modal y actualizar lista de libros
                modalEditarLibro.hide()
                renderizarListaLibros()
            }
        })
    }

    // Botón Eliminar Libro
    const btnEliminarLibro = document.getElementById("btn-eliminar-libro");
    if (btnEliminarLibro) {
        btnEliminarLibro.addEventListener("click", () => {
            const idLibro = document.getElementById("editar-id-libro").value

            // Configurar modal de confirmación
            document.getElementById("titulo-confirmacion").textContent = "Eliminar Libro"
            document.getElementById("mensaje-confirmacion").textContent =
                "¿Está seguro que desea eliminar este libro? Esta acción no se puede deshacer."

            // Configurar botón de confirmación
            document.getElementById("btn-confirmar").onclick = () => {
                const indiceLibro = libros.findIndex((b) => b.id === idLibro)

                if (indiceLibro !== -1) {
                    const libroEliminado = libros[indiceLibro]

                    // Verificar si el libro tiene préstamos activos
                    const prestamosActivos = prestamos.filter((l) => l.idLibro === libroEliminado.isbn && l.estado === "activo")

                    if (prestamosActivos.length > 0) {
                        mostrarNotificacion("Error", "No se puede eliminar un libro con préstamos activos", "danger")
                    } else {
                        // Eliminar libro
                        libros.splice(indiceLibro, 1)

                        // Agregar a actividad reciente
                        agregarActividad(`Libro eliminado: "${libroEliminado.titulo}"`)

                        // Mostrar mensaje de éxito
                        mostrarNotificacion("Éxito", "Libro eliminado correctamente", "success")

                        // Actualizar lista de libros
                        renderizarListaLibros()
                        actualizarEstadisticas()
                    }
                }

                // Ocultar modales
                modalConfirmacion.hide()
                modalEditarLibro.hide()
            }

            // Mostrar modal de confirmación
            modalConfirmacion.show()
        })
    }

    // Botón Prestar Libro (en modal)
    const btnPrestarLibro = document.getElementById("btn-prestar-libro");
    if (btnPrestarLibro) {
        btnPrestarLibro.addEventListener("click", () => {
            const idLibro = document.getElementById("modal-isbn-libro").textContent
            const libro = libros.find((b) => b.isbn === idLibro)

            if (libro && libro.copiasDisponibles > 0) {
                // Llenar formulario de préstamo
                document.getElementById("id-libro-prestamo").value = libro.isbn
                document.getElementById("titulo-libro-prestamo").value = libro.titulo

                // Ocultar modal de detalles
                modalDetallesLibro.hide()

                // Redirigir a la página de préstamos
                window.location.href = 'prestamos.jsp';
            } else {
                mostrarNotificacion("Información", "No hay copias disponibles de este libro", "warning")
            }
        })
    }

    // Botón Devolver Libro (en préstamos activos)
    document.addEventListener("click", (e) => {
        if (e.target && e.target.classList.contains("btn-devolver-prestamo")) {
            const idPrestamo = e.target.getAttribute("data-prestamo-id")
            const prestamo = prestamos.find((l) => l.id === idPrestamo)

            if (prestamo) {
                // Llenar formulario de devolución
                document.getElementById("devolucion-id-prestamo").value = prestamo.id
                document.getElementById("devolucion-titulo-libro").textContent = prestamo.tituloLibro
                document.getElementById("devolucion-nombre-usuario").textContent = prestamo.nombreUsuario
                document.getElementById("devolucion-fecha-prestamo").textContent = formatearFecha(prestamo.fechaPrestamo)
                document.getElementById("devolucion-fecha-esperada").textContent = formatearFecha(prestamo.fechaDevolucion)
                document.getElementById("devolucion-fecha-real").value = obtenerFechaActual()

                // Mostrar modal de devolución
                modalDevolucionLibro.show()
            }
        }
    })

    // Botón Guardar Devolución
    const btnGuardarDevolucion = document.getElementById("btn-guardar-devolucion");
    if (btnGuardarDevolucion) {
        btnGuardarDevolucion.addEventListener("click", () => {
            const idPrestamo = document.getElementById("devolucion-id-prestamo").value
            const indicePrestamo = prestamos.findIndex((l) => l.id === idPrestamo)

            if (indicePrestamo !== -1) {
                const prestamo = prestamos[indicePrestamo]
                const libro = libros.find((b) => b.isbn === prestamo.idLibro)

                // Actualizar préstamo
                prestamo.fechaDevolucionReal = document.getElementById("devolucion-fecha-real").value
                prestamo.estado = document.getElementById("devolucion-estado").value
                prestamo.notas = document.getElementById("devolucion-notas").value
                prestamo.estado = "devuelto"

                // Actualizar copias disponibles del libro
                if (libro && prestamo.estado !== "perdido") {
                    libro.copiasDisponibles++
                }

                // Agregar a actividad reciente
                agregarActividad(`Libro devuelto: "${prestamo.tituloLibro}" por ${prestamo.nombreUsuario}`)

                // Mostrar mensaje de éxito
                mostrarNotificacion("Éxito", "Devolución registrada correctamente", "success")

                // Ocultar modal y actualizar lista de préstamos
                modalDevolucionLibro.hide()
                renderizarPrestamosActivos()
                actualizarEstadisticas()
            }
        })
    }

    // Ver Detalles del Libro (en lista de libros)
    document.addEventListener("click", (e) => {
        if (e.target && e.target.classList.contains("btn-ver-libro")) {
            const idLibro = e.target.getAttribute("data-book-id")
            const libro = libros.find((b) => b.isbn === idLibro)

            if (libro) {
                // Llenar modal con detalles del libro
                document.getElementById("modal-titulo-libro").textContent = "Detalles del Libro"
                document.getElementById("modal-encabezado-titulo-libro").textContent = libro.titulo
                document.getElementById("modal-autor-libro").textContent = libro.autor
                document.getElementById("modal-isbn-libro").textContent = libro.isbn
                document.getElementById("modal-tipo-libro").textContent = obtenerNombreTipoLibro(libro.tipo)
                document.getElementById("modal-anio-libro").textContent = libro.anio
                document.getElementById("modal-editorial-libro").textContent = libro.editorial
                document.getElementById("modal-ubicacion-libro").textContent = libro.ubicacion
                document.getElementById("modal-descripcion-libro").textContent = libro.descripcion
                document.getElementById("modal-portada-libro").src = libro.portada

                // Establecer badge de disponibilidad
                const badgeDisponibilidad = document.getElementById("modal-disponibilidad-libro")
                if (libro.copiasDisponibles > 0) {
                    badgeDisponibilidad.textContent = "Disponible"
                    badgeDisponibilidad.className = "badge bg-success mb-2"
                    document.getElementById("btn-prestar-libro").disabled = false
                } else {
                    badgeDisponibilidad.textContent = "No Disponible"
                    badgeDisponibilidad.className = "badge bg-danger mb-2"
                    document.getElementById("btn-prestar-libro").disabled = true
                }

                // Establecer texto de copias
                document.getElementById("modal-copias-libro").textContent =
                    `${libro.copiasDisponibles} de ${libro.copias} copias disponibles`

                // Establecer detalles específicos
                const contenedorDetallesEspecificos = document.getElementById("modal-detalles-especificos-libro")
                contenedorDetallesEspecificos.innerHTML = ""

                if (libro.detallesEspecificos) {
                    const tituloDetalles = document.createElement("h5")
                    tituloDetalles.textContent = "Detalles Específicos"
                    contenedorDetallesEspecificos.appendChild(tituloDetalles)

                    const listaDetalles = document.createElement("ul")
                    listaDetalles.className = "list-group list-group-flush"

                    for (const [clave, valor] of Object.entries(libro.detallesEspecificos)) {
                        const item = document.createElement("li")
                        item.className = "list-group-item"
                        item.innerHTML = `<strong>${formatearNombreCampo(clave)}:</strong> ${valor}`
                        listaDetalles.appendChild(item)
                    }

                    contenedorDetallesEspecificos.appendChild(listaDetalles)
                }

                // Mostrar modal
                modalDetallesLibro.show()
            }
        }
    })

    // Inicializar tabla de historial cuando se haga clic en la pestaña
    const historialPrestamosTab = document.getElementById('historial-prestamos-tab');
    if (historialPrestamosTab) {
        historialPrestamosTab.addEventListener('click', function() {
            renderizarHistorialPrestamos();
        });
    }

    // Inicializar con datos de ejemplo
    function inicializarDatosEjemplo() {
        // Libros de ejemplo
        libros = [
            {
                id: generarId(),
                isbn: "9780061120084",
                titulo: "Matar a un ruiseñor",
                autor: "Harper Lee",
                anio: "1960",
                editorial: "J. B. Lippincott & Co.",
                tipo: "ficcion",
                descripcion:
                    "Una historia sobre la injusticia racial y la pérdida de la inocencia en el sur de Estados Unidos.",
                copias: 5,
                copiasDisponibles: 3,
                ubicacion: "Estante A-12",
                portada: "/placeholder.svg?height=200&width=150",
                detallesEspecificos: {
                    genero: "Novela",
                    premios: "Premio Pulitzer",
                    audiencia: "Adultos",
                },
            },
            {
                id: generarId(),
                isbn: "9780307474278",
                titulo: "El Principito",
                autor: "Antoine de Saint-Exupéry",
                anio: "1943",
                editorial: "Reynal & Hitchcock",
                tipo: "ficcion",
                descripcion: "Una fábula filosófica sobre la naturaleza humana y las relaciones.",
                copias: 3,
                copiasDisponibles: 2,
                ubicacion: "Estante B-05",
                portada: "/placeholder.svg?height=200&width=150",
                detallesEspecificos: {
                    genero: "Fábula",
                    premios: "Ninguno",
                    audiencia: "Todas las edades",
                },
            },
            {
                id: generarId(),
                isbn: "9780553211404",
                titulo: "Breve historia del tiempo",
                autor: "Stephen Hawking",
                anio: "1988",
                editorial: "Bantam Books",
                tipo: "no-ficcion",
                descripcion: "Un libro de divulgación científica sobre cosmología.",
                copias: 2,
                copiasDisponibles: 1,
                ubicacion: "Estante C-08",
                portada: "/placeholder.svg?height=200&width=150",
                detallesEspecificos: {
                    area: "Ciencia",
                    publico: "General",
                    nivel: "Intermedio",
                },
            },
            {
                id: generarId(),
                isbn: "9780198501053",
                titulo: "Diccionario Oxford de Matemáticas",
                autor: "James Nicholson",
                anio: "2009",
                editorial: "Oxford University Press",
                tipo: "referencia",
                descripcion: "Un diccionario completo de términos matemáticos.",
                copias: 1,
                copiasDisponibles: 0,
                ubicacion: "Estante D-01",
                portada: "/placeholder.svg?height=200&width=150",
                detallesEspecificos: {
                    campo: "Matemáticas",
                    prestable: "No",
                    edicion: "2da Edición",
                },
            },
        ]

        // Usuarios de ejemplo
        usuarios = [
            {
                id: "P001",
                nombre: "Juan Pérez",
                email: "juan.perez@email.com",
                telefono: "3001234567",
            },
            {
                id: "P002",
                nombre: "María López",
                email: "maria.lopez@email.com",
                telefono: "3109876543",
            },
            {
                id: "P003",
                nombre: "Carlos Rodríguez",
                email: "carlos.rodriguez@email.com",
                telefono: "3207654321",
            },
        ]

        // Préstamos de ejemplo
        prestamos = [
            {
                id: generarId(),
                idUsuario: "P001",
                nombreUsuario: "Juan Pérez",
                idLibro: "9780198501053",
                tituloLibro: "Diccionario Oxford de Matemáticas",
                fechaPrestamo: "2023-05-01",
                fechaDevolucion: "2023-05-15",
                fechaDevolucionReal: null,
                estado: "activo",
            },
            {
                id: generarId(),
                idUsuario: "P002",
                nombreUsuario: "María López",
                idLibro: "9780061120084",
                tituloLibro: "Matar a un ruiseñor",
                fechaPrestamo: "2023-04-20",
                fechaDevolucion: "2023-05-04",
                fechaDevolucionReal: "2023-05-03",
                estado: "devuelto",
            },
        ]
    }

    // Realizar búsqueda rápida
    function realizarBusquedaRapida() {
        if (!busquedaRapida || !resultadosRapidos) return;

        const terminoBusqueda = busquedaRapida.value.toLowerCase()

        if (terminoBusqueda.trim() === "") {
            resultadosRapidos.innerHTML = `
            <div class="quick-results-placeholder text-center text-muted">
              <i class="bi bi-search display-4"></i>
              <p>Los resultados de búsqueda aparecerán aquí</p>
            </div>
          `
            return
        }

        // Filtrar libros
        const librosFiltrados = libros
            .filter(
                (libro) =>
                    libro.titulo.toLowerCase().includes(terminoBusqueda) ||
                    libro.autor.toLowerCase().includes(terminoBusqueda) ||
                    libro.isbn.includes(terminoBusqueda),
            )
            .slice(0, 3) // Limitar a 3 resultados

        // Limpiar resultados
        resultadosRapidos.innerHTML = ""

        // Verificar si no se encontraron libros
        if (librosFiltrados.length === 0) {
            resultadosRapidos.innerHTML = `
            <div class="text-center text-muted">
              <p>No se encontraron libros con el término "${terminoBusqueda}"</p>
            </div>
          `
            return
        }

        // Crear lista de resultados
        const listaResultados = document.createElement("ul")
        listaResultados.className = "list-group"

        librosFiltrados.forEach((libro) => {
            const item = document.createElement("li")
            item.className = "list-group-item d-flex justify-content-between align-items-center"

            item.innerHTML = `
            <div>
              <h6 class="mb-0">${libro.titulo}</h6>
              <small class="text-muted">${libro.autor}</small>
            </div>
            <span class="badge ${libro.copiasDisponibles > 0 ? "bg-success" : "bg-danger"} rounded-pill">
              ${libro.copiasDisponibles} / ${libro.copias}
            </span>
          `

            item.addEventListener("click", () => {
                // Llenar modal con detalles del libro y mostrarlo
                document.getElementById("modal-titulo-libro").textContent = "Detalles del Libro"
                document.getElementById("modal-encabezado-titulo-libro").textContent = libro.titulo
                document.getElementById("modal-autor-libro").textContent = libro.autor
                document.getElementById("modal-isbn-libro").textContent = libro.isbn
                document.getElementById("modal-tipo-libro").textContent = obtenerNombreTipoLibro(libro.tipo)
                document.getElementById("modal-anio-libro").textContent = libro.anio
                document.getElementById("modal-editorial-libro").textContent = libro.editorial
                document.getElementById("modal-ubicacion-libro").textContent = libro.ubicacion
                document.getElementById("modal-descripcion-libro").textContent = libro.descripcion
                document.getElementById("modal-portada-libro").src = libro.portada

                // Establecer badge de disponibilidad
                const badgeDisponibilidad = document.getElementById("modal-disponibilidad-libro")
                if (libro.copiasDisponibles > 0) {
                    badgeDisponibilidad.textContent = "Disponible"
                    badgeDisponibilidad.className = "badge bg-success mb-2"
                    document.getElementById("btn-prestar-libro").disabled = false
                } else {
                    badgeDisponibilidad.textContent = "No Disponible"
                    badgeDisponibilidad.className = "badge bg-danger mb-2"
                    document.getElementById("btn-prestar-libro").disabled = true
                }

                // Establecer texto de copias
                document.getElementById("modal-copias-libro").textContent =
                    `${libro.copiasDisponibles} de ${libro.copias} copias disponibles`

                // Establecer detalles específicos
                const contenedorDetallesEspecificos = document.getElementById("modal-detalles-especificos-libro")
                contenedorDetallesEspecificos.innerHTML = ""

                if (libro.detallesEspecificos) {
                    const tituloDetalles = document.createElement("h5")
                    tituloDetalles.textContent = "Detalles Específicos"
                    contenedorDetallesEspecificos.appendChild(tituloDetalles)

                    const listaDetalles = document.createElement("ul")
                    listaDetalles.className = "list-group list-group-flush"

                    for (const [clave, valor] of Object.entries(libro.detallesEspecificos)) {
                        const item = document.createElement("li")
                        item.className = "list-group-item"
                        item.innerHTML = `<strong>${formatearNombreCampo(clave)}:</strong> ${valor}`
                        listaDetalles.appendChild(item)
                    }

                    contenedorDetallesEspecificos.appendChild(listaDetalles)
                }

                // Mostrar modal
                modalDetallesLibro.show()
            })

            listaResultados.appendChild(item)
        })

        resultadosRapidos.appendChild(listaResultados)
    }

    // Renderizar lista de libros
    function renderizarListaLibros() {
        if (!buscarCatalogo || !filtroTipo || !filtroDisponibilidad || !cuerpoTablaLibros) return;

        const terminoBusqueda = buscarCatalogo.value.toLowerCase()
        const tipoFiltro = filtroTipo.value
        const disponibilidadFiltro = filtroDisponibilidad.value

        // Destruir la tabla DataTable existente si existe
        if ($.fn.DataTable.isDataTable('#tabla-libros')) {
            $('#tabla-libros').DataTable().destroy();
        }

        // Filtrar libros
        const librosFiltrados = libros.filter((libro) => {
            // Filtro por término de búsqueda
            const coincideBusqueda =
                libro.titulo.toLowerCase().includes(terminoBusqueda) ||
                libro.autor.toLowerCase().includes(terminoBusqueda) ||
                libro.isbn.includes(terminoBusqueda)

            // Filtro por tipo
            const coincideTipo = tipoFiltro === "all" || libro.tipo === tipoFiltro

            // Filtro por disponibilidad
            const coincideDisponibilidad =
                disponibilidadFiltro === "all" ||
                (disponibilidadFiltro === "available" && libro.copiasDisponibles > 0) ||
                (disponibilidadFiltro === "loaned" && libro.copiasDisponibles === 0)

            return coincideBusqueda && coincideTipo && coincideDisponibilidad
        })

        // Limpiar tabla
        cuerpoTablaLibros.innerHTML = ""

        // Verificar si no se encontraron libros
        if (librosFiltrados.length === 0) {
            cuerpoTablaLibros.innerHTML = `
            <tr class="text-center text-muted">
              <td colspan="6">No se encontraron libros con los criterios de búsqueda</td>
            </tr>
          `
            // Inicializar DataTable vacía
            $('#tabla-libros').DataTable(configDataTables);
            return
        }

        // Renderizar libros
        librosFiltrados.forEach((libro) => {
            const fila = document.createElement("tr")

            fila.innerHTML = `
            <td>${libro.isbn}</td>
            <td>${libro.titulo}</td>
            <td>${libro.autor}</td>
            <td>${obtenerNombreTipoLibro(libro.tipo)}</td>
            <td>
              <span class="badge ${libro.copiasDisponibles > 0 ? "bg-success" : "bg-danger"}">
                ${libro.copiasDisponibles > 0 ? "Disponible" : "No disponible"}
              </span>
            </td>
            <td>
              <button class="btn btn-sm btn-primary btn-ver-libro" data-book-id="${libro.isbn}">
                <i class="bi bi-eye"></i>
              </button>
            </td>
          `

            cuerpoTablaLibros.appendChild(fila)
        })

        // Inicializar DataTable con los datos y configuración completa
        $('#tabla-libros').DataTable({
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excel',
                    text: '<i class="fas fa-file-excel"></i> Excel',
                    className: 'btn btn-success btn-sm',
                    titleAttr: 'Exportar a Excel',
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'pdf',
                    text: '<i class="fas fa-file-pdf"></i> PDF',
                    className: 'btn btn-danger btn-sm',
                    titleAttr: 'Exportar a PDF',
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'print',
                    text: '<i class="fas fa-print"></i> Imprimir',
                    className: 'btn btn-info btn-sm',
                    titleAttr: 'Imprimir',
                    exportOptions: {
                        columns: ':visible'
                    }
                },
                {
                    extend: 'colvis',
                    text: '<i class="fas fa-columns"></i> Columnas',
                    className: 'btn btn-secondary btn-sm',
                    titleAttr: 'Mostrar/Ocultar columnas'
                }
            ],
            language: {
                "sProcessing":     "Procesando...",
                "sLengthMenu":     "Mostrar _MENU_ registros",
                "sZeroRecords":    "No se encontraron resultados",
                "sEmptyTable":     "Ningún dato disponible en esta tabla",
                "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                "sInfoPostFix":    "",
                "sSearch":         "Buscar:",
                "sUrl":            "",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
                "oPaginate": {
                    "sFirst":    "Primero",
                    "sLast":     "Último",
                    "sNext":     "Siguiente",
                    "sPrevious": "Anterior"
                },
                "oAria": {
                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                },
                "buttons": {
                    "copy": "Copiar",
                    "colvis": "Visibilidad",
                    "collection": "Colección",
                    "colvisRestore": "Restaurar visibilidad",
                    "copyKeys": "Presione ctrl o u2318 + C para copiar los datos de la tabla al portapapeles del sistema. <br><br>Para cancelar, haga clic en este mensaje o presione escape.",
                    "copySuccess": {
                        "1": "Copiada 1 fila al portapapeles",
                        "_": "Copiadas %d filas al portapapeles"
                    },
                    "copyTitle": "Copiar al portapapeles",
                    "csv": "CSV",
                    "excel": "Excel",
                    "pageLength": {
                        "-1": "Mostrar todas las filas",
                        "_": "Mostrar %d filas"
                    },
                    "pdf": "PDF",
                    "print": "Imprimir"
                }
            }
        });
    }

    // Renderizar préstamos activos
    function renderizarPrestamosActivos() {
        const tablaPrestamosActivos = document.getElementById("cuerpo-tabla-prestamos-activos")
        if (!tablaPrestamosActivos) return;

        const prestamosActivos = prestamos.filter((prestamo) => prestamo.estado === "activo")

        // Destruir la tabla DataTable existente si existe
        if ($.fn.DataTable.isDataTable('#tabla-prestamos-activos')) {
            $('#tabla-prestamos-activos').DataTable().destroy();
        }

        // Limpiar tabla
        tablaPrestamosActivos.innerHTML = ""

        // Verificar si no hay préstamos activos
        if (prestamosActivos.length === 0) {
            tablaPrestamosActivos.innerHTML = `
            <tr class="text-center text-muted">
              <td colspan="7">No hay préstamos activos</td>
            </tr>
          `
            // Inicializar DataTable vacía
            $('#tabla-prestamos-activos').DataTable(configDataTables);
            return
        }

        // Renderizar préstamos
        prestamosActivos.forEach((prestamo) => {
            const fila = document.createElement("tr")

            fila.innerHTML = `
            <td>${prestamo.id}</td>
            <td>${prestamo.nombreUsuario}</td>
            <td>${prestamo.tituloLibro}</td>
            <td>${formatearFecha(prestamo.fechaPrestamo)}</td>
            <td>${formatearFecha(prestamo.fechaDevolucion)}</td>
            <td>
              <span class="badge ${estaVencido(prestamo.fechaDevolucion) ? "bg-danger" : "bg-warning"}">
                ${estaVencido(prestamo.fechaDevolucion) ? "Vencido" : "Activo"}
              </span>
            </td>
            <td>
              <button class="btn btn-sm btn-success btn-devolver-prestamo" data-prestamo-id="${prestamo.id}">
                <i class="bi bi-check-circle"></i> Devolver
              </button>
            </td>
          `

            tablaPrestamosActivos.appendChild(fila)
        })

        // Inicializar DataTable con los datos
        $('#tabla-prestamos-activos').DataTable(configDataTables);
    }

    // Renderizar historial de préstamos
    function renderizarHistorialPrestamos() {
        const tablaHistorialPrestamos = document.getElementById("cuerpo-tabla-historial-prestamos")
        if (!tablaHistorialPrestamos) return;

        const historialPrestamos = prestamos.filter((prestamo) => prestamo.estado === "devuelto")

        // Destruir la tabla DataTable existente si existe
        if ($.fn.DataTable.isDataTable('#tabla-historial-prestamos')) {
            $('#tabla-historial-prestamos').DataTable().destroy();
        }

        // Limpiar tabla
        tablaHistorialPrestamos.innerHTML = ""

        // Verificar si no hay historial de préstamos
        if (historialPrestamos.length === 0) {
            tablaHistorialPrestamos.innerHTML = `
            <tr class="text-center text-muted">
              <td colspan="7">No hay registros en el historial</td>
            </tr>
          `
            // Inicializar DataTable vacía
            $('#tabla-historial-prestamos').DataTable(configDataTables);
            return
        }

        // Renderizar préstamos
        historialPrestamos.forEach((prestamo) => {
            const fila = document.createElement("tr")

            fila.innerHTML = `
            <td>${prestamo.id}</td>
            <td>${prestamo.nombreUsuario}</td>
            <td>${prestamo.tituloLibro}</td>
            <td>${formatearFecha(prestamo.fechaPrestamo)}</td>
            <td>${formatearFecha(prestamo.fechaDevolucion)}</td>
            <td>${prestamo.fechaDevolucionReal ? formatearFecha(prestamo.fechaDevolucionReal) : '-'}</td>
            <td>
              <span class="badge bg-success">
                Devuelto
              </span>
            </td>
          `

            tablaHistorialPrestamos.appendChild(fila)
        })

        // Inicializar DataTable con los datos
        $('#tabla-historial-prestamos').DataTable(configDataTables);
    }

    // Generar campos dinámicos basados en el tipo de libro
    function generarCamposDinamicos(tipoLibro, contenedor, valores = {}) {
        // Limpiar contenedor
        contenedor.innerHTML = ""

        // Crear campos basados en el tipo de libro
        if (tipoLibro === "ficcion") {
            contenedor.innerHTML = `
            <div class="row">
              <div class="col-md-4">
                <label for="libro-genero" class="form-label">Género</label>
                <input type="text" class="form-control" id="libro-genero" value="${valores.genero || ""}">
              </div>
              <div class="col-md-4">
                <label for="libro-premios" class="form-label">Premios</label>
                <input type="text" class="form-control" id="libro-premios" value="${valores.premios || ""}">
              </div>
              <div class="col-md-4">
                <label for="libro-audiencia" class="form-label">Audiencia</label>
                <select class="form-select" id="libro-audiencia">
                  <option value="Niños" ${valores.audiencia === "Niños" ? "selected" : ""}>Niños</option>
                  <option value="Jóvenes" ${valores.audiencia === "Jóvenes" ? "selected" : ""}>Jóvenes</option>
                  <option value="Adultos" ${valores.audiencia === "Adultos" ? "selected" : ""}>Adultos</option>
                  <option value="Todas las edades" ${valores.audiencia === "Todas las edades" ? "selected" : ""}>Todas las edades</option>
                </select>
              </div>
            </div>
          `
        } else if (tipoLibro === "no-ficcion") {
            contenedor.innerHTML = `
            <div class="row">
              <div class="col-md-4">
                <label for="libro-area" class="form-label">Área Temática</label>
                <input type="text" class="form-control" id="libro-area" value="${valores.area || ""}">
              </div>
              <div class="col-md-4">
                <label for="libro-publico" class="form-label">Público Objetivo</label>
                <input type="text" class="form-control" id="libro-publico" value="${valores.publico || ""}">
              </div>
              <div class="col-md-4">
                <label for="libro-nivel" class="form-label">Nivel</label>
                <select class="form-select" id="libro-nivel">
                  <option value="Básico" ${valores.nivel === "Básico" ? "selected" : ""}>Básico</option>
                  <option value="Intermedio" ${valores.nivel === "Intermedio" ? "selected" : ""}>Intermedio</option>
                  <option value="Avanzado" ${valores.nivel === "Avanzado" ? "selected" : ""}>Avanzado</option>
                </select>
              </div>
            </div>
          `
        } else if (tipoLibro === "referencia") {
            contenedor.innerHTML = `
            <div class="row">
              <div class="col-md-4">
                <label for="libro-campo" class="form-label">Campo Académico</label>
                <input type="text" class="form-control" id="libro-campo" value="${valores.campo || ""}">
              </div>
              <div class="col-md-4">
                <label for="libro-prestable" class="form-label">¿Puede ser prestado?</label>
                <select class="form-select" id="libro-prestable">
                  <option value="Sí" ${valores.prestable === "Sí" ? "selected" : ""}>Sí</option>
                  <option value="No" ${valores.prestable === "No" ? "selected" : ""}>No</option>
                </select>
              </div>
              <div class="col-md-4">
                <label for="libro-edicion" class="form-label">Edición</label>
                <input type="text" class="form-control" id="libro-edicion" value="${valores.edicion || ""}">
              </div>
            </div>
          `
        }
    }

    // Obtener detalles específicos del formulario basados en el tipo de libro
    function obtenerDetallesEspecificos(tipoLibro) {
        if (tipoLibro === "ficcion") {
            return {
                genero: document.getElementById("libro-genero")?.value || "",
                premios: document.getElementById("libro-premios")?.value || "",
                audiencia: document.getElementById("libro-audiencia")?.value || "Todas las edades",
            }
        } else if (tipoLibro === "no-ficcion") {
            return {
                area: document.getElementById("libro-area")?.value || "",
                publico: document.getElementById("libro-publico")?.value || "",
                nivel: document.getElementById("libro-nivel")?.value || "Intermedio",
            }
        } else if (tipoLibro === "referencia") {
            return {
                campo: document.getElementById("libro-campo")?.value || "",
                prestable: document.getElementById("libro-prestable")?.value || "No",
                edicion: document.getElementById("libro-edicion")?.value || "",
            }
        }

        return {}
    }

    // Actualizar estadísticas
    function actualizarEstadisticas() {
        const totalLibros = document.getElementById("total-libros");
        const librosDisponibles = document.getElementById("libros-disponibles");
        const prestamosActivos = document.getElementById("prestamos-activos");

        if (!totalLibros || !librosDisponibles || !prestamosActivos) return;

        totalLibros.textContent = libros.length

        const librosDisponiblesCount = libros.reduce((total, libro) => total + libro.copiasDisponibles, 0)
        librosDisponibles.textContent = librosDisponiblesCount

        const prestamosActivosCount = prestamos.filter((prestamo) => prestamo.estado === "activo").length
        prestamosActivos.textContent = prestamosActivosCount
    }

    // Agregar actividad a la lista de actividad reciente
    function agregarActividad(actividad) {
        const ahora = new Date()
        actividades.unshift({
            texto: actividad,
            timestamp: ahora,
        })

        // Mantener solo las últimas 10 actividades
        if (actividades.length > 10) {
            actividades.pop()
        }

        actualizarActividadReciente()
    }

    // Actualizar lista de actividad reciente
    function actualizarActividadReciente() {
        const listaActividadReciente = document.getElementById("actividad-reciente")
        if (!listaActividadReciente) return;

        // Limpiar lista
        listaActividadReciente.innerHTML = ""

        // Verificar si no hay actividades
        if (actividades.length === 0) {
            listaActividadReciente.innerHTML = `
            <li class="list-group-item text-center text-muted">No hay actividad reciente</li>
          `
            return
        }

        // Renderizar actividades
        actividades.forEach((actividad) => {
            const item = document.createElement("li")
            item.className = "list-group-item"

            item.innerHTML = `
            <div class="d-flex justify-content-between">
              <span>${actividad.texto}</span>
              <small class="text-muted">${formatearFechaHora(actividad.timestamp)}</small>
            </div>
          `

            listaActividadReciente.appendChild(item)
        })
    }

    // Mostrar notificación toast
    function mostrarNotificacion(titulo, mensaje, tipo = "primary") {
        const tituloNotificacion = document.getElementById("titulo-notificacion")
        const mensajeNotificacion = document.getElementById("mensaje-notificacion")
        const elementoNotificacion = document.getElementById("notificacionToast")

        // Establecer contenido de la notificación
        tituloNotificacion.textContent = titulo
        mensajeNotificacion.textContent = mensaje

        // Establecer tipo de notificación
        elementoNotificacion.className = `toast hide border-${tipo}`

        // Mostrar notificación
        notificacion.show()
    }

    // Funciones auxiliares
    function generarId() {
        return Math.random().toString(36).substring(2, 10)
    }

    function formatearFecha(fechaString) {
        const fecha = new Date(fechaString)
        return fecha.toLocaleDateString("es-ES")
    }

    function formatearFechaHora(fecha) {
        return fecha.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit" })
    }

    function obtenerFechaActual() {
        const ahora = new Date()
        return ahora.toISOString().split("T")[0]
    }

    function estaVencido(fechaDevolucion) {
        const hoy = new Date()
        const fechaDevolucionObj = new Date(fechaDevolucion)
        return fechaDevolucionObj < hoy
    }

    function obtenerNombreTipoLibro(tipo) {
        switch (tipo) {
            case "ficcion":
                return "Ficción"
            case "no-ficcion":
                return "No Ficción"
            case "referencia":
                return "Referencia"
            default:
                return tipo
        }
    }

    function formatearNombreCampo(nombreCampo) {
        // Capitalizar primera letra y reemplazar camelCase con espacios
        return nombreCampo.charAt(0).toUpperCase() + nombreCampo.slice(1).replace(/([A-Z])/g, " $1")
    }

    function inicializarEdicionLibros() {
        // Cambio de Tipo de Libro en Edición
        const editarTipoLibro = document.getElementById("editar-tipo-libro");
        if (editarTipoLibro) {
            editarTipoLibro.addEventListener("change", function () {
                generarCamposDinamicos(this.value, document.getElementById("editar-campos-dinamicos"));
            });
        }
    }

// Función para manejar la eliminación de libros
    function inicializarEliminacionLibros() {
        // Botones de eliminación en la tabla
        const botonesEliminar = document.querySelectorAll(".btn-eliminar-libro");
        if (botonesEliminar) {
            botonesEliminar.forEach(boton => {
                boton.addEventListener("click", function(e) {
                    if (!confirm("¿Está seguro que desea eliminar este libro? Esta acción no se puede deshacer.")) {
                        e.preventDefault();
                    }
                });
            });
        }
    }

// Inicializar DataTable para la tabla de libros
    function inicializarTablaLibros() {
        const tablaLibros = document.getElementById("tabla-libros");
        if (tablaLibros) {
            $(tablaLibros).DataTable({
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'excel',
                        text: '<i class="fas fa-file-excel"></i> Excel',
                        className: 'btn btn-success btn-sm',
                        titleAttr: 'Exportar a Excel',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdf',
                        text: '<i class="fas fa-file-pdf"></i> PDF',
                        className: 'btn btn-danger btn-sm',
                        titleAttr: 'Exportar a PDF',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'print',
                        text: '<i class="fas fa-print"></i> Imprimir',
                        className: 'btn btn-info btn-sm',
                        titleAttr: 'Imprimir',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'colvis',
                        text: '<i class="fas fa-columns"></i> Columnas',
                        className: 'btn btn-secondary btn-sm',
                        titleAttr: 'Mostrar/Ocultar columnas'
                    }
                ],
                language: {
                    "sProcessing":     "Procesando...",
                    "sLengthMenu":     "Mostrar _MENU_ registros",
                    "sZeroRecords":    "No se encontraron resultados",
                    "sEmptyTable":     "Ningún dato disponible en esta tabla",
                    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                    "sInfoPostFix":    "",
                    "sSearch":         "Buscar:",
                    "sUrl":            "",
                    "sInfoThousands":  ",",
                    "sLoadingRecords": "Cargando...",
                    "oPaginate": {
                        "sFirst":    "Primero",
                        "sLast":     "Último",
                        "sNext":     "Siguiente",
                        "sPrevious": "Anterior"
                    },
                    "oAria": {
                        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                    },
                    "buttons": {
                        "copy": "Copiar",
                        "colvis": "Visibilidad",
                        "collection": "Colección",
                        "colvisRestore": "Restaurar visibilidad",
                        "copyKeys": "Presione ctrl o u2318 + C para copiar los datos de la tabla al portapapeles del sistema. <br><br>Para cancelar, haga clic en este mensaje o presione escape.",
                        "copySuccess": {
                            "1": "Copiada 1 fila al portapapeles",
                            "_": "Copiadas %d filas al portapapeles"
                        },
                        "copyTitle": "Copiar al portapapeles",
                        "csv": "CSV",
                        "excel": "Excel",
                        "pageLength": {
                            "-1": "Mostrar todas las filas",
                            "_": "Mostrar %d filas"
                        },
                        "pdf": "PDF",
                        "print": "Imprimir"
                    }
                }
            });
        }
    }

// Inicializar todas las funcionalidades cuando el DOM esté cargado
    document.addEventListener("DOMContentLoaded", function() {
        // Inicializar funcionalidades existentes

        // Inicializar nuevas funcionalidades
        inicializarEdicionLibros();
        inicializarEliminacionLibros();
        inicializarTablaLibros();
    });
})

