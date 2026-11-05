package model;

public class Material {

    private int id;
    private String nome;
    private String descricao;
    private String instrucaoDescarte;
    private int categoriaId; // FK

    //construtor vazio
    public Material (){

    }
    //construtor completo
    public Material (int id, String nome, String descricao, String instrucaoDescarte, int categoriaId) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.instrucaoDescarte = instrucaoDescarte;
        this.categoriaId = categoriaId;
    }
    //getters e setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    public String getInstrucaoDescarte() {
        return instrucaoDescarte;
    }
    public void setInstrucaoDescarte(String instrucaoDescarte) {
        this.instrucaoDescarte = instrucaoDescarte;
    }
    public int getCategoriaId() {
        return categoriaId;
    }
    public void setCategoriaId(int categoriaId) {
        this.categoriaId = categoriaId;
    }

    @Override
    public String toString() {
        return "Material {" + "id=" + id +
                ", nome='" + nome + '\'' +
                ", descricao='" + descricao + '\'' +
                ", instrucaoDescarte='" + instrucaoDescarte + '\'' +
                ", categoriaId=" + categoriaId + '}';
    }
}

