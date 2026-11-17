package model;

public class MaterialPonto {
    private int materialId; //FK
    private int pontoId; //FK

    public MaterialPonto(){

    }
    public MaterialPonto(int materialId, int pontoId){
        this.materialId = materialId;
        this.pontoId = pontoId;
    }
    public int getMaterialId() {
        return materialId;
    }
    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }
    public int getPontoId() {
        return pontoId;
    }
    public void setPontoId(int pontoId) {
        this.pontoId = pontoId;
    }

    @Override
    public String toString() {
        return "MaterialPonto {" + "materialId=" + materialId + ", pontoId=" + pontoId + '}';
    }
}
