import React from 'react';
import { Search, MapPin, PlusCircle, Recycle } from 'lucide-react';
import './Home.css';

export default function Home({ irParaPesquisa, irParaCadastrarPonto }) {
  return (
    <div className="home-page">
      <section className="hero-section">
        <div className="container hero-grid">
          {/* Painel Esquerdo */}
          <div className="hero-left">
            <span className="tag-slogan">Descarte consciente a um clique de você</span>
            <h1>A Revolução do Descarte Consciente no Brasil.</h1>
            <p className="hero-description">
              O <strong>RotaVerde</strong> é uma plataforma colaborativa desenvolvida para conectar
              você aos pontos de coleta corretos na sua cidade e estado. Nossa missão é acabar com
              a dúvida na hora de descartar materiais recicláveis, eletrônicos, pilhas e resíduos
              especiais.
            </p>

            <div className="hero-actions">
              <button className="btn-primary-large" onClick={irParaPesquisa}>
                <Search size={20} />
                Pesquisar Pontos de Coleta
              </button>
              <button className="btn-secondary-large" onClick={irParaCadastrarPonto}>
                <PlusCircle size={20} />
                Cadastrar um Ponto
              </button>
            </div>
          </div>

          {/* Painel Direito - Como Funciona */}
          <div className="hero-right">
            <h2>Como o RotaVerde Funciona?</h2>
            <div className="steps-grid">
              <div className="step-card">
                <div className="step-icon blue">
                  <Search size={28} />
                </div>
                <div>
                  <h3>1. Escolha o Material e Local</h3>
                  <p>
                    Selecione a categoria e o material, depois o seu estado e cidade para encontrar
                    os pontos que aceitam o que você quer descartar.
                  </p>
                </div>
              </div>

              <div className="step-card">
                <div className="step-icon green">
                  <Recycle size={28} />
                </div>
                <div>
                  <h3>2. Veja o Modo de Descarte</h3>
                  <p>
                    Clique no ponto encontrado para abrir os detalhes completos: endereço, telefone e
                    as instruções de como preparar o material antes de entregar.
                  </p>
                </div>
              </div>

              <div className="step-card">
                <div className="step-icon dark-blue">
                  <MapPin size={28} />
                </div>
                <div>
                  <h3>3. Colabore com a Comunidade</h3>
                  <p>
                    Conhece um ecoponto ou mercado que recebe materiais? Crie sua conta gratuitamente
                    e cadastre novos locais.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
