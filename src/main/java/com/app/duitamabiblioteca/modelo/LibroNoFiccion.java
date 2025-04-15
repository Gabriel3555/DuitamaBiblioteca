package com.app.duitamabiblioteca.modelo;

public class LibroNoFiccion extends Libro {
    private String areaTematica;
    private String publicoObjetivo;

    public LibroNoFiccion(String titulo, int anio, String areaTematica, String publicoObjetivo) {
        super(titulo, anio);
        this.areaTematica = areaTematica;
        this.publicoObjetivo = publicoObjetivo;
    }

    public String getAreaTematica() { return areaTematica; }
    public void setAreaTematica(String areaTematica) { this.areaTematica = areaTematica; }
    public String getPublicoObjetivo() { return publicoObjetivo; }
    public void setPublicoObjetivo(String publicoObjetivo) { this.publicoObjetivo = publicoObjetivo; }

    @Override
    public String getTipo() { return "No Ficción"; }

    @Override
    public String getDetalles() {
        return "Área temática: " + areaTematica + ", Público objetivo: " + publicoObjetivo;
    }
}