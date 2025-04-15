package com.app.duitamabiblioteca.modelo;

public class LibroFiccion extends Libro {
    private String genero;
    private String autor;
    private String premiosLiterarios;

    public LibroFiccion(String titulo, int anio, String genero, String autor, String premiosLiterarios) {
        super(titulo, anio);
        this.genero = genero;
        this.autor = autor;
        this.premiosLiterarios = premiosLiterarios;
    }

    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }
    public String getAutor() { return autor; }
    public void setAutor(String autor) { this.autor = autor; }
    public String getPremiosLiterarios() { return premiosLiterarios; }
    public void setPremiosLiterarios(String premiosLiterarios) { this.premiosLiterarios = premiosLiterarios; }

    @Override
    public String getTipo() { return "Ficción"; }

    @Override
    public String getDetalles() {
        return "Género: " + genero + ", Autor: " + autor + ", Premios: " + premiosLiterarios;
    }
}