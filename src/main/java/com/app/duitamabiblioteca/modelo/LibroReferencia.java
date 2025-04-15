package com.app.duitamabiblioteca.modelo;

public class LibroReferencia extends Libro {
    private String campoAcademico;
    private boolean soloConsulta;

    public LibroReferencia(String titulo, int anio, String campoAcademico, boolean soloConsulta) {
        super(titulo, anio);
        this.campoAcademico = campoAcademico;
        this.soloConsulta = soloConsulta;
    }

    public String getCampoAcademico() { return campoAcademico; }
    public void setCampoAcademico(String campoAcademico) { this.campoAcademico = campoAcademico; }
    public boolean isSoloConsulta() { return soloConsulta; }
    public void setSoloConsulta(boolean soloConsulta) { this.soloConsulta = soloConsulta; }

    @Override
    public String getTipo() { return "Referencia"; }

    @Override
    public String getDetalles() {
        return "Campo académico: " + campoAcademico + ", Solo consulta: " + (soloConsulta ? "Sí" : "No");
    }
}