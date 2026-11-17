

CRIACAO DAS TABELAS

CREATE TABLE CATEGORIA (
                           ID          NUMBER          NOT NULL,
                           NOME        VARCHAR2(200)   NOT NULL,
                           DESCRICAO   VARCHAR2(500),
                           CONSTRAINT PK_CATEGORIA PRIMARY KEY (ID),
                           CONSTRAINT UQ_CATEGORIA_NOME UNIQUE (NOME)
);

CREATE TABLE PONTO_COLETA (
                              ID          NUMBER          NOT NULL,
                              NOME        VARCHAR2(200)   NOT NULL,
                              LOGRADOURO  VARCHAR2(255),
                              NUMERO      VARCHAR2(30),
                              BAIRRO      VARCHAR2(100),
                              CIDADE      VARCHAR2(100),
                              ESTADO      VARCHAR2(2),
                              CEP         VARCHAR2(20),
                              TELEFONE    VARCHAR2(20),
                              CONSTRAINT PK_PONTO_COLETA PRIMARY KEY (ID),
                              CONSTRAINT UQ_PONTO_COLETA_NOME UNIQUE (NOME)
);

CREATE TABLE MATERIAL (
                          ID                  NUMBER          NOT NULL,
                          NOME                VARCHAR2(200)   NOT NULL,
                          DESCRICAO           VARCHAR2(500),
                          INSTRUCAO_DESCARTE  VARCHAR2(1000),
                          CATEGORIA_ID        NUMBER          NOT NULL,
                          CONSTRAINT PK_MATERIAL PRIMARY KEY (ID),
                          CONSTRAINT UQ_MATERIAL_NOME UNIQUE (NOME),
                          CONSTRAINT FK_MATERIAL_CATEGORIA
                              FOREIGN KEY (CATEGORIA_ID) REFERENCES CATEGORIA (ID)
);

CREATE TABLE MATERIAL_PONTO (
                                MATERIAL_ID NUMBER NOT NULL,
                                PONTO_ID    NUMBER NOT NULL,
                                CONSTRAINT PK_MATERIAL_PONTO PRIMARY KEY (MATERIAL_ID, PONTO_ID),
                                CONSTRAINT FK_MATERIAL_PONTO_MATERIAL
                                    FOREIGN KEY (MATERIAL_ID) REFERENCES MATERIAL (ID),
                                CONSTRAINT FK_MATERIAL_PONTO_PONTO
                                    FOREIGN KEY (PONTO_ID) REFERENCES PONTO_COLETA (ID)
);

-- Indices para consultas pelas chaves estrangeiras.
CREATE INDEX IX_MATERIAL_CATEGORIA ON MATERIAL (CATEGORIA_ID);
CREATE INDEX IX_MATERIAL_PONTO_PONTO ON MATERIAL_PONTO (PONTO_ID);

-- ---------------------------------------------------------------------
--SEQUENCES PARA GERACAO DOS IDS
-- ---------------------------------------------------------------------

CREATE SEQUENCE SEQ_CATEGORIA START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_PONTO_COLETA START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_MATERIAL START WITH 1 INCREMENT BY 1 NOCACHE;

-- ---------------------------------------------------------------------
--INFO DAS CATEGORIAS
-- ---------------------------------------------------------------------

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Pilhas', 'Descarte de pilhas usadas');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Baterias', 'Descarte de baterias usadas');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Eletrônicos', 'Descarte de equipamentos eletrônicos');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Medicamentos', 'Descarte de medicamentos vencidos');

INSERT INTO CATEGORIA (ID, NOME, DESCRICAO)
VALUES(SEQ_CATEGORIA.NEXTVAL, 'Óleo', 'Descarte de óleos usados');

-- ---------------------------------------------------------------------
--CADASTRO DOS PONTOS DE COLETA
-- ---------------------------------------------------------------------

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Descarte Correto', 'Rua João Gomes', '244', 'Novo Aleixo', 'Manaus', 'AM', '69058-579', '(92) 99132-7981');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Drivethru Ambiental', 'Av. Efigênio Salles', '1299', 'Parque Dez', 'Manaus', 'AM', '69060-020','(92) 98236-3056');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Boulevard Shopping Belém', 'Av. Visconde de Souza Franco', '776', 'Reduto', 'Belém', 'PA', '66053-000', '(91) 3299-0500');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Recicle Logística Reversa', 'Rua Guanabara', '03', 'Amaralina', 'Salvador', 'BA', '41900-405', '(71) 99709-2027');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'REEECicle', 'Rua Professor Mussa Hazin', '108', 'Iputinga', 'Recife', 'PE', '52171-011', '(81) 99833-8771');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'EletroDescarte Ambiental', 'Rua Lauro de Souza', '44', 'Campo Grande', 'Recife', 'PE', '52040-370', '(81) 98879-3242');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Zero Impacto', 'SAAN, Quadra 2', 'Lote 805', 'SAAN', 'Brasília', 'DF', '70632-250', '(61) 3301-3584');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Lixos Eletrônicos DF', 'Rua 3C, Lote 22', 'Loja 03', 'Vicente Pires', 'Brasília', 'DF', '72005-505', '(61) 98192-7985');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Sucateiro Digital', 'Rua 115-C', '208', 'Setor Sul', 'Goiânia', 'GO', '74085-270', '(62) 98494-0183');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Coopermiti', 'Rua João Rudge', '366', 'Casa Verde', 'São Paulo', 'SP', '02513-020', '(11) 3666-0849');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Eletro Recicle', 'Praça Albino Francisco de Figueiredo', '19', 'Vila Fernandes', 'São Paulo', 'SP', '03433-040', '(11) 99187-4137');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'Ecoleve Soluções Ambientais', 'Rua Lisandro Torre', '06', 'Jardim Santa Margarida', 'São Paulo', 'SP', '04931-130', '(11) 94044-8278');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'DMT Reciclagem', 'Rua José Hauer', '1228', 'Boqueirão', 'Curitiba', 'PR', '81730-400', '(41) 99763-1822');

INSERT INTO PONTO_COLETA (ID, NOME, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, TELEFONE)
VALUES (SEQ_PONTO_COLETA.NEXTVAL, 'DMLU – Ecoponto Centro', 'Av. Alberto Bins', '667', 'Centro Histórico', 'Porto Alegre', 'RS', '90030-142', '(51) 3226-1950');

-- ---------------------------------------------------------------------
--CADASTRO DOS MATERIAIS
-- ---------------------------------------------------------------------

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha alcalina AA',
       'Pilha cilíndrica alcalina tamanho AA, comum em controles, brinquedos, lanternas e relógios maiores.',
       'Retire a pilha do aparelho quando isso puder ser feito sem desmontar ou danificar o equipamento. Guarde-a em local seco, fresco e fora do alcance de crianças; mantenha os polos sem contato com moedas, chaves ou outras pilhas. Leve a um coletor que aceite pilhas usadas. Não abra, amasse, queime, molhe nem descarte no lixo comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha alcalina AAA',
       'Pilha cilíndrica alcalina menor, usada em controles remotos, mouses, brinquedos e pequenos aparelhos.',
       'Retire a pilha sem forçar o compartimento e armazene-a seca, longe de calor e umidade. Evite deixar os polos encostarem em objetos metálicos; transporte em embalagem firme. Entregue em ponto de coleta de pilhas. Não misture com lixo reciclável comum nem descarte em ralos ou no solo.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha tamanho C',
       'Pilha cilíndrica média, encontrada em lanternas, brinquedos e equipamentos portáteis.',
       'Desligue o aparelho e remova a pilha apenas se o compartimento for acessível. Armazene em recipiente seco, protegido contra impactos e sem contato entre polos e metais. Leve a um ponto que receba pilhas. Não tente recarregar pilhas descartáveis, perfurá-las ou desmontá-las.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha tamanho D',
       'Pilha cilíndrica grande, comum em lanternas potentes, rádios e brinquedos.',
       'Retire com o aparelho desligado e evite danificar o revestimento. Mantenha as pilhas em local seco e fresco, sem contato com objetos metálicos. Entregue em coletor de pilhas, confirmando previamente se aceita esse tamanho. Nunca queime, abra ou descarte no lixo doméstico.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha alcalina 9V',
       'Pilha retangular de 9 volts, usada em detectores, brinquedos e alguns instrumentos.',
       'Proteja os dois terminais com fita isolante para evitar curto-circuito, especialmente durante o transporte. Guarde separadamente, em local seco e longe de calor. Leve a um ponto de coleta de pilhas. Não coloque solta junto de moedas, chaves ou outras pilhas.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha botão/moeda',
       'Pilha pequena e achatada, frequentemente usada em relógios, calculadoras, balanças e controles; pode conter diferentes químicas.',
       'Mantenha fora do alcance de crianças e animais, pois a ingestão é uma emergência médica. Guarde em embalagem fechada e seca, sem deixar várias unidades soltas. Entregue em ponto que aceite pilhas tipo botão/moeda e informe se houver vazamento. Não abra nem descarte no lixo comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha zinco-carbono',
       'Pilha descartável cilíndrica, geralmente identificada como comum ou heavy duty, utilizada em aparelhos de baixo consumo.',
       'Retire do equipamento quando possível e armazene em local seco, sem calor excessivo e sem contato dos polos com metais. Encaminhe a coletor de pilhas usadas; confirme se o programa recebe pilhas zinco-carbono. Não tente recarregar, perfurar ou abrir.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pilha recarregável NiMH',
       'Pilha cilíndrica recarregável de níquel-hidreto metálico, comum em câmeras, brinquedos e controles.',
       'Não descarte junto com pilhas comuns nem tente recuperar uma unidade danificada. Armazene seca e protegida contra curto-circuito; se houver aquecimento, deformação ou vazamento, evite manusear e peça orientação ao coletor. Entregue em ponto que receba pilhas recarregáveis NiMH.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Pilhas';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de celular removível',
       'Bateria recarregável removível, geralmente de íons de lítio, usada em celulares de modelos antigos e alguns aparelhos.',
       'Desligue o celular e retire a bateria somente se o modelo permitir remoção normal, sem ferramentas ou força. Isole os contatos com fita não condutiva e transporte individualmente, protegida contra perfuração e calor. Entregue em ponto que aceite baterias de lítio. Se estiver estufada, quente ou danificada, não a comprima nem tente removê-la: procure orientação especializada.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria interna de smartphone',
       'Bateria de íons de lítio integrada ao smartphone, normalmente não removível pelo usuário.',
       'Não abra o aparelho nem tente retirar a bateria. Faça backup e apague seus dados pessoais, se o celular ainda funcionar, e entregue o aparelho inteiro a um ponto de coleta de eletrônicos que aceite equipamentos com bateria interna. Avise sobre bateria estufada, aquecimento ou dano; não envie pelo correio nem transporte uma unidade danificada sem orientação.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de notebook',
       'Bateria recarregável de notebook, removível ou integrada, geralmente de íons de lítio.',
       'Desligue o notebook e desconecte o carregador. Remova a bateria apenas quando ela for projetada para remoção pelo usuário; não abra o conjunto. Proteja os terminais contra contato metálico e leve a ponto que aceite baterias de lítio ou notebooks. Se houver inchaço, vazamento ou aquecimento, não pressione, perfure ou carregue; solicite orientação especializada.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de tablet',
       'Bateria recarregável, normalmente interna e de íons de lítio, presente em tablets.',
       'Não tente desmontar o tablet para retirar a bateria. Desligue o equipamento, remova contas e dados pessoais quando possível e leve-o inteiro a uma coleta de eletrônicos que aceite dispositivos com bateria. Informe qualquer estufamento ou dano e não coloque o aparelho em lixo comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de câmera fotográfica',
       'Bateria recarregável usada em câmeras digitais, filmadoras e acessórios fotográficos.',
       'Desligue a câmera, retire a bateria se o compartimento for próprio para o usuário e cubra os contatos com fita isolante quando indicado pelo fabricante ou pelo coletor. Guarde em estojo seco, protegida de impactos, e entregue em ponto que aceite baterias recarregáveis. Não misture com pilhas soltas ou objetos metálicos.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de ferramenta sem fio',
       'Bateria removível de furadeira, parafusadeira, serra e outras ferramentas elétricas portáteis.',
       'Retire a bateria com a ferramenta desligada e sem carregador conectado. Proteja os terminais contra curto-circuito, não abra o invólucro e não armazene perto de calor ou materiais inflamáveis. Leve a ponto que aceite baterias de ferramentas, informando a tecnologia se souber. Se estiver trincada, estufada ou aquecendo, não carregue nem transporte sem orientação.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria automotiva chumbo-ácido',
       'Bateria de partida de carro, geralmente pesada, com eletrólito corrosivo e chumbo.',
       'Não abra, incline, perfure ou tente retirar o líquido. Por ser pesada e conter substâncias corrosivas, prefira devolver a bateria ao estabelecimento que vendeu a nova, oficina ou revendedor que receba baterias automotivas. Mantenha-a na posição vertical e protegida contra tombamento; não transporte se estiver rachada ou vazando sem orientação especializada.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de motocicleta',
       'Bateria de partida de motocicleta, que pode ser chumbo-ácido ou de outra tecnologia.',
       'Confira a tecnologia no rótulo e não abra nem perfure a bateria. Mantenha-a na posição correta, protegida contra tombamento e vazamento. Devolva em loja de baterias, oficina ou ponto que confirme receber baterias de motocicleta. Avise previamente se estiver danificada ou vazando.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de nobreak/UPS',
       'Bateria usada em nobreaks e sistemas de energia ininterrupta, frequentemente chumbo-ácido selada.',
       'Desligue o equipamento da tomada e siga o manual para retirada; não abra o módulo nem toque nos terminais com ferramentas metálicas. Se a bateria for substituída por assistência técnica, peça que a antiga seja encaminhada corretamente. Caso leve por conta própria, confirme que o ponto recebe baterias estacionárias de nobreak.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Bateria de bicicleta elétrica',
       'Bateria recarregável de maior capacidade, normalmente de lítio, usada em bicicletas e equipamentos de mobilidade elétrica.',
       'Desligue e remova somente conforme o manual, sem forçar conectores ou abrir a carcaça. Proteja os contatos e evite impactos, água e calor. Procure fabricante, assistência ou reciclador que aceite baterias de mobilidade elétrica. Se estiver estufada, perfurada, molhada ou aquecendo, isole a área e peça instruções antes de mover.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Baterias';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Celular',
       'Aparelho móvel que reúne placa eletrônica, tela, metais, plásticos e, em geral, bateria integrada.',
       'Faça backup do que deseja guardar, saia das contas, remova chip e cartão de memória e restaure as configurações de fábrica, quando possível. Desligue o aparelho e entregue-o inteiro em ponto de coleta de eletrônicos que aceite celulares. Não quebre a tela nem tente retirar a bateria interna; informe se estiver estufada ou danificada.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Notebook',
       'Computador portátil com tela e bateria, composto por placas, metais, plásticos e componentes eletrônicos.',
       'Faça backup e apague dados pessoais; saia das contas e remova cartões e acessórios externos. Desligue, desconecte o carregador e transporte protegido contra quedas. Entregue em ponto que aceite computadores portáteis. Não desmonte nem descarte a bateria separadamente, a menos que seja removível e haja coleta específica.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Computador desktop',
       'Computador de mesa composto por gabinete, placa-mãe, processador, memória, fonte e outros componentes.',
       'Desligue e desconecte todos os cabos. Apague ou remova o armazenamento com segurança, se necessário, e separe monitor, teclado e mouse apenas para facilitar o transporte. Leve a ponto que aceite computadores e periféricos. Não quebre placas, fonte ou componentes; confirme se o coletor recebe equipamentos completos.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Monitor',
       'Tela de computador, que pode ser LCD, LED ou tecnologia mais antiga, com componentes eletrônicos e materiais diversos.',
       'Desconecte da energia e dos cabos, embale para evitar quebra e mantenha longe de umidade. Entregue em ponto que aceite monitores e telas. Não quebre o painel nem retire componentes internos; se for um modelo antigo ou muito pesado, confirme previamente as condições de recebimento.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Televisor',
       'Aparelho de televisão, incluindo modelos LED, LCD, plasma ou tubo, com componentes eletrônicos e tela.',
       'Desconecte da tomada e embale com proteção para a tela, sem pressioná-la. Procure ponto de logística reversa, fabricante, varejista ou ecoponto que receba televisores do tipo e tamanho correspondente. Não quebre a tela nem deixe o aparelho na calçada; confirme se há retirada para equipamentos grandes.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Tablet',
       'Dispositivo portátil com tela sensível ao toque e bateria interna.',
       'Faça backup, remova contas e dados pessoais e restaure o aparelho, se possível. Desligue e leve inteiro a ponto que aceite tablets e eletrônicos com bateria. Não tente abrir ou separar a bateria integrada; avise o coletor se houver estufamento ou dano.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Teclado',
       'Periférico de computador, com teclas e circuitos internos, com ou sem fio.',
       'Desconecte o cabo ou desligue o teclado sem fio. Retire pilhas ou bateria somente se o compartimento for acessível e encaminhe-as separadamente para coleta de pilhas/baterias. Entregue o teclado em ponto de eletrônicos que receba periféricos; não o coloque no reciclável comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Mouse',
       'Periférico apontador com fio ou sem fio, com componentes plásticos e eletrônicos.',
       'Desconecte o cabo ou desligue o mouse. Se utilizar pilha removível, retire-a e entregue-a em coletor de pilhas. Leve o mouse a ponto de recebimento de eletrônicos/periféricos. Não abra, quebre ou descarte no lixo comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Carregador de celular',
       'Fonte de alimentação usada para carregar celulares e outros dispositivos.',
       'Desconecte da tomada e separe o cabo, se forem peças independentes. Guarde sem enrolar ou dobrar os fios com força e entregue em coletor de pequenos eletrônicos. Não corte o cabo para separar materiais nem descarte no lixo reciclável comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Fonte de alimentação de computador',
       'Componente que converte energia elétrica para alimentar as peças de um computador desktop.',
       'Desligue o computador e retire o cabo da tomada antes de qualquer movimentação. Não abra a fonte, mesmo desligada, pois pode conter componentes que armazenam carga elétrica. Encaminhe a um ponto que receba peças e componentes de informática.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Cabos USB, HDMI e similares',
       'Cabos de conexão e transmissão de dados ou energia, com fios metálicos, isolamento plástico e conectores.',
       'Desconecte das duas pontas, enrole sem apertar e junte em um feixe ou caixa para evitar emaranhamento. Leve a ponto de coleta de eletrônicos que aceite cabos e fios. Não queime, descasque ou corte os cabos para retirar metais.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Impressora',
       'Equipamento de impressão com circuitos, motores e, em alguns modelos, cartuchos ou toners.',
       'Desligue e desconecte da tomada. Retire cartuchos ou toner apenas conforme o manual e encaminhe-os a um programa específico de devolução, quando disponível; não abra nem sacuda o toner. Entregue a impressora em ponto que aceite periféricos e equipamentos de informática.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Roteador Wi-Fi',
       'Equipamento de rede que distribui conexão de internet por cabo ou sinal sem fio.',
       'Desconecte a fonte de energia e os cabos. Restaure as configurações de fábrica se houver dados de acesso salvos; devolva fonte e acessórios junto, quando o coletor aceitar. Encaminhe a ponto de pequenos eletrônicos. Se tiver bateria interna, informe ao coletor.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Modem',
       'Equipamento que conecta a residência ou empresa à rede de internet.',
       'Desconecte da energia e dos cabos. Verifique se pertence à operadora; em caso afirmativo, consulte a devolução do equipamento antes de descartá-lo. Se for próprio, entregue em ponto que aceite equipamentos de telecomunicações, junto da fonte quando permitido.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Câmera digital',
       'Câmera fotográfica eletrônica com sensor, placa e, normalmente, bateria recarregável.',
       'Apague fotos e dados pessoais e remova cartão de memória. Desligue e retire a bateria apenas se ela for removível pelo usuário; encaminhe a bateria separadamente a coletor compatível. Entregue a câmera em ponto de eletrônicos e não a desmonte.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Fone de ouvido',
       'Acessório de áudio com fio ou Bluetooth, podendo ter bateria interna em modelos sem fio.',
       'Desconecte o cabo ou desligue o fone. Não abra modelos Bluetooth para retirar a bateria; entregue o conjunto em ponto que aceite pequenos eletrônicos e dispositivos com bateria interna. Proteja contra umidade e evite quebrar ou queimar o produto.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Eletrônicos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Comprimidos',
       'Medicamentos sólidos em forma de comprimidos, vencidos ou que não serão mais utilizados.',
       'Mantenha os comprimidos na cartela ou embalagem original, sem triturar, dissolver ou misturar com outros produtos. Separe-os dos resíduos recicláveis e leve a uma farmácia ou unidade de saúde com coleta de medicamentos domiciliares. Não jogue no vaso sanitário, pia ou lixo comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Cápsulas',
       'Medicamentos em cápsulas, incluindo cápsulas gelatinosas ou de pó, fora do prazo ou sem uso.',
       'Não abra as cápsulas nem despeje o conteúdo no ralo ou no lixo. Mantenha-as na embalagem original e leve a um ponto de coleta de medicamentos. Siga a orientação do estabelecimento sobre descarte da embalagem externa; não misture com comprimidos soltos ou alimentos.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Xaropes',
       'Medicamentos líquidos de uso oral, normalmente acondicionados em frascos.',
       'Mantenha o líquido no frasco original, bem fechado, e coloque-o em saco ou recipiente secundário para evitar vazamentos durante o transporte. Não despeje na pia, vaso sanitário ou solo. Entregue em farmácia ou serviço que aceite medicamentos líquidos e informe se o frasco estiver quebrado.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Soluções orais',
       'Medicamentos líquidos administrados por via oral, como gotas ou soluções em frascos.',
       'Feche bem a embalagem original e transporte na posição vertical, dentro de saco vedado para conter eventual vazamento. Não misture com outros líquidos nem despeje no esgoto. Leve a ponto que confirme aceitar soluções orais.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Colírios',
       'Medicamentos líquidos para aplicação nos olhos, geralmente em frascos pequenos.',
       'Feche a tampa e mantenha o colírio no frasco original, dentro de embalagem secundária para evitar vazamentos. Não reutilize após o prazo indicado nem despeje o conteúdo na pia. Entregue em ponto de coleta de medicamentos e siga a orientação local para o frasco.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Gotas nasais ou otológicas',
       'Medicamentos líquidos em gotas para aplicação nasal ou nos ouvidos.',
       'Mantenha no frasco original, fechado, e acondicione em saco separado para evitar vazamentos. Não despeje o líquido em pias ou vasos sanitários. Entregue em farmácia ou unidade de saúde que receba medicamentos vencidos.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Pomadas',
       'Medicamentos semissólidos de uso tópico, normalmente em bisnagas ou potes.',
       'Não esprema a embalagem para retirar o restante nem lave o conteúdo para tentar reciclar o recipiente. Feche a bisnaga ou pote, mantenha no acondicionamento original e entregue em coletor de medicamentos. Confirme com o ponto se recebe bisnagas e potes com resíduos.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Cremes medicamentosos',
       'Preparações semissólidas para aplicação na pele, com ou sem aplicador.',
       'Feche a embalagem e mantenha o creme dentro do recipiente original. Não descarte o conteúdo no ralo, vaso sanitário ou lixo comum. Leve a ponto de coleta de medicamentos; não separe o conteúdo para reciclagem doméstica.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Géis medicamentosos',
       'Medicamentos em forma de gel para uso tópico ou outras aplicações indicadas na embalagem.',
       'Mantenha o gel no recipiente original, fechado e protegido contra vazamentos. Não lave o recipiente nem despeje o conteúdo no esgoto. Entregue em farmácia ou unidade de saúde que aceite medicamentos vencidos e siga as instruções para a embalagem.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Supositórios',
       'Medicamentos sólidos ou semissólidos moldados para administração retal ou vaginal.',
       'Mantenha cada unidade na embalagem original, sem retirar o conteúdo ou misturá-lo a outros resíduos. Coloque a embalagem em saco separado e leve a ponto de coleta de medicamentos. Não descarte no vaso sanitário.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Sprays e aerossóis medicamentosos',
       'Medicamentos em frascos com válvula ou aerossol, como alguns sprays nasais e bucais.',
       'Não perfure, queime, esmague nem tente esvaziar o frasco. Mantenha a tampa e a embalagem intactas e informe ao ponto de coleta que se trata de aerossol pressurizado. Confirme se o estabelecimento recebe esse tipo específico; alguns programas exigem encaminhamento separado.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Adesivos transdérmicos',
       'Adesivos que liberam medicamento pela pele ao longo do tempo.',
       'Retire conforme a orientação do medicamento, dobre o adesivo ao meio com a parte adesiva para dentro e mantenha-o fora do alcance de crianças e animais. Guarde em embalagem fechada e leve a ponto que aceite medicamentos vencidos. Não corte nem lave o adesivo.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Ampolas e frascos-ampola sem agulhas',
       'Recipientes de vidro ou plástico com medicamento líquido ou em pó, sem agulhas ou seringas acopladas.',
       'Não quebre nem abra a ampola em casa. Acondicione o recipiente em embalagem rígida e protegida para evitar cortes e vazamentos; leve a unidade de saúde ou ponto que confirme receber esse material. Se houver agulha, seringa ou outro perfurocortante, não coloque no coletor comum de medicamentos: siga o fluxo específico de resíduos perfurocortantes do serviço de saúde.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Medicamentos';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo de cozinha usado',
       'Óleo vegetal utilizado em frituras ou preparações culinárias, após o uso.',
       'Espere esfriar completamente. Com ajuda de um funil, transfira para uma garrafa PET limpa e seca, sem água ou restos de comida; feche bem e limpe a parte externa. Armazene longe de calor e entregue em ponto que faça coleta de óleo de cozinha. Nunca despeje na pia, vaso sanitário, bueiro ou solo.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo de soja usado',
       'Óleo de soja que já foi utilizado no preparo ou na fritura de alimentos.',
       'Deixe esfriar e, se necessário, retire apenas resíduos grandes com utensílio, sem misturar água ou detergente. Coloque em garrafa PET limpa e seca com funil, feche e identifique como óleo de cozinha usado. Entregue a coletor específico; não misture com óleo de motor ou outros produtos químicos.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo de girassol usado',
       'Óleo vegetal de girassol utilizado em frituras ou preparações culinárias.',
       'Após esfriar totalmente, transfira para garrafa PET limpa e seca, usando funil, e feche a tampa firmemente. Guarde em local protegido do sol e do calor. Leve a ponto que aceite óleo vegetal usado; não despeje no ralo nem misture com lubrificantes.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo de canola usado',
       'Óleo vegetal de canola após uso culinário.',
       'Espere esfriar completamente e coloque em recipiente plástico limpo, seco, resistente e com tampa, preferencialmente PET. Evite colocar restos de alimentos ou água. Identifique e entregue em ponto de coleta de óleo de cozinha; nunca descarte em pia, bueiro ou terreno.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo de milho usado',
       'Óleo vegetal de milho utilizado em frituras ou cozimento.',
       'Deixe esfriar, use um funil e armazene em garrafa PET limpa e seca, bem fechada. Não misture com água, solventes, óleo lubrificante ou outros resíduos. Entregue em ponto de coleta de óleo de cozinha usado.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Mistura de óleos de cozinha usados',
       'Mistura de diferentes óleos vegetais resultante de frituras e preparações culinárias.',
       'Espere esfriar e acondicione em garrafa PET limpa e seca, sem adicionar água, detergente ou restos sólidos. Feche bem e identifique como óleo de cozinha usado. Confirme se o coletor aceita mistura de óleos vegetais e entregue no recipiente indicado; não misture com óleo automotivo.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Gordura vegetal de fritura',
       'Gordura vegetal utilizada em frituras, que pode solidificar quando esfria.',
       'Deixe esfriar até solidificar e transfira com utensílio para recipiente resistente, limpo e com tampa, sem despejar gordura quente. Não descarte na pia ou no vaso sanitário. Consulte o ponto de coleta se aceita gordura vegetal sólida; não misture com lubrificantes.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo lubrificante automotivo usado',
       'Óleo retirado do motor de carros após a troca, considerado resíduo perigoso.',
       'Não manuseie sem proteção nem misture com água, combustível, solventes, fluido de freio ou óleo de cozinha. Mantenha em recipiente apropriado, resistente, fechado e sem vazamentos. Devolva a oficina, posto ou coletor autorizado que receba óleo lubrificante usado; não despeje no solo, ralo ou lixo.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo de transmissão usado',
       'Lubrificante usado em caixas de transmissão e sistemas de engrenagens de veículos e máquinas.',
       'Acondicione em recipiente compatível, estanque e identificado, evitando contato com água ou outros resíduos. Não reutilize garrafas de bebidas. Encaminhe a oficina ou coletor autorizado que confirme receber óleo de transmissão usado; nunca descarte no esgoto ou solo.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo hidráulico usado',
       'Fluido lubrificante utilizado em sistemas hidráulicos de máquinas, equipamentos e veículos.',
       'Evite contato com pele e olhos e não misture com óleo de cozinha, solventes ou outros fluidos. Armazene em embalagem resistente, fechada e identificada, com contenção contra vazamento. Entregue a empresa ou coletor especializado em óleo industrial/hidráulico.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo lubrificante industrial usado',
       'Óleo empregado na lubrificação de máquinas e equipamentos industriais após o uso.',
       'Mantenha separado por tipo e não misture com água, solventes, combustíveis ou outros resíduos. Use bombona ou recipiente compatível, identificado e vedado, em área coberta com contenção de vazamentos. Encaminhe pelo sistema de coleta autorizado da empresa ou por operador especializado.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

INSERT INTO MATERIAL (ID, NOME, DESCRICAO, INSTRUCAO_DESCARTE, CATEGORIA_ID)
SELECT SEQ_MATERIAL.NEXTVAL, 'Óleo de motor de motocicleta usado',
       'Óleo lubrificante drenado do motor de motocicletas após a troca.',
       'Deixe o óleo ser recolhido em recipiente adequado durante a manutenção e transfira somente para embalagem compatível, fechada e sem vazamentos. Não misture com óleo de cozinha, água ou combustível. Devolva à oficina ou ponto autorizado que receba óleo lubrificante usado; não descarte no lixo comum.', c.ID
FROM CATEGORIA c
WHERE c.NOME = 'Óleo';

-- ---------------------------------------------------------------------
--RELACIONAMENTO ENTRE MATERIAIS E PONTOS DE COLETA
-- ---------------------------------------------------------------------

-- Pontos que recebem materiais da categoria Eletrônicos.
INSERT INTO MATERIAL_PONTO (MATERIAL_ID, PONTO_ID)
SELECT m.ID, p.ID
FROM MATERIAL m
         JOIN CATEGORIA c ON c.ID = m.CATEGORIA_ID
         JOIN PONTO_COLETA p ON p.NOME IN (
                                           'Zero Impacto',
                                           'Sucateiro Digital',
                                           'Ecoleve Soluções Ambientais',
                                           'Lixos Eletrônicos DF',
                                           'Eletro Recicle',
                                           'DMT Reciclagem',
                                           'DMLU – Ecoponto Centro'
    )
WHERE c.NOME = 'Eletrônicos';

-- Coopermiti: materiais das categorias Eletrônicos, Pilhas e Baterias.
INSERT INTO MATERIAL_PONTO (MATERIAL_ID, PONTO_ID)
SELECT m.ID, p.ID
FROM MATERIAL m
         JOIN CATEGORIA c ON c.ID = m.CATEGORIA_ID
         JOIN PONTO_COLETA p ON p.NOME = 'Coopermiti'
WHERE c.NOME IN ('Eletrônicos', 'Pilhas', 'Baterias');

-- DMLU – Ecoponto Centro: somente materiais de óleo/gordura de cozinha.
INSERT INTO MATERIAL_PONTO (MATERIAL_ID, PONTO_ID)
SELECT m.ID, p.ID
FROM MATERIAL m
         JOIN PONTO_COLETA p ON p.NOME = 'DMLU – Ecoponto Centro'
WHERE m.NOME IN (
                 'Óleo de cozinha usado',
                 'Óleo de soja usado',
                 'Óleo de girassol usado',
                 'Óleo de canola usado',
                 'Óleo de milho usado',
                 'Mistura de óleos de cozinha usados',
                 'Gordura vegetal de fritura'
    );

-- ---------------------------------------------------------------------
--FINALIZACAO E CONSULTAS DE CONFERENCIA
-- ---------------------------------------------------------------------

COMMIT;

-- Quantidade de registros por tabela.
SELECT 'CATEGORIA' AS TABELA, COUNT(*) AS QUANTIDADE FROM CATEGORIA
UNION ALL
SELECT 'PONTO_COLETA', COUNT(*) FROM PONTO_COLETA
UNION ALL
SELECT 'MATERIAL', COUNT(*) FROM MATERIAL
UNION ALL
SELECT 'MATERIAL_PONTO', COUNT(*) FROM MATERIAL_PONTO;

-- Materiais agrupados por categoria.
SELECT c.NOME AS CATEGORIA, COUNT(m.ID) AS TOTAL_MATERIAIS
FROM CATEGORIA c
         LEFT JOIN MATERIAL m ON m.CATEGORIA_ID = c.ID
GROUP BY c.NOME
ORDER BY c.NOME;

-- Pontos de coleta e materiais relacionados.
SELECT p.NOME AS PONTO_COLETA,
       p.CIDADE,
       p.ESTADO,
       COUNT(mp.MATERIAL_ID) AS TOTAL_MATERIAIS_VINCULADOS
FROM PONTO_COLETA p
         LEFT JOIN MATERIAL_PONTO mp ON mp.PONTO_ID = p.ID
GROUP BY p.NOME, p.CIDADE, p.ESTADO
ORDER BY p.ESTADO, p.CIDADE, p.NOME;

-- Relação detalhada entre ponto, categoria e material.
SELECT p.NOME AS PONTO_COLETA,
       c.NOME AS CATEGORIA,
       m.NOME AS MATERIAL
FROM MATERIAL_PONTO mp
         JOIN MATERIAL m ON m.ID = mp.MATERIAL_ID
         JOIN CATEGORIA c ON c.ID = m.CATEGORIA_ID
         JOIN PONTO_COLETA p ON p.ID = mp.PONTO_ID
ORDER BY p.NOME, c.NOME, m.NOME;