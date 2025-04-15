// DOM Elements
document.addEventListener("DOMContentLoaded", () => {
    // Navigation
    const navLinks = document.querySelectorAll(".navbar-nav .nav-link")
    const sections = document.querySelectorAll(".container > section")
    const btnToAdd = document.getElementById("btn-to-add")
    const btnToLoans = document.getElementById("btn-to-loans")

    // Book Form
    const bookForm = document.getElementById("book-form")
    const bookTypeSelect = document.getElementById("book-type")
    const dynamicFields = document.getElementById("dynamic-fields")
    const btnResetForm = document.getElementById("btn-reset-form")

    // Book List
    const searchCatalog = document.getElementById("search-catalog")
    const filterType = document.getElementById("filter-type")
    const filterAvailability = document.getElementById("filter-availability")
    const booksTableBody = document.getElementById("books-table-body")

    // Quick Search
    const quickSearch = document.getElementById("quick-search")
    const btnQuickSearch = document.getElementById("btn-quick-search")
    const quickResults = document.getElementById("quick-results")

    // Modals
    const bookDetailsModal = new bootstrap.Modal(document.getElementById("bookDetailsModal"))
    const editBookModal = new bootstrap.Modal(document.getElementById("editBookModal"))
    const returnBookModal = new bootstrap.Modal(document.getElementById("returnBookModal"))
    const confirmationModal = new bootstrap.Modal(document.getElementById("confirmationModal"))

    // Toast
    const toast = new bootstrap.Toast(document.getElementById("liveToast"))

    // Data Storage (simulating database)
    let books = []
    let loans = []
    let patrons = []
    const activities = []

    // Initialize with sample data
    initializeSampleData()
    updateStats()
    updateRecentActivity()

    // Navigation Event Listeners
    navLinks.forEach((link) => {
        link.addEventListener("click", function (e) {
            e.preventDefault()

            // Update active nav link
            navLinks.forEach((l) => l.classList.remove("active"))
            this.classList.add("active")

            // Show corresponding section
            const targetId = this.id.replace("nav-", "") + "-section"
            sections.forEach((section) => {
                section.classList.add("d-none")
                section.classList.remove("section-active")
            })
            document.getElementById(targetId).classList.remove("d-none")
            document.getElementById(targetId).classList.add("section-active")

            // Update content based on section
            if (targetId === "list-section") {
                renderBooksList()
            } else if (targetId === "loans-section") {
                renderActiveLoans()
            }
        })
    })

    // Home page buttons
    btnToAdd.addEventListener("click", () => {
        document.getElementById("nav-add").click()
    })

    btnToLoans.addEventListener("click", () => {
        document.getElementById("nav-loans").click()
    })

    // Book Type Change - Dynamic Fields
    bookTypeSelect.addEventListener("change", function () {
        generateDynamicFields(this.value, dynamicFields)
    })

    // Edit Book Type Change
    document.getElementById("edit-book-type").addEventListener("change", function () {
        generateDynamicFields(this.value, document.getElementById("edit-dynamic-fields"))
    })

    // Reset Form Button
    btnResetForm.addEventListener("click", () => {
        bookForm.reset()
        dynamicFields.innerHTML = ""
    })

    // Book Form Submit
    bookForm.addEventListener("submit", function (e) {
        e.preventDefault()

        // Validate form
        if (!this.checkValidity()) {
            e.stopPropagation()
            this.classList.add("was-validated")
            return
        }

        // Get form data
        const newBook = {
            id: generateId(),
            isbn: document.getElementById("book-isbn").value,
            title: document.getElementById("book-title").value,
            author: document.getElementById("book-author").value,
            year: document.getElementById("book-year").value,
            publisher: document.getElementById("book-publisher").value,
            type: document.getElementById("book-type").value,
            description: document.getElementById("book-description").value,
            copies: Number.parseInt(document.getElementById("book-copies").value),
            availableCopies: Number.parseInt(document.getElementById("book-copies").value),
            location: document.getElementById("book-location").value,
            cover:
                document.getElementById("book-cover").files.length > 0
                    ? URL.createObjectURL(document.getElementById("book-cover").files[0])
                    : "/placeholder.svg?height=200&width=150",
            specificDetails: getSpecificDetails(document.getElementById("book-type").value),
        }

        // Add book to collection
        books.push(newBook)

        // Add to recent activity
        addActivity(`Libro agregado: "${newBook.title}" por ${newBook.author}`)

        // Show success message
        showToast("Éxito", "Libro agregado correctamente", "success")

        // Reset form
        bookForm.reset()
        dynamicFields.innerHTML = ""
        bookForm.classList.remove("was-validated")

        // Update stats
        updateStats()
    })

    // Quick Search
    btnQuickSearch.addEventListener("click", performQuickSearch)
    quickSearch.addEventListener("keyup", (e) => {
        if (e.key === "Enter") {
            performQuickSearch()
        }
    })

    // Catalog Search and Filters
    document.getElementById("btn-search-catalog").addEventListener("click", () => {
        renderBooksList()
    })

    searchCatalog.addEventListener("keyup", (e) => {
        if (e.key === "Enter") {
            renderBooksList()
        }
    })

    filterType.addEventListener("change", renderBooksList)
    filterAvailability.addEventListener("change", renderBooksList)

    // Loan Form
    document.getElementById("loan-form").addEventListener("submit", function (e) {
        e.preventDefault()

        // Validate form
        if (!this.checkValidity()) {
            e.stopPropagation()
            this.classList.add("was-validated")
            return
        }

        // Get form data
        const newLoan = {
            id: generateId(),
            patronId: document.getElementById("patron-id").value,
            patronName: document.getElementById("patron-name").value,
            bookId: document.getElementById("book-id-loan").value,
            bookTitle: document.getElementById("book-title-loan").value,
            loanDate: document.getElementById("loan-date").value,
            returnDate: document.getElementById("return-date").value,
            actualReturnDate: null,
            status: "active",
        }

        // Find book and update available copies
        const book = books.find((b) => b.isbn === newLoan.bookId)
        if (book && book.availableCopies > 0) {
            book.availableCopies--

            // Add loan to collection
            loans.push(newLoan)

            // Add to recent activity
            addActivity(`Préstamo registrado: "${book.title}" a ${newLoan.patronName}`)

            // Show success message
            showToast("Éxito", "Préstamo registrado correctamente", "success")

            // Reset form
            this.reset()
            document.getElementById("patron-name").value = ""
            document.getElementById("book-title-loan").value = ""
            this.classList.remove("was-validated")

            // Update stats and loans list
            updateStats()
            renderActiveLoans()
        } else {
            showToast("Error", "No hay copias disponibles de este libro", "danger")
        }
    })

    // Search Patron Button
    document.getElementById("btn-search-patron").addEventListener("click", () => {
        const patronId = document.getElementById("patron-id").value
        const patron = patrons.find((p) => p.id === patronId)

        if (patron) {
            document.getElementById("patron-name").value = patron.name
        } else {
            document.getElementById("patron-name").value = ""
            showToast("Información", "Usuario no encontrado", "warning")
        }
    })

    // Search Book Button
    document.getElementById("btn-search-book").addEventListener("click", () => {
        const bookId = document.getElementById("book-id-loan").value
        const book = books.find((b) => b.isbn === bookId)

        if (book) {
            if (book.availableCopies > 0) {
                document.getElementById("book-title-loan").value = book.title
            } else {
                document.getElementById("book-title-loan").value = ""
                showToast("Información", "No hay copias disponibles de este libro", "warning")
            }
        } else {
            document.getElementById("book-title-loan").value = ""
            showToast("Información", "Libro no encontrado", "warning")
        }
    })

    // Edit Book Button (in modal)
    document.getElementById("btn-edit-book").addEventListener("click", () => {
        const bookId = document.getElementById("modal-book-isbn").textContent
        const book = books.find((b) => b.isbn === bookId)

        if (book) {
            // Fill edit form
            document.getElementById("edit-book-id").value = book.id
            document.getElementById("edit-book-isbn").value = book.isbn
            document.getElementById("edit-book-title").value = book.title
            document.getElementById("edit-book-author").value = book.author
            document.getElementById("edit-book-year").value = book.year
            document.getElementById("edit-book-publisher").value = book.publisher
            document.getElementById("edit-book-type").value = book.type
            document.getElementById("edit-book-description").value = book.description
            document.getElementById("edit-book-copies").value = book.copies
            document.getElementById("edit-book-location").value = book.location

            // Generate dynamic fields
            generateDynamicFields(book.type, document.getElementById("edit-dynamic-fields"), book.specificDetails)

            // Hide book details modal and show edit modal
            bookDetailsModal.hide()
            editBookModal.show()
        }
    })

    // Save Edit Button
    document.getElementById("btn-save-edit").addEventListener("click", () => {
        const bookId = document.getElementById("edit-book-id").value
        const bookIndex = books.findIndex((b) => b.id === bookId)

        if (bookIndex !== -1) {
            const updatedBook = {
                id: bookId,
                isbn: document.getElementById("edit-book-isbn").value,
                title: document.getElementById("edit-book-title").value,
                author: document.getElementById("edit-book-author").value,
                year: document.getElementById("edit-book-year").value,
                publisher: document.getElementById("edit-book-publisher").value,
                type: document.getElementById("edit-book-type").value,
                description: document.getElementById("edit-book-description").value,
                copies: Number.parseInt(document.getElementById("edit-book-copies").value),
                availableCopies: books[bookIndex].availableCopies,
                location: document.getElementById("edit-book-location").value,
                cover:
                    document.getElementById("edit-book-cover").files.length > 0
                        ? URL.createObjectURL(document.getElementById("edit-book-cover").files[0])
                        : books[bookIndex].cover,
                specificDetails: getSpecificDetails(document.getElementById("edit-book-type").value),
            }

            // Update book
            books[bookIndex] = updatedBook

            // Add to recent activity
            addActivity(`Libro actualizado: "${updatedBook.title}"`)

            // Show success message
            showToast("Éxito", "Libro actualizado correctamente", "success")

            // Hide modal and update book list
            editBookModal.hide()
            renderBooksList()
        }
    })

    // Delete Book Button
    document.getElementById("btn-delete-book").addEventListener("click", () => {
        const bookId = document.getElementById("edit-book-id").value

        // Set up confirmation modal
        document.getElementById("confirmation-title").textContent = "Eliminar Libro"
        document.getElementById("confirmation-message").textContent =
            "¿Está seguro que desea eliminar este libro? Esta acción no se puede deshacer."

        // Set up confirm button
        document.getElementById("btn-confirm").onclick = () => {
            const bookIndex = books.findIndex((b) => b.id === bookId)

            if (bookIndex !== -1) {
                const deletedBook = books[bookIndex]

                // Check if book has active loans
                const activeLoans = loans.filter((l) => l.bookId === deletedBook.isbn && l.status === "active")

                if (activeLoans.length > 0) {
                    showToast("Error", "No se puede eliminar un libro con préstamos activos", "danger")
                } else {
                    // Remove book
                    books.splice(bookIndex, 1)

                    // Add to recent activity
                    addActivity(`Libro eliminado: "${deletedBook.title}"`)

                    // Show success message
                    showToast("Éxito", "Libro eliminado correctamente", "success")

                    // Update book list
                    renderBooksList()
                    updateStats()
                }
            }

            // Hide modals
            confirmationModal.hide()
            editBookModal.hide()
        }

        // Show confirmation modal
        confirmationModal.show()
    })

    // Loan Book Button (in modal)
    document.getElementById("btn-loan-book").addEventListener("click", () => {
        const bookId = document.getElementById("modal-book-isbn").textContent
        const book = books.find((b) => b.isbn === bookId)

        if (book && book.availableCopies > 0) {
            // Fill loan form
            document.getElementById("book-id-loan").value = book.isbn
            document.getElementById("book-title-loan").value = book.title

            // Hide book details modal
            bookDetailsModal.hide()

            // Navigate to loans section and select new loan tab
            document.getElementById("nav-loans").click()
            document.getElementById("new-loan-tab").click()

            // Focus on patron ID field
            document.getElementById("patron-id").focus()
        } else {
            showToast("Información", "No hay copias disponibles de este libro", "warning")
        }
    })

    // Return Book Button (in active loans)
    document.addEventListener("click", (e) => {
        if (e.target && e.target.classList.contains("btn-return-loan")) {
            const loanId = e.target.getAttribute("data-loan-id")
            const loan = loans.find((l) => l.id === loanId)

            if (loan) {
                // Fill return form
                document.getElementById("return-loan-id").value = loan.id
                document.getElementById("return-book-title").textContent = loan.bookTitle
                document.getElementById("return-patron-name").textContent = loan.patronName
                document.getElementById("return-loan-date").textContent = formatDate(loan.loanDate)
                document.getElementById("return-expected-date").textContent = formatDate(loan.returnDate)
                document.getElementById("return-actual-date").value = getCurrentDate()

                // Show return modal
                returnBookModal.show()
            }
        }
    })

    // Save Return Button
    document.getElementById("btn-save-return").addEventListener("click", () => {
        const loanId = document.getElementById("return-loan-id").value
        const loanIndex = loans.findIndex((l) => l.id === loanId)

        if (loanIndex !== -1) {
            const loan = loans[loanIndex]
            const book = books.find((b) => b.isbn === loan.bookId)

            // Update loan
            loan.actualReturnDate = document.getElementById("return-actual-date").value
            loan.condition = document.getElementById("return-condition").value
            loan.notes = document.getElementById("return-notes").value
            loan.status = "returned"

            // Update book available copies
            if (book && loan.condition !== "lost") {
                book.availableCopies++
            }

            // Add to recent activity
            addActivity(`Libro devuelto: "${loan.bookTitle}" por ${loan.patronName}`)

            // Show success message
            showToast("Éxito", "Devolución registrada correctamente", "success")

            // Hide modal and update loans list
            returnBookModal.hide()
            renderActiveLoans()
            updateStats()
        }
    })

    // View Book Details (in book list)
    document.addEventListener("click", (e) => {
        if (e.target && e.target.classList.contains("btn-view-book")) {
            const bookId = e.target.getAttribute("data-book-id")
            const book = books.find((b) => b.isbn === bookId)

            if (book) {
                // Fill modal with book details
                document.getElementById("modal-book-title").textContent = "Detalles del Libro"
                document.getElementById("modal-book-title-header").textContent = book.title
                document.getElementById("modal-book-author").textContent = book.author
                document.getElementById("modal-book-isbn").textContent = book.isbn
                document.getElementById("modal-book-type").textContent = getBookTypeName(book.type)
                document.getElementById("modal-book-year").textContent = book.year
                document.getElementById("modal-book-publisher").textContent = book.publisher
                document.getElementById("modal-book-location").textContent = book.location
                document.getElementById("modal-book-description").textContent = book.description
                document.getElementById("modal-book-cover").src = book.cover

                // Set availability badge
                const availabilityBadge = document.getElementById("modal-book-availability")
                if (book.availableCopies > 0) {
                    availabilityBadge.textContent = "Disponible"
                    availabilityBadge.className = "badge bg-success mb-2"
                    document.getElementById("btn-loan-book").disabled = false
                } else {
                    availabilityBadge.textContent = "No Disponible"
                    availabilityBadge.className = "badge bg-danger mb-2"
                    document.getElementById("btn-loan-book").disabled = true
                }

                // Set copies text
                document.getElementById("modal-book-copies").textContent =
                    `${book.availableCopies} de ${book.copies} copias disponibles`

                // Set specific details
                const specificDetailsContainer = document.getElementById("modal-book-specific-details")
                specificDetailsContainer.innerHTML = ""

                if (book.specificDetails) {
                    const detailsTitle = document.createElement("h5")
                    detailsTitle.textContent = "Detalles Específicos"
                    specificDetailsContainer.appendChild(detailsTitle)

                    const detailsList = document.createElement("ul")
                    detailsList.className = "list-group list-group-flush"

                    for (const [key, value] of Object.entries(book.specificDetails)) {
                        const item = document.createElement("li")
                        item.className = "list-group-item"
                        item.innerHTML = `<strong>${formatFieldName(key)}:</strong> ${value}`
                        detailsList.appendChild(item)
                    }

                    specificDetailsContainer.appendChild(detailsList)
                }

                // Show modal
                bookDetailsModal.show()
            }
        }
    })

    // Initialize with sample data
    function initializeSampleData() {
        // Sample books
        books = [
            {
                id: generateId(),
                isbn: "9780061120084",
                title: "Matar a un ruiseñor",
                author: "Harper Lee",
                year: "1960",
                publisher: "J. B. Lippincott & Co.",
                type: "ficcion",
                description:
                    "Una historia sobre la injusticia racial y la pérdida de la inocencia en el sur de Estados Unidos.",
                copies: 5,
                availableCopies: 3,
                location: "Estante A-12",
                cover: "/placeholder.svg?height=200&width=150",
                specificDetails: {
                    genero: "Novela",
                    premios: "Premio Pulitzer",
                    audiencia: "Adultos",
                },
            },
            {
                id: generateId(),
                isbn: "9780307474278",
                title: "El Principito",
                author: "Antoine de Saint-Exupéry",
                year: "1943",
                publisher: "Reynal & Hitchcock",
                type: "ficcion",
                description: "Una fábula filosófica sobre la naturaleza humana y las relaciones.",
                copies: 3,
                availableCopies: 2,
                location: "Estante B-05",
                cover: "/placeholder.svg?height=200&width=150",
                specificDetails: {
                    genero: "Fábula",
                    premios: "Ninguno",
                    audiencia: "Todas las edades",
                },
            },
            {
                id: generateId(),
                isbn: "9780553211404",
                title: "Breve historia del tiempo",
                author: "Stephen Hawking",
                year: "1988",
                publisher: "Bantam Books",
                type: "no-ficcion",
                description: "Un libro de divulgación científica sobre cosmología.",
                copies: 2,
                availableCopies: 1,
                location: "Estante C-08",
                cover: "/placeholder.svg?height=200&width=150",
                specificDetails: {
                    area: "Ciencia",
                    publico: "General",
                    nivel: "Intermedio",
                },
            },
            {
                id: generateId(),
                isbn: "9780198501053",
                title: "Diccionario Oxford de Matemáticas",
                author: "James Nicholson",
                year: "2009",
                publisher: "Oxford University Press",
                type: "referencia",
                description: "Un diccionario completo de términos matemáticos.",
                copies: 1,
                availableCopies: 0,
                location: "Estante D-01",
                cover: "/placeholder.svg?height=200&width=150",
                specificDetails: {
                    campo: "Matemáticas",
                    prestable: "No",
                    edicion: "2da Edición",
                },
            },
        ]

        // Sample patrons
        patrons = [
            {
                id: "P001",
                name: "Juan Pérez",
                email: "juan.perez@email.com",
                phone: "3001234567",
            },
            {
                id: "P002",
                name: "María López",
                email: "maria.lopez@email.com",
                phone: "3109876543",
            },
            {
                id: "P003",
                name: "Carlos Rodríguez",
                email: "carlos.rodriguez@email.com",
                phone: "3207654321",
            },
        ]

        // Sample loans
        loans = [
            {
                id: generateId(),
                patronId: "P001",
                patronName: "Juan Pérez",
                bookId: "9780198501053",
                bookTitle: "Diccionario Oxford de Matemáticas",
                loanDate: "2023-05-01",
                returnDate: "2023-05-15",
                actualReturnDate: null,
                status: "active",
            },
            {
                id: generateId(),
                patronId: "P002",
                patronName: "María López",
                bookId: "9780061120084",
                bookTitle: "Matar a un ruiseñor",
                loanDate: "2023-04-20",
                returnDate: "2023-05-04",
                actualReturnDate: "2023-05-03",
                status: "returned",
            },
        ]
    }

    // Render books list
    function renderBooksList() {
        const searchTerm = searchCatalog.value.toLowerCase()
        const typeFilter = filterType.value
        const availabilityFilter = filterAvailability.value

        // Filter books
        const filteredBooks = books.filter((book) => {
            // Search term filter
            const matchesSearch =
                book.title.toLowerCase().includes(searchTerm) ||
                book.author.toLowerCase().includes(searchTerm) ||
                book.isbn.includes(searchTerm)

            // Type filter
            const matchesType = typeFilter === "all" || book.type === typeFilter

            // Availability filter
            const matchesAvailability =
                availabilityFilter === "all" ||
                (availabilityFilter === "available" && book.availableCopies > 0) ||
                (availabilityFilter === "loaned" && book.availableCopies === 0)

            return matchesSearch && matchesType && matchesAvailability
        })

        // Clear table
        booksTableBody.innerHTML = ""

        // Check if no books found
        if (filteredBooks.length === 0) {
            booksTableBody.innerHTML = `
        <tr class="text-center text-muted">
          <td colspan="6">No se encontraron libros con los criterios de búsqueda</td>
        </tr>
      `
            return
        }

        // Render books
        filteredBooks.forEach((book) => {
            const row = document.createElement("tr")

            row.innerHTML = `
        <td>${book.isbn}</td>
        <td>${book.title}</td>
        <td>${book.author}</td>
        <td>${getBookTypeName(book.type)}</td>
        <td>
          <span class="badge ${book.availableCopies > 0 ? "bg-success" : "bg-danger"}">
            ${book.availableCopies > 0 ? "Disponible" : "No disponible"}
          </span>
        </td>
        <td>
          <button class="btn btn-sm btn-primary btn-view-book" data-book-id="${book.isbn}">
            <i class="bi bi-eye"></i>
          </button>
        </td>
      `

            booksTableBody.appendChild(row)
        })
    }

    // Render active loans
    function renderActiveLoans() {
        const activeLoansTable = document.getElementById("active-loans-table")
        const activeLoansOnly = loans.filter((loan) => loan.status === "active")

        // Clear table
        activeLoansTable.innerHTML = ""

        // Check if no active loans
        if (activeLoansOnly.length === 0) {
            activeLoansTable.innerHTML = `
        <tr class="text-center text-muted">
          <td colspan="7">No hay préstamos activos</td>
        </tr>
      `
            return
        }

        // Render loans
        activeLoansOnly.forEach((loan) => {
            const row = document.createElement("tr")

            row.innerHTML = `
        <td>${loan.id}</td>
        <td>${loan.patronName}</td>
        <td>${loan.bookTitle}</td>
        <td>${formatDate(loan.loanDate)}</td>
        <td>${formatDate(loan.returnDate)}</td>
        <td>
          <span class="badge ${isOverdue(loan.returnDate) ? "bg-danger" : "bg-warning"}">
            ${isOverdue(loan.returnDate) ? "Vencido" : "Activo"}
          </span>
        </td>
        <td>
          <button class="btn btn-sm btn-success btn-return-loan" data-loan-id="${loan.id}">
            <i class="bi bi-check-circle"></i> Devolver
          </button>
        </td>
      `

            activeLoansTable.appendChild(row)
        })
    }

    // Perform quick search
    function performQuickSearch() {
        const searchTerm = quickSearch.value.toLowerCase()

        if (searchTerm.trim() === "") {
            quickResults.innerHTML = `
        <div class="quick-results-placeholder text-center text-muted">
          <i class="bi bi-search display-4"></i>
          <p>Los resultados de búsqueda aparecerán aquí</p>
        </div>
      `
            return
        }

        // Filter books
        const filteredBooks = books
            .filter(
                (book) =>
                    book.title.toLowerCase().includes(searchTerm) ||
                    book.author.toLowerCase().includes(searchTerm) ||
                    book.isbn.includes(searchTerm),
            )
            .slice(0, 3) // Limit to 3 results

        // Clear results
        quickResults.innerHTML = ""

        // Check if no books found
        if (filteredBooks.length === 0) {
            quickResults.innerHTML = `
        <div class="text-center text-muted">
          <p>No se encontraron libros con el término "${searchTerm}"</p>
        </div>
      `
            return
        }

        // Create results list
        const resultsList = document.createElement("ul")
        resultsList.className = "list-group"

        filteredBooks.forEach((book) => {
            const item = document.createElement("li")
            item.className = "list-group-item d-flex justify-content-between align-items-center"

            item.innerHTML = `
        <div>
          <h6 class="mb-0">${book.title}</h6>
          <small class="text-muted">${book.author}</small>
        </div>
        <span class="badge ${book.availableCopies > 0 ? "bg-success" : "bg-danger"} rounded-pill">
          ${book.availableCopies} / ${book.copies}
        </span>
      `

            item.addEventListener("click", () => {
                // Fill modal with book details and show it
                document.getElementById("modal-book-title").textContent = "Detalles del Libro"
                document.getElementById("modal-book-title-header").textContent = book.title
                document.getElementById("modal-book-author").textContent = book.author
                document.getElementById("modal-book-isbn").textContent = book.isbn
                document.getElementById("modal-book-type").textContent = getBookTypeName(book.type)
                document.getElementById("modal-book-year").textContent = book.year
                document.getElementById("modal-book-publisher").textContent = book.publisher
                document.getElementById("modal-book-location").textContent = book.location
                document.getElementById("modal-book-description").textContent = book.description
                document.getElementById("modal-book-cover").src = book.cover

                // Set availability badge
                const availabilityBadge = document.getElementById("modal-book-availability")
                if (book.availableCopies > 0) {
                    availabilityBadge.textContent = "Disponible"
                    availabilityBadge.className = "badge bg-success mb-2"
                    document.getElementById("btn-loan-book").disabled = false
                } else {
                    availabilityBadge.textContent = "No Disponible"
                    availabilityBadge.className = "badge bg-danger mb-2"
                    document.getElementById("btn-loan-book").disabled = true
                }

                // Set copies text
                document.getElementById("modal-book-copies").textContent =
                    `${book.availableCopies} de ${book.copies} copias disponibles`

                // Set specific details
                const specificDetailsContainer = document.getElementById("modal-book-specific-details")
                specificDetailsContainer.innerHTML = ""

                if (book.specificDetails) {
                    const detailsTitle = document.createElement("h5")
                    detailsTitle.textContent = "Detalles Específicos"
                    specificDetailsContainer.appendChild(detailsTitle)

                    const detailsList = document.createElement("ul")
                    detailsList.className = "list-group list-group-flush"

                    for (const [key, value] of Object.entries(book.specificDetails)) {
                        const item = document.createElement("li")
                        item.className = "list-group-item"
                        item.innerHTML = `<strong>${formatFieldName(key)}:</strong> ${value}`
                        detailsList.appendChild(item)
                    }

                    specificDetailsContainer.appendChild(detailsList)
                }

                // Show modal
                bookDetailsModal.show()
            })

            resultsList.appendChild(item)
        })

        quickResults.appendChild(resultsList)
    }

    // Generate dynamic fields based on book type
    function generateDynamicFields(bookType, container, values = {}) {
        // Clear container
        container.innerHTML = ""

        // Create fields based on book type
        if (bookType === "ficcion") {
            container.innerHTML = `
        <div class="row">
          <div class="col-md-4">
            <label for="book-genre" class="form-label">Género</label>
            <input type="text" class="form-control" id="book-genre" value="${values.genero || ""}">
          </div>
          <div class="col-md-4">
            <label for="book-awards" class="form-label">Premios</label>
            <input type="text" class="form-control" id="book-awards" value="${values.premios || ""}">
          </div>
          <div class="col-md-4">
            <label for="book-audience" class="form-label">Audiencia</label>
            <select class="form-select" id="book-audience">
              <option value="Niños" ${values.audiencia === "Niños" ? "selected" : ""}>Niños</option>
              <option value="Jóvenes" ${values.audiencia === "Jóvenes" ? "selected" : ""}>Jóvenes</option>
              <option value="Adultos" ${values.audiencia === "Adultos" ? "selected" : ""}>Adultos</option>
              <option value="Todas las edades" ${values.audiencia === "Todas las edades" ? "selected" : ""}>Todas las edades</option>
            </select>
          </div>
        </div>
      `
        } else if (bookType === "no-ficcion") {
            container.innerHTML = `
        <div class="row">
          <div class="col-md-4">
            <label for="book-area" class="form-label">Área Temática</label>
            <input type="text" class="form-control" id="book-area" value="${values.area || ""}">
          </div>
          <div class="col-md-4">
            <label for="book-public" class="form-label">Público Objetivo</label>
            <input type="text" class="form-control" id="book-public" value="${values.publico || ""}">
          </div>
          <div class="col-md-4">
            <label for="book-level" class="form-label">Nivel</label>
            <select class="form-select" id="book-level">
              <option value="Básico" ${values.nivel === "Básico" ? "selected" : ""}>Básico</option>
              <option value="Intermedio" ${values.nivel === "Intermedio" ? "selected" : ""}>Intermedio</option>
              <option value="Avanzado" ${values.nivel === "Avanzado" ? "selected" : ""}>Avanzado</option>
            </select>
          </div>
        </div>
      `
        } else if (bookType === "referencia") {
            container.innerHTML = `
        <div class="row">
          <div class="col-md-4">
            <label for="book-field" class="form-label">Campo Académico</label>
            <input type="text" class="form-control" id="book-field" value="${values.campo || ""}">
          </div>
          <div class="col-md-4">
            <label for="book-loanable" class="form-label">¿Puede ser prestado?</label>
            <select class="form-select" id="book-loanable">
              <option value="Sí" ${values.prestable === "Sí" ? "selected" : ""}>Sí</option>
              <option value="No" ${values.prestable === "No" ? "selected" : ""}>No</option>
            </select>
          </div>
          <div class="col-md-4">
            <label for="book-edition" class="form-label">Edición</label>
            <input type="text" class="form-control" id="book-edition" value="${values.edicion || ""}">
          </div>
        </div>
      `
        }
    }

    // Get specific details from form based on book type
    function getSpecificDetails(bookType) {
        if (bookType === "ficcion") {
            return {
                genero: document.getElementById("book-genre")?.value || "",
                premios: document.getElementById("book-awards")?.value || "",
                audiencia: document.getElementById("book-audience")?.value || "Todas las edades",
            }
        } else if (bookType === "no-ficcion") {
            return {
                area: document.getElementById("book-area")?.value || "",
                publico: document.getElementById("book-public")?.value || "",
                nivel: document.getElementById("book-level")?.value || "Intermedio",
            }
        } else if (bookType === "referencia") {
            return {
                campo: document.getElementById("book-field")?.value || "",
                prestable: document.getElementById("book-loanable")?.value || "No",
                edicion: document.getElementById("book-edition")?.value || "",
            }
        }

        return {}
    }

    // Update statistics
    function updateStats() {
        document.getElementById("total-books").textContent = books.length

        const availableBooks = books.reduce((total, book) => total + book.availableCopies, 0)
        document.getElementById("available-books").textContent = availableBooks

        const activeLoansCount = loans.filter((loan) => loan.status === "active").length
        document.getElementById("active-loans").textContent = activeLoansCount
    }

    // Add activity to recent activity list
    function addActivity(activity) {
        const now = new Date()
        activities.unshift({
            text: activity,
            timestamp: now,
        })

        // Keep only the last 10 activities
        if (activities.length > 10) {
            activities.pop()
        }

        updateRecentActivity()
    }

    // Update recent activity list
    function updateRecentActivity() {
        const recentActivityList = document.getElementById("recent-activity")

        // Clear list
        recentActivityList.innerHTML = ""

        // Check if no activities
        if (activities.length === 0) {
            recentActivityList.innerHTML = `
        <li class="list-group-item text-center text-muted">No hay actividad reciente</li>
      `
            return
        }

        // Render activities
        activities.forEach((activity) => {
            const item = document.createElement("li")
            item.className = "list-group-item"

            item.innerHTML = `
        <div class="d-flex justify-content-between">
          <span>${activity.text}</span>
          <small class="text-muted">${formatDateTime(activity.timestamp)}</small>
        </div>
      `

            recentActivityList.appendChild(item)
        })
    }

    // Show toast notification
    function showToast(title, message, type = "primary") {
        const toastTitle = document.getElementById("toast-title")
        const toastMessage = document.getElementById("toast-message")
        const toastElement = document.getElementById("liveToast")

        // Set toast content
        toastTitle.textContent = title
        toastMessage.textContent = message

        // Set toast type
        toastElement.className = `toast hide border-${type}`

        // Show toast
        toast.show()
    }

    // Helper functions
    function generateId() {
        return Math.random().toString(36).substring(2, 10)
    }

    function formatDate(dateString) {
        const date = new Date(dateString)
        return date.toLocaleDateString("es-ES")
    }

    function formatDateTime(date) {
        return date.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit" })
    }

    function getCurrentDate() {
        const now = new Date()
        return now.toISOString().split("T")[0]
    }

    function isOverdue(returnDate) {
        const today = new Date()
        const returnDateObj = new Date(returnDate)
        return returnDateObj < today
    }

    function getBookTypeName(type) {
        switch (type) {
            case "ficcion":
                return "Ficción"
            case "no-ficcion":
                return "No Ficción"
            case "referencia":
                return "Referencia"
            default:
                return type
        }
    }

    function formatFieldName(fieldName) {
        // Capitalize first letter and replace camelCase with spaces
        return fieldName.charAt(0).toUpperCase() + fieldName.slice(1).replace(/([A-Z])/g, " $1")
    }
})
