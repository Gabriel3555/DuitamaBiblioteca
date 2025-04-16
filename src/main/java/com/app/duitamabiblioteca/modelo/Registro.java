package com.app.duitamabiblioteca.modelo;

import java.util.ArrayList;

public class Registro {
    private static ArrayList<Prestamo> prestamos = new ArrayList<>();

    // Agregar un préstamo
    public static void agregarPrestamo(Prestamo prestamo) {
        prestamos.add(prestamo);
    }

    // Obtener todos los préstamos
    public static ArrayList<Prestamo> obtenerPrestamos() {
        return prestamos;
    }

    // Buscar un préstamo por ISBN
    public static Prestamo buscarPrestamoPorISBN(String isbn) {
        for (Prestamo prestamo : prestamos) {
            if (prestamo.getIsbnLibro().equals(isbn)) {
                return prestamo;
            }
        }
        return null;
    }

    // Actualizar un préstamo
    public static boolean actualizarPrestamo(String isbn, Prestamo prestamoActualizado) {
        for (int i = 0; i < prestamos.size(); i++) {
            if (prestamos.get(i).getIsbnLibro().equals(isbn)) {
                prestamos.set(i, prestamoActualizado);
                return true;
            }
        }
        return false;
    }

    // Eliminar un préstamo
    public static boolean eliminarPrestamo(String isbn) {
        for (int i = 0; i < prestamos.size(); i++) {
            if (prestamos.get(i).getIsbnLibro().equals(isbn)) {
                prestamos.remove(i);
                return true;
            }
        }
        return false;
    }
}