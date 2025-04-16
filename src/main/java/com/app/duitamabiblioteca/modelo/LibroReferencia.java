package com.app.duitamabiblioteca.modelo;

public class LibroReferencia extends Libro {
    private String campoAcademico;
    private boolean prestable;

    public LibroReferencia(String titulo, String autor, String isbn, String campoAcademico, boolean prestable) {
        super(titulo, autor, isbn);
        this.campoAcademico = campoAcademico;
        this.prestable = prestable;
    }

    public String getCampoAcademico() {
        return campoAcademico;
    }

    public void setCampoAcademico(String campoAcademico) {
        this.campoAcademico = campoAcademico;
    }

    public boolean isPrestable() {
        return prestable;
    }

    public void setPrestable(boolean prestable) {
        this.prestable = prestable;
    }

    @Override
    public String getDetalles() {
        return "Campo académico: " + campoAcademico + ", Prestable: " + (prestable ? "Sí" : "No");
    }
}