import React, { useMemo, useState } from 'react';
import { CheckCircle } from 'lucide-react';
import './CadastrarPonto.css';

const ESTADOS = [
  'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA',
  'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO',
];

const FORM_INICIAL = {
  nome: '',
  logradouro: '',
  numero: '',
  bairro: '',
  cidade: '',
  estado: 'SP',
  cep: '',
  telefone: '',
};

export default function CadastrarPonto({ categorias, materiais, onSalvarPonto, irParaPesquisa }) {
  const [cadastradoComSucesso, setCadastradoComSucesso] = useState(false);
  const [formData, setFormData] = useState(FORM_INICIAL);
  const [categoriaId, setCategoriaId] = useState('');
  const [materialIds, setMaterialIds] = useState([]);
  const [erro, setErro] = useState('');

  const materiaisDaCategoria = useMemo(
    () => materiais.filter((m) => m.categoriaId === Number(categoriaId)),
    [materiais, categoriaId]
  );

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const alternarMaterial = (id) =>
    setMaterialIds((prev) => (prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]));

  const handleSubmit = (e) => {
    e.preventDefault();
    if (materialIds.length === 0) {
      setErro('Selecione pelo menos um material que o ponto recebe.');
      return;
    }
    setErro('');
    onSalvarPonto({ ...formData, estado: formData.estado.toUpperCase(), materialIds });
    setFormData(FORM_INICIAL);
    setCategoriaId('');
    setMaterialIds([]);
    setCadastradoComSucesso(true);
  };

  return (
    <div className="container cadastro-ponto-page">
      <div className="cadastro-ponto-card">
        <h2>Cadastrar Novo Ponto de Coleta</h2>
        <p className="subtitle">
          Preencha todas as informações abaixo para disponibilizar o local na plataforma.
        </p>

        {cadastradoComSucesso && (
          <div className="mensagem-sucesso">
            <CheckCircle size={28} />
            <div>
              <strong>Ponto de coleta cadastrado com sucesso</strong>
              <p>O local já está disponível na aba de pesquisa.</p>
            </div>
            <button className="btn-ver-pesquisa" onClick={irParaPesquisa}>
              Ver na Pesquisa
            </button>
          </div>
        )}

        {erro && <div className="alert-error">{erro}</div>}

        <form onSubmit={handleSubmit} className="ponto-form-grid">
          <div className="form-group full-width">
            <label>Nome do Ponto de Coleta *</label>
            <input
              type="text"
              name="nome"
              placeholder="Ex: EcoPonto Mercado Central"
              value={formData.nome}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group span-2">
            <label>Logradouro (Rua / Av.) *</label>
            <input
              type="text"
              name="logradouro"
              placeholder="Ex: Av. Paes de Barros"
              value={formData.logradouro}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group">
            <label>Número *</label>
            <input
              type="text"
              name="numero"
              placeholder="Ex: 1200"
              value={formData.numero}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group">
            <label>Bairro *</label>
            <input
              type="text"
              name="bairro"
              placeholder="Ex: Mooca"
              value={formData.bairro}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group">
            <label>Cidade *</label>
            <input
              type="text"
              name="cidade"
              placeholder="Ex: São Paulo"
              value={formData.cidade}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group">
            <label>Estado *</label>
            <select name="estado" value={formData.estado} onChange={handleChange} required>
              {ESTADOS.map((uf) => (
                <option key={uf} value={uf}>
                  {uf}
                </option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label>CEP *</label>
            <input
              type="text"
              name="cep"
              placeholder="00000-000"
              value={formData.cep}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group">
            <label>Telefone *</label>
            <input
              type="tel"
              name="telefone"
              placeholder="(11) 99999-9999"
              value={formData.telefone}
              onChange={handleChange}
              required
            />
          </div>

          <div className="form-group">
            <label>Categoria *</label>
            <select
              value={categoriaId}
              onChange={(e) => {
                setCategoriaId(e.target.value);
                setMaterialIds([]);
              }}
              required
            >
              <option value="">Selecione a categoria</option>
              {categorias.map((cat) => (
                <option key={cat.id} value={cat.id}>
                  {cat.nome}
                </option>
              ))}
            </select>
          </div>

          <div className="form-group full-width">
            <label>Materiais que Recebe * ({materialIds.length} selecionado(s))</label>
            <div className="materiais-checks">
              {!categoriaId && (
                <span className="materiais-vazio">Escolha uma categoria para ver os materiais.</span>
              )}
              {materiaisDaCategoria.map((m) => (
                <label key={m.id}>
                  <input
                    type="checkbox"
                    checked={materialIds.includes(m.id)}
                    onChange={() => alternarMaterial(m.id)}
                  />
                  {m.nome}
                </label>
              ))}
            </div>
          </div>

          <div className="form-actions full-width">
            <button type="submit" className="btn-salvar-ponto">
              Cadastrar Ponto de Coleta
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
