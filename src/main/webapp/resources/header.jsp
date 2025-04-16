<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca Municipal de Duitama</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.4.1/css/responsive.dataTables.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.4.1/js/dataTables.responsive.min.js"></script>

    <!-- Exportación PDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/vfs_fonts.js"></script>

    <!-- Exportación Excel -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>

    <!-- Impresión -->
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Estilos personalizados -->
    <style>
        .btn-soft-danger {
            background-color: #fbe9e7;
            color: #e53935;
            border-color: #ffcdd2;
        }
        .btn-soft-danger:hover {
            background-color: #ffcdd2;
            color: #c62828;
        }

        .btn-soft-success {
            background-color: #e6f4ea;
            color: #34a853;
            border-color: #ceead6;
        }
        .btn-soft-success:hover {
            background-color: #ceead6;
            color: #2d9249;
        }

        .btn-soft-info {
            background-color: #e8f0fe;
            color: #4285f4;
            border-color: #d0e0fc;
        }
        .btn-soft-info:hover {
            background-color: #d0e0fc;
            color: #2a75f3;
        }

        /* Ajustes para los botones de DataTables */
        .dt-buttons .btn {
            margin-right: 5px;
            border-radius: 4px;
            padding: 6px 12px;
            font-size: 14px;
        }

        /* Asegurar que los iconos se muestren correctamente */
        .dt-buttons .btn i {
            margin-right: 5px;
        }

        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .navbar {
            background-color: var(--primary-color) !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .navbar-brand i {
            margin-right: 8px;
            color: var(--secondary-color);
        }

        .nav-link {
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--secondary-color) !important;
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .dropdown-item:hover {
            background-color: var(--light-color);
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .btn-primary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
        }

        .btn-success {
            background-color: #2ecc71;
            border-color: #2ecc71;
        }

        .btn-success:hover {
            background-color: #27ae60;
            border-color: #27ae60;
        }

        .btn-danger {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }

        .btn-danger:hover {
            background-color: #c0392b;
            border-color: #c0392b;
        }

        .btn-warning {
            background-color: #f39c12;
            border-color: #f39c12;
            color: white;
        }

        .btn-warning:hover {
            background-color: #d35400;
            border-color: #d35400;
            color: white;
        }

        footer {
            background-color: var(--primary-color) !important;
            color: white;
            padding: 20px 0;
            margin-top: 50px;
        }

        .page-header {
            background-color: var(--light-color);
            padding: 30px 0;
            margin-bottom: 30px;
            border-radius: 0 0 10px 10px;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        /* DataTables styling */
        table.dataTable thead {
            background-color: var(--primary-color);
            color: white;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            background: var(--secondary-color) !important;
            color: white !important;
            border: none !important;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
            background: var(--light-color) !important;
            color: var(--dark-color) !important;
            border: none !important;
        }

        .btn-excel {
            background-color: #27ae60 !important;
            color: white !important;
            border: none !important;
        }

        .btn-excel:hover {
            background-color: #2ecc71 !important;
        }

        .btn-print {
            background-color: var(--secondary-color) !important;
            color: white !important;
            border: none !important;
        }

        .btn-print:hover {
            background-color: #2980b9 !important;
        }

        /* Hero section */
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 80px 0;
            border-radius: 0 0 20px 20px;
            margin-bottom: 50px;
        }

        .hero-section h1 {
            font-weight: 700;
            font-size: 3rem;
            margin-bottom: 20px;
        }

        .hero-section p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        /* Feature cards */
        .feature-card {
            text-align: center;
            padding: 30px;
            height: 100%;
        }

        .feature-card i {
            font-size: 3rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i class="fas fa-book-open"></i> Biblioteca Municipal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="fas fa-home"></i> Inicio</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="librosDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-book"></i> Libros
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="librosDropdown">
                        <li><a class="dropdown-item" href="listarLibros.jsp"><i class="fas fa-list"></i> Listar Libros</a></li>
                        <li><a class="dropdown-item" href="agregarLibro.jsp"><i class="fas fa-plus"></i> Agregar Libro</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="prestamosDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-handshake"></i> Préstamos
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="prestamosDropdown">
                        <li><a class="dropdown-item" href="listarPrestamos.jsp"><i class="fas fa-list"></i> Listar Préstamos</a></li>
                        <li><a class="dropdown-item" href="registrarPrestamo.jsp"><i class="fas fa-plus"></i> Registrar Préstamo</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>