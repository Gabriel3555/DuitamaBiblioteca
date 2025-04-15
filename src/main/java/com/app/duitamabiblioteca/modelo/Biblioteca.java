package com.app.duitamabiblioteca.modelo;

import java.util.ArrayList;

public class Biblioteca {
    private static ArrayList<Libro> libros = new ArrayList<>();

    public static ArrayList<Libro> getLibros() {
        return libros;
    }

    public static void agregarLibro(Libro libro) {
        libros.add(libro);
    }

    public static Libro buscarPorId(int id) {
        for (Libro libro : libros) {
            if (libro.getId() == id) {
                return libro;
            }
        }
        return null;
    }

    public static void eliminarLibro(int id) {
        Libro libro = buscarPorId(id);
        if (libro != null) {
            libros.remove(libro);
        }
    }

    public static void actualizarLibro(Libro libroActualizado) {
        for (int i = 0; i < libros.size(); i++) {
            if (libros.get(i).getId() == libroActualizado.getId()) {
                libros.set(i, libroActualizado);
                break;
            }
        }
    }

    public static void prestarLibro(int id) {
        Libro libro = buscarPorId(id);
        if (libro != null && libro.isDisponible()) {
            libro.setDisponible(false);
        }
    }

    public static void devolverLibro(int id) {
        Libro libro = buscarPorId(id);
        if (libro != null && !libro.isDisponible()) {
            libro.setDisponible(true);
        }
    }
}