# RotaVerde - Frontend

## Sobre o projeto

### Problema
Muitas pessoas não sabem onde nem como descartar corretamente resíduos especiais, como pilhas, baterias, eletrônicos, medicamentos vencidos e óleo usado. O descarte comum no lixo doméstico contamina solo e água e desperdiça materiais reaproveitáveis.

### Solução
O **RotaVerde** é uma aplicação web que conecta o usuário aos **pontos de coleta** da sua cidade. Ele escolhe o material, o estado e a cidade, e o sistema mostra os locais que aceitam aquele material, com endereço, telefone e as **instruções de descarte** específicas para cada item.

### Integrantes
- Miguel de França Monteiro: rm566226
- Isabele Freitas : rm562859
- Gabriel Dantas Borges Soares: rm564860
- João Vitor Lombardi Hayashi: rm563329
- Maria Eduarda Santos Pedro: rm566546

### Arquitetura

```
 Navegador (React)  --HTTP/JSON-->  API Java (HttpServer + Gson)  --JDBC-->  Oracle
   rotaverde-frontend                    GlobalSolution                   (4 tabelas)
```

Este repositório contém o **frontend**. O backend (projeto GlobalSolution) é uma API Java em camadas (`Main` -> `dao` -> banco) que expõe os dados em JSON.

### Modelo de dados (Oracle)

- **CATEGORIA** (id, nome, descrição): Pilhas, Baterias, Eletrônicos, Medicamentos e Óleo.
- **MATERIAL** (id, nome, descrição, instrução de descarte, categoria): cada material pertence a uma categoria e traz o seu modo de descarte.
- **PONTO_COLETA** (id, nome, logradouro, número, bairro, cidade, estado, CEP, telefone).
- **MATERIAL_PONTO** (material, ponto): relação N:N que indica quais pontos aceitam quais materiais.

## Funcionalidades

- **Home:** apresentação do projeto e explicação de como funciona.
- **Categorias e Pesquisa** (dados do backend):
  - lista as categorias cadastradas;
  - filtra por material, estado e cidade (só aparecem estados e cidades que têm ponto para o material escolhido);
  - mostra os pontos encontrados, com endereço, telefone, instruções de descarte e link para o Google Maps.
- **Criar Conta e Login:** cadastro com e-mail, telefone e senha (mínimo de 6 caracteres) e login com validação.
- **Cadastrar Ponto** (exige login): formulário com endereço completo, categoria e os materiais que o ponto recebe. Os pontos cadastrados aparecem na pesquisa com a marca "Cadastrado neste navegador".
- **Tratamento de erros:** mensagem clara e botão "Tentar novamente" quando o backend está fora do ar.

> **Importante:** o backend atual é somente leitura (apenas GET). Por isso **contas, sessão e pontos cadastrados são salvos no `localStorage` do navegador**, e não no Oracle. Eles não são compartilhados entre navegadores e as senhas ficam sem criptografia. É uma simulação para fins didáticos; em produção, isso deve ser feito no backend (endpoints POST, autenticação e senhas com hash).

## Tecnologias

- React 18
- Create React App (`react-scripts` 5)
- lucide-react (ícones)
- CSS puro

## Pré-requisitos

- [Node.js](https://nodejs.org) (versão LTS)
- Backend GlobalSolution rodando em `http://localhost:8080` (veja abaixo)

## Como executar

1. Suba o backend (veja a seção seguinte).
2. No terminal, dentro da pasta do frontend:
   ```bash
   npm install
   npm start
   ```
3. Acesse `http://localhost:3000`.

> Não abra o `public/index.html` direto no navegador: ele é só um molde e a página fica em branco. O projeto precisa ser iniciado com `npm start`.

Na primeira execução, o React pode perguntar se deseja adicionar o `browserslist` ao `package.json`. Responda `Y`.

### Scripts

| Comando         | O que faz                                      |
| --------------- | ---------------------------------------------- |
| `npm start`     | Inicia o servidor de desenvolvimento (porta 3000) |
| `npm run build` | Gera a versão de produção na pasta `build/`    |

## Backend

O frontend consome a API do projeto **GlobalSolution** (Java 21, Oracle, Maven). Para rodar:

1. Crie as tabelas e carregue os dados executando o `Script.sql` no Oracle.
2. Copie `config.example.properties` para `config.properties` e preencha `db.url`, `db.user` e `db.password`.
3. Execute a classe `Main`. O console deve mostrar `Servidor em http://localhost:8080`.

### Endpoints utilizados (todos GET)

| Endpoint                                              | Retorno                                                                  |
| ----------------------------------------------------- | ------------------------------------------------------------------------ |
| `/api/categorias`                                     | `[{ id, nome, descricao }]`                                              |
| `/api/material`                                       | `[{ id, nome, descricao, instrucaoDescarte, categoriaId }]`              |
| `/api/pontocoleta`                                    | `[{ id, nome, logradouro, numero, bairro, cidade, estado, cep, telefone }]` |
| `/api/materialponto`                                  | `[{ materialId, pontoId }]` (quais pontos aceitam quais materiais)       |
| `/api/busca?cidade=...&estado=...&material=...`       | Pontos que aceitam o material na cidade. Os três parâmetros são obrigatórios e `material` é o nome exato. |

Para testar o backend, abra `http://localhost:8080/api/categorias` no navegador: deve aparecer um JSON com as categorias.

### Usando outra URL de backend

Copie `.env.example` para `.env` e altere:

```
REACT_APP_API_URL=http://localhost:8080
```

Reinicie o `npm start` depois de mudar o `.env`.

## Estrutura do projeto

```
rotaverde-frontend/
├── public/
│   └── index.html          # Molde HTML (fontes Google: Inter e Roboto)
├── src/
│   ├── assets/Logo.jsx     # Logo em SVG
│   ├── components/         # Navbar
│   ├── pages/              # Home, Pesquisa, Login, CadastroConta e CadastrarPonto
│   ├── services/api.js     # Chamadas ao backend
│   ├── services/storage.js # Contas, sessão e pontos locais (localStorage)
│   ├── App.jsx             # Navegação entre telas e carga inicial dos dados
│   ├── App.css             # Estilos globais e variáveis de cor
│   └── index.js            # Ponto de entrada
├── .env.example
└── package.json
```

## Problemas comuns

| Sintoma                                                  | O que fazer                                                                                           |
| -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| Página em branco ao abrir `index.html`                   | Rode `npm start` e acesse `http://localhost:3000`.                                                    |
| "Não foi possível conectar ao servidor"                  | O backend não está rodando. Inicie o `Main.java` e confira `http://localhost:8080/api/categorias`.    |
| `{"erro":"Erro ao acessar o banco de dados."}` na API    | Verifique o `config.properties` e se o `Script.sql` foi executado.                                    |
| Categorias aparecem, mas a busca não retorna pontos      | Nem todo material tem ponto cadastrado em todas as cidades. Tente outra combinação.                   |
| Porta 3000 em uso                                        | Aceite a porta sugerida pelo terminal ou encerre o outro processo.                                    |

## Decisões de projeto

- **Filtros dependentes:** o estado e a cidade só listam opções que realmente têm ponto para o material escolhido, evitando buscas sem resultado. O filtro segue a regra do endpoint `/api/busca`, que exige material, estado e cidade.
- **Instrução de descarte por material:** o modo de descarte pertence ao material (e não ao ponto), pois a forma de preparar uma pilha, por exemplo, é a mesma em qualquer local.
- **Sem bibliotecas de rotas ou estado global:** o projeto tem poucas telas, então a navegação usa estado do React.
- **Pontos locais + pontos do backend:** a pesquisa chama `/api/busca` e acrescenta os pontos cadastrados no navegador que atendam ao mesmo filtro.

## Limitações e melhorias futuras

- Login, contas e novos pontos existem só no navegador (veja o aviso em Funcionalidades). Evolução: endpoints POST e autenticação no backend e, depois, trocar o `storage.js` por chamadas à API.
- Não há rotas de URL; a navegação usa estado interno (o botão Voltar do navegador não muda de tela). Evolução: `react-router-dom`.
- Mapa interativo (por exemplo, com Leaflet) em vez do link para o Google Maps.
