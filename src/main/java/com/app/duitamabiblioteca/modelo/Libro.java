package com.app.duitamabiblioteca.modelo;

public abstract class Libro {
    private static int contador = 1;
    private int id;
    private String titulo;
    private int anio;
    private boolean disponible;

    public Libro(String titulo, int anio) {
        this.id = contador++;
        this.titulo = titulo;
        this.anio = anio;
        this.disponible = true;
    }

    public int getId() { return id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public int getAnio() { return anio; }
    public void setAnio(int anio) { this.anio = anio; }
    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }

    public abstract String getTipo();
    public abstract String getDetalles();
}