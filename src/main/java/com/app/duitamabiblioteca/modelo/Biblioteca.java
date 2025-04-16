package com.app.duitamabiblioteca.modelo;

import java.util.ArrayList;

public class Biblioteca {
    // Atributo estático para almacenar los libros
    private static ArrayList<Libro> libros = new ArrayList<>();

    static {
        libros.add(new LibroFiccion("El Hobbit", "J.R.R. Tolkien", "12345", "Fantasía", "Premio Hugo"));
        libros.add(new LibroFiccion("Cien Años de Soledad", "Gabriel García Márquez", "67890", "Realismo Mágico", "Premio Nobel"));
        libros.add(new LibroNoFiccion("Sapiens", "Yuval Noah Harari", "11223", "Historia", "Adultos"));
        libros.add(new LibroNoFiccion("El Gen Egoísta", "Richard Dawkins", "33445", "Ciencia", "Jóvenes y Adultos"));
        libros.add(new LibroReferencia("Diccionario de la RAE", "Real Academia Española", "55667", "Lenguaje", false));
        libros.add(new LibroReferencia("Enciclopedia Británica", "Varios Autores", "77889", "General", true));
    }

    // Método para agregar un libro
    public static void agregarLibro(Libro libro) {
        libros.add(libro);
    }

    // Método para obtener la lista de libros
    public static ArrayList<Libro> obtenerLibros() {
        return libros;
    }

    // Método para buscar un libro por ISBN
    public static Libro buscarLibroPorISBN(String isbn) {
        for (Libro libro : libros) {
            if (libro.getIsbn().equals(isbn)) {
                return libro;
            }
        }
        return null; // Si no se encuentra el libro
    }

    // Método para actualizar un libro
    public static boolean actualizarLibro(String isbn, Libro libroActualizado) {
        for (int i = 0; i < libros.size(); i++) {
            if (libros.get(i).getIsbn().equals(isbn)) {
                libros.set(i, libroActualizado);
                return true; // Actualización exitosa
            }
        }
        return false; // No se encontró el libro
    }

    // Método para eliminar un libro
    public static boolean eliminarLibro(String isbn) {
        for (int i = 0; i < libros.size(); i++) {
            if (libros.get(i).getIsbn().equals(isbn)) {
                libros.remove(i);
                return true; // Eliminación exitosa
            }
        }
        return false; // No se encontró el libro
    }

    // Método para procesar un préstamo de libro
    public static boolean prestarLibro(String isbn) {
        Libro libro = buscarLibroPorISBN(isbn);
        if (libro instanceof LibroReferencia) {
            LibroReferencia libroReferencia = (LibroReferencia) libro;
            if (!libroReferencia.isPrestable()) {
                return false; // No se puede prestar un libro de referencia no prestable
            }
        }
        return libros.remove(libro); // Elimina el libro de la lista (simula el préstamo)
    }

    // Método para devolver un libro
    public static void devolverLibro(Libro libro) {
        libros.add(libro); // Agrega el libro de nuevo a la lista
    }
}