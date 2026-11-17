import React, { useEffect, useMemo, useState } from 'react';
import { MapPin, Info, X, Recycle, Phone, ExternalLink } from 'lucide-react';
import { buscarPontos } from '../services/api';
import './Pesquisa.css';

const ordenar = (lista) => [...lista].sort((a, b) => a.localeCompare(b, 'pt-BR'));

export default function Pesquisa({
  irParaCadastrarPonto,
  categorias,
  materiais,
  pontos,
  materialPontos,
  carregando,
  erro,
  onTentarNovamente,
}) {
  const [categoriaId, setCategoriaId] = useState('');
  const [materialNome, setMaterialNome] = useState('');
  const [estado, setEstado] = useState('');
  const [cidade, setCidade] = useState('');

  const [resultados, setResultados] = useState(null); // null = ainda não buscou
  const [materialBuscado, setMaterialBuscado] = useState(null);
  const [buscando, setBuscando] = useState(false);
  const [erroBusca, setErroBusca] = useState('');
  const [pontoSelecionado, setPontoSelecionado] = useState(null);

  // Fecha o modal com Esc
  useEffect(() => {
    if (!pontoSelecionado) return undefined;
    const onKey = (e) => e.key === 'Escape' && setPontoSelecionado(null);
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [pontoSelecionado]);

  const materiaisDaCategoria = useMemo(
    () => materiais.filter((m) => (categoriaId ? m.categoriaId === Number(categoriaId) : true)),
    [materiais, categoriaId]
  );

  const materialSelecionado = materiais.find((m) => m.nome === materialNome) || null;

  // Só oferece estados/cidades que têm ponto cadastrado para o material escolhido
  const pontosDoMaterial = useMemo(() => {
    if (!materialSelecionado) return [];
    const ids = new Set(
      materialPontos.filter((mp) => mp.materialId === materialSelecionado.id).map((mp) => mp.pontoId)
    );
    return pontos.filter((p) => ids.has(p.id));
  }, [materialSelecionado, materialPontos, pontos]);

  const estados = ordenar([...new Set(pontosDoMaterial.map((p) => p.estado))]);
  const cidades = ordenar([
    ...new Set(pontosDoMaterial.filter((p) => p.estado === estado).map((p) => p.cidade)),
  ]);

  const limparResultado = () => {
    setResultados(null);
    setErroBusca('');
  };

  const escolherCategoria = (id) => {
    setCategoriaId(id);
    setMaterialNome('');
    setEstado('');
    setCidade('');
    limparResultado();
  };

  const escolherMaterial = (nome) => {
    setMaterialNome(nome);
    setEstado('');
    setCidade('');
    limparResultado();
  };

  const escolherEstado = (uf) => {
    setEstado(uf);
    setCidade('');
    limparResultado();
  };

  const limparFiltros = () => escolherCategoria('');

  const podeBuscar = materialNome && estado && cidade && !buscando;

  const handleBuscar = async (e) => {
    e.preventDefault();
    if (!podeBuscar) return;
    setBuscando(true);
    setErroBusca('');
    try {
      const doBackend = await buscarPontos({ cidade, estado, material: materialNome });
      // Pontos cadastrados neste navegador (o backend ainda não os conhece)
      const idsDoMaterial = new Set(
        materialPontos.filter((mp) => mp.materialId === materialSelecionado.id).map((mp) => mp.pontoId)
      );
      const locais = pontos.filter(
        (p) =>
          p.local &&
          p.estado === estado &&
          p.cidade.toLowerCase() === cidade.toLowerCase() &&
          idsDoMaterial.has(p.id)
      );
      setResultados([...doBackend, ...locais]);
      setMaterialBuscado(materialSelecionado);
    } catch (err) {
      setResultados(null);
      setErroBusca(err.message);
    } finally {
      setBuscando(false);
    }
  };

  const nomeCategoria = (id) => categorias.find((c) => c.id === id)?.nome;

  const linkMapa = (p) =>
    `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
      `${p.logradouro}, ${p.numero} - ${p.bairro}, ${p.cidade} - ${p.estado}, ${p.cep}`
    )}`;

  if (carregando) {
    return (
      <div className="container pesquisa-page">
        <p className="subtitle">Carregando categorias e pontos de coleta...</p>
      </div>
    );
  }

  if (erro) {
    return (
      <div className="container pesquisa-page">
        <div className="alert-error">{erro}</div>
        <button className="btn-limpar" onClick={onTentarNovamente}>
          Tentar novamente
        </button>
      </div>
    );
  }

  return (
    <div className="container pesquisa-page">
      {/* Categorias (vindas de /api/categorias) */}
      <section className="categorias-section">
        <h2>Categorias Aceitas no RotaVerde</h2>
        <p className="subtitle">Clique em uma categoria para ver os materiais disponíveis</p>

        <div className="categorias-cards">
          {categorias.map((cat) => (
            <div
              key={cat.id}
              role="button"
              tabIndex={0}
              className={`cat-card ${categoriaId === cat.id ? 'selected' : ''}`}
              onClick={() => escolherCategoria(categoriaId === cat.id ? '' : cat.id)}
              onKeyDown={(e) =>
                (e.key === 'Enter' || e.key === ' ') &&
                escolherCategoria(categoriaId === cat.id ? '' : cat.id)
              }
            >
              <Recycle size={26} color={categoriaId === cat.id ? '#FFFFFF' : '#2E7D32'} />
              <h3>{cat.nome}</h3>
              <p>{cat.descricao}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Filtros: o backend (/api/busca) exige material, estado e cidade */}
      <form className="filtros-box" onSubmit={handleBuscar}>
        <div className="filtro-item">
          <label htmlFor="f-material">Material</label>
          <select
            id="f-material"
            value={materialNome}
            onChange={(e) => escolherMaterial(e.target.value)}
          >
            <option value="">Selecione o material</option>
            {materiaisDaCategoria.map((m) => (
              <option key={m.id} value={m.nome}>
                {m.nome}
              </option>
            ))}
          </select>
        </div>

        <div className="filtro-item">
          <label htmlFor="f-estado">Estado</label>
          <select
            id="f-estado"
            value={estado}
            disabled={!materialNome}
            onChange={(e) => escolherEstado(e.target.value)}
          >
            <option value="">{materialNome ? 'Selecione o estado' : 'Escolha o material'}</option>
            {estados.map((uf) => (
              <option key={uf} value={uf}>
                {uf}
              </option>
            ))}
          </select>
        </div>

        <div className="filtro-item">
          <label htmlFor="f-cidade">Cidade</label>
          <select
            id="f-cidade"
            value={cidade}
            disabled={!estado}
            onChange={(e) => {
              setCidade(e.target.value);
              limparResultado();
            }}
          >
            <option value="">{estado ? 'Selecione a cidade' : 'Escolha o estado'}</option>
            {cidades.map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
          </select>
        </div>

        <div className="filtro-acoes">
          <button type="submit" className="btn-buscar" disabled={!podeBuscar}>
            {buscando ? 'Buscando...' : 'Buscar'}
          </button>
          <button type="button" className="btn-limpar" onClick={limparFiltros}>
            Limpar
          </button>
        </div>
      </form>

      {/* Resultados (vindos de /api/busca) */}
      <section className="lista-pontos">
        {erroBusca && <div className="alert-error">{erroBusca}</div>}

        {resultados === null && !erroBusca && (
          <div className="empty-state">
            <p>Escolha o material, o estado e a cidade e clique em Buscar.</p>
          </div>
        )}

        {resultados !== null && (
          <>
            <h3>Pontos Encontrados ({resultados.length})</h3>
            {resultados.length === 0 ? (
              <div className="empty-state">
                <p>Nenhum ponto de coleta encontrado para este material nesta cidade.</p>
                <button className="btn-add-ponto" onClick={irParaCadastrarPonto}>
                  Cadastrar este ponto agora
                </button>
              </div>
            ) : (
              resultados.map((ponto) => (
                <div key={ponto.id} className="ponto-card">
                  <div>
                    <span className="badge-cat">{materialBuscado?.nome}</span>
                    {ponto.local && <span className="badge-local">Cadastrado neste navegador</span>}
                    <h4>{ponto.nome}</h4>
                    <p className="ponto-end">
                      <MapPin size={16} /> {ponto.logradouro}, {ponto.numero} - {ponto.bairro},{' '}
                      {ponto.cidade}/{ponto.estado}
                    </p>
                  </div>
                  <button className="btn-detalhes" onClick={() => setPontoSelecionado(ponto)}>
                    Ver Detalhes e Descarte
                  </button>
                </div>
              ))
            )}
          </>
        )}
      </section>

      {/* Modal com detalhes do ponto + instrução de descarte do material */}
      {pontoSelecionado && materialBuscado && (
        <div className="modal-backdrop" onClick={() => setPontoSelecionado(null)}>
          <div
            className="mini-tela-modal"
            role="dialog"
            aria-modal="true"
            aria-label="Detalhes do ponto de coleta"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="modal-header">
              <h3>Detalhes do Ponto de Coleta</h3>
              <button
                className="btn-close"
                aria-label="Fechar"
                onClick={() => setPontoSelecionado(null)}
              >
                <X size={22} />
              </button>
            </div>

            <div className="modal-body">
              <div className="info-bloco">
                <span className="info-label">Nome do Local:</span>
                <p className="info-valor destaque">{pontoSelecionado.nome}</p>
              </div>

              <div className="info-bloco">
                <span className="info-label">Material:</span>
                <p className="info-valor">
                  <strong>{materialBuscado.nome}</strong>
                  {nomeCategoria(materialBuscado.categoriaId) &&
                    ` (${nomeCategoria(materialBuscado.categoriaId)})`}
                </p>
                {materialBuscado.descricao && (
                  <p className="info-valor info-secundario">{materialBuscado.descricao}</p>
                )}
              </div>

              <div className="info-bloco">
                <span className="info-label">Local Completo do Descarte:</span>
                <p className="info-valor">
                  {pontoSelecionado.logradouro}, nº {pontoSelecionado.numero} — Bairro{' '}
                  {pontoSelecionado.bairro}
                  <br />
                  {pontoSelecionado.cidade} - {pontoSelecionado.estado} | CEP:{' '}
                  {pontoSelecionado.cep}
                </p>
                <p className="info-valor info-linha">
                  <Phone size={16} /> {pontoSelecionado.telefone}
                </p>
              </div>

              <div className="info-bloco modo-descarte-box">
                <span className="info-label">
                  <Info size={16} /> Modo de Descarte:
                </span>
                <p className="info-valor">
                  {materialBuscado.instrucaoDescarte || 'Sem instruções cadastradas.'}
                </p>
              </div>
            </div>

            <div className="modal-footer">
              <button className="btn-secondary-modal" onClick={() => setPontoSelecionado(null)}>
                Fechar
              </button>
              <a
                className="btn-primary-modal"
                href={linkMapa(pontoSelecionado)}
                target="_blank"
                rel="noreferrer"
              >
                Abrir no mapa <ExternalLink size={14} />
              </a>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
