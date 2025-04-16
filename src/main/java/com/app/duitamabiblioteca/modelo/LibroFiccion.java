package com.app.duitamabiblioteca.modelo;

public class LibroFiccion extends Libro {
    private String genero;
    private String premios;

    public LibroFiccion(String titulo, String autor, String isbn, String genero, String premios) {
        super(titulo, autor, isbn);
        this.genero = genero;
        this.premios = premios;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getPremios() {
        return premios;
    }

    public void setPremios(String premios) {
        this.premios = premios;
    }

    @Override
    public String getDetalles() {
        return "Género: " + genero + ", Premios: " + premios;
    }
}