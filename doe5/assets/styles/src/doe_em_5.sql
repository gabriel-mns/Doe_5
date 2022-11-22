/*
Estudantes:
Carlos Eduardo Krefer
Felipe Silva
Gabriel Martins
Guilherme Martins
*/
drop database if exists doe5;
create database doe5;
use doe5;

create table TBUsuario(
	id int AUTO_INCREMENT primary key,
	email varchar(150) unique,
	senha varchar(50) not null,
	nome varchar(1100) not null,
	celular char(13), 
	dataNascimento date not null
);

create table TBValidacaoCadastro(
	idUsuario int primary key,
	codAutenticacao int not null,
	dataValidacao date,

	foreign key(idUsuario) references TBUsuario(id)
);

create table TBAdministrador(
	idAdmin int primary key,
	superUser boolean not null,

	foreign key(idAdmin) references TBUsuario(id)
);

create table TBTermosCondicoes(
	versao varchar(10) primary key,
	conteudo mediumtext not null,
	dataHoraEmissao datetime not null,
	idAdmin int not null,
	
	foreign key(idAdmin) references TBAdministrador(idAdmin)
);

create table TBAnalisa(
	versao varchar(10),
	idUsuario int,
	dataHoraResposta datetime,
	
	primary key(versao, idUsuario),
	foreign key(idUsuario) references TBUsuario(id),
	foreign key(versao) references TBTermosCondicoes(versao)
);

create table TBBanimento(
	motivo tinytext not null,
	idUsuario int,
	idAdmin int,
	dataHoraBanimento datetime,
	dataHoraUnban datetime,
	
	primary key(idUsuario, idAdmin, dataHoraBanimento),
	foreign key(idUsuario) references TBUsuario(id),
	foreign key(idAdmin) references TBAdministrador(idAdmin)
);

create table TBTempoAcesso(
	idUsuario int,
	dataAcesso date,
	tempoAcesso int,

	primary key(idUsuario, dataAcesso),
	foreign key(idUsuario) references TBUsuario(id)
);

create table TBBrowser(
	id int primary key,
	nome varchar(50) not null
);

create table TBEstatistica(
	idUsuario int primary key,
	dataHoraCriacaoConta datetime not null,
	browserUltimaSessao int,

	foreign key(browserUltimaSessao) references TBBrowser(id),
	foreign key(idUsuario) references TBUsuario(id)
);

create table TBCidade(
	id int primary key,
	cidade varchar(50) not null,
	estado char(2) not null
);

create table TBInstituicao(
	idInstituicao int primary key,
	cnpj char(13) unique not null,
	razaoSocial varchar(100) unique not null,
	nomeFantasia varchar(100) not null,
	rua varchar(50) not null,
	numero varchar(10) not null,
	complemento varchar(50),
	bairro varchar(50) not null,
	cidade int not null,
    numeroTelFixo char(10),
    
	foreign key(cidade) references TBCidade(id),
    foreign key(idInstituicao) references TBUsuario(id)
);

create table TBAutenticacao(
	idInstituicao int,
	statusAutenticacao boolean not null,
	dataHoraAutenticacao datetime,
	idAdmin int,
	
	primary key(dataHoraAutenticacao, idInstituicao, idAdmin),
	foreign key(idInstituicao) references TBInstituicao(idInstituicao),
    foreign key(idAdmin) references TBAdministrador(idAdmin)
);

create table TBDadosBancarios(
	id int primary key,
	idInstituicao int not null,
	codBanco varchar(5) not null,
	agencia varchar(10) not null,
	conta varchar(20) not null,
	chavePix varchar(175),
	
	foreign key(idInstituicao) references TBInstituicao(idInstituicao)
);

create table TBDoador(
	idDoador int primary key,
	rua varchar(50) not null,
	numero varchar(10) not null,
	complemento varchar(50),
	bairro varchar(50) not null,
	cidade int not null, 
	
	foreign key(idDoador) references TBUsuario(id),
	foreign key(cidade) references TBCidade(id)
);

create table TBTransportador(
	idTransportador int primary key,
	rua varchar(50) not null,
	numero varchar(10) not null,
	complemento varchar(50) ,
	bairro varchar(50) not null,
	cidade int not null,
	cnh char(11) unique,
	
	foreign key(idTransportador) references TBUsuario(id),
	foreign key(cidade) references TBCidade(id)
);

create table TBCentroCaptacao(
	id int primary key,
	nome varchar(100) not null,
	rua varchar(50) not null,
	numero varchar(10) not null,
	complemento varchar(50) ,
	bairro varchar(50) not null,
	cidade int not null,
	numeroTelFixo char(10),
    idInstituicao int not null,
	
	foreign key(idInstituicao) references TBInstituicao(idInstituicao),
	foreign key(cidade) references TBCidade(id)
);

create table TBVincTranspCapt(
	idTransportador int,
    idCentro int,
    dataHoraPermissao datetime,
	statusVinculo boolean not null,
    dataHoraCancelamento datetime,

	primary key(dataHoraPermissao, idTransportador, idCentro),
	foreign key(idTransportador) references TBTransportador(idTransportador),
	foreign key(idCentro) references TBCentroCaptacao(id)
    
);

create table TBItemDoacao(
	id int primary key,
	tipo varchar(30) not null
);

create table TBDoacao(
    idDoador int,
    idDoacao int,
	idCentro int,
    idTransportador int,
    qtde int not null,
	altura decimal(4,1),
	largura decimal(4, 1),
	comprimento decimal(4, 1),
	peso decimal(7,2),
    dataHoraDoadorEntregou datetime,
    dataHoraTranspRecebeu datetime,
    dataHoraTranspEntregaCentro datetime,
    dataHoraCentroRecebeu datetime,
	transporte boolean not null,

	primary key(idDoador, idDoacao, idCentro),
    foreign key(idDoador) references TBDoador(idDoador),
	foreign key(idDoacao) references TBItemDoacao(id),
	foreign key(idCentro) references TBCentroCaptacao(id),
    foreign key(idTransportador) references TBTransportador(idTransportador)
);

create table TBCentroPrecisaDoacao(
	idCentro int,
    idItemDoacao int,
    
    
    primary key (idItemDoacao, idCentro),
    foreign key (idItemDoacao) references TBItemDoacao(id),
    foreign key (idCentro) references TBCentroCaptacao(id)
);






/*----- INSERTS----- */






INSERT INTO TBUsuario -- Administrador
	VALUES (
		1,
        "felipsilvsilv@gmail.com",
        "123", 
		"Felipe",
        "41992397447",
        "2002-08-03"
        ); 
    
INSERT INTO TBUsuario -- Administrador
	VALUES (
		2,
        "gabrielgmns071204@gmail.com",
        "123", 
		"Gabriel",
		"44999380775",
		"2004-12-07"
        ); 
    
INSERT INTO TBUsuario -- Administrador
	VALUES (
		3,
        "guimsl2004@gmail.com",
        "123", 
		"Guilherme",
        "41992040393",
        "2004-11-25"
    ); 
    
INSERT INTO TBUsuario
	VALUES (
		4,
        "angelobrocca@gmail.com",
        "123", 
		"Angelo",
        "41987777777",
        "2004-06-25"
    ); 
    
INSERT INTO TBUsuario 
	VALUES (
		5,
        "carloskrefer@gmail.com",
        "123", 
		"Carlos",
        "41987666666",
        "1998-11-12"
    ); 
    
INSERT INTO TBUsuario 
	VALUES (
		6,
        'couves_joao@gmail.com',
        '123', 
		'João Couves',
        '5544998887777',
        "2000-12-17"
    ); 
    
INSERT INTO TBUsuario 
	VALUES (
		7,
        'leirbag@gmail.com',
        '123',
		'Leirbag',
        '5544998887777',
        "2002-12-08"
    ); 
    
INSERT INTO TBUsuario 
	VALUES (
		8,
        'epilef@gmail.com',
        '123', 
		'Epilef',
        '5544998887777',
        "2001-09-17"
    ); 
    
INSERT INTO TBUsuario 
	VALUES (
		9,
        'emrehliug@gmail.com',
        '123',
		'Emrehliug',
        '5544998887777',
        "2002-12-17"
    );
    
INSERT INTO TBUsuario
	VALUES (
		10,
		'solrac@gmail.com',
		'123', 
		'Solrac',
		'5544998887777',
		"2003-11-17"
    );
    
INSERT INTO TBUsuario  -- Transportador
	VALUES (
		11,
		'bruubs@gmail.com',
		'123', 
		'Bruna',
		'5544998887777',
		"2002-08-03"
    ); 
    
INSERT INTO TBUsuario -- Transportador
	VALUES (
		12,
		'pablito@gmail.com',
		'123', 
		'Pablo',
		'5544998887777',
		"2003-07-04"
    ); 
    
INSERT INTO TBUsuario 
	VALUES (
		13,
		'austinally@gmail.com',
		'123',
		'Austin',
		'5544998887777',
		"2004-09-11"
    );
    
INSERT INTO TBUsuario 
	VALUES (
		14,
        'taxinha@gmail.com',
        '123', 
		'Tasha',
        '5544998887777',
        "2001-11-09"
    );
    
INSERT INTO TBUsuario 
	VALUES (
		15,
        'Allie@gmail.com',
        '123',
		'Allie',
        '5544998887777',
        "2000-06-05"
    );
    
INSERT INTO TBUsuario 
	VALUES (
		16,
        'loris@cleides.edu.br',
        '123', 
		'Loris',
        '5544991117373',
        "2002-09-09"
    );
    
INSERT INTO TBUsuario  -- Instituição
	VALUES (
		17,
        'lando@hotmail.com',
        '123', 
		'Lando',
        '5544992117373',
        "2002-09-09"
    ); 
    
INSERT INTO TBUsuario -- Instituição
	VALUES (
		18,
        'charles@hotmail.com',
        '123', 
		'Charles',
        '5544994117373',
        "2002-09-09"
    ); 
    
INSERT INTO TBUsuario -- Instituição
	VALUES (
		19,
        'daniel@hotmail.com',
        '123', 
		'Daniel',
        '5544996117373',
        "2002-09-09"
    ); 
    
INSERT INTO TBUsuario -- Instituição
	VALUES (
		20,
		'hulkenberg@hotmail.com',
		'123', 
		'Hulkenberg',
		'5544997117373',
		"2002-09-09"
    ); 
    
INSERT INTO TBUsuario -- Instituição
	VALUES (
		21,
        'nico@hotmail.com',
        '123', 
		'Nico',
        '5544998117373',
        "2002-09-09"
    ); 

INSERT INTO TBValidacaoCadastro 
	VALUES (
		1,
        1521700295,
        "2021-08-03"
    );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            2,
            1521700295,
            "2021-10-31"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            3,
            1521700295,
            "2022-06-14"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            4,
            1521700295,
            "2022-03-16"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            5,
            1521700295,
            "2021-10-02"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            6,
            1521700295,
            "2021-12-18"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            7,
            1521700295,
            "2022-02-27"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            8,
            1521700295,
            "2021-12-24"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            9,
            1521700295,
            "2022-05-06"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            11,
            1521700295,
            "2022-05-06"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            12,
            1521700295,
            "2022-05-06"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            13,
            1521700295,
            "2022-05-06"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            14,
            1521700295,
            "2022-05-06"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            15,
            1521700295,
            "2022-05-06"
        );

INSERT INTO TBValidacaoCadastro 
    VALUES (
            16,
            1521700295,
            "2022-04-02"
        );


INSERT INTO TBAdministrador 
    VALUES (
            3,
            True
        );

INSERT INTO TBAdministrador 
    VALUES (
            2,
            False
        );

INSERT INTO TBAdministrador 
    VALUES (
            1,
            False
        );


INSERT INTO TBTermosCondicoes 
    VALUES (
            "01beta",
            "Todos os usuários devem aceitar os termos de uso",
            "2021-04-26 16:32:36",
            1
         );

INSERT INTO TBTermosCondicoes 
    VALUES (
            "02beta",
            "Todas as informações dos usuários são salvas em um banco de dados",
            "2021-04-26 16:34:27",
            2
         );

INSERT INTO TBAnalisa 
    VALUES (
            "01beta",
            04,
            "2022-03-15 18:09"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "01beta",
            05,
            "2021-10-02 18:26"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "01beta",
            06,
            "2021-12-18 13:48"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "01beta",
            07,
            "2022-02-27 12:41"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "01beta",
            08,
            "2021-12-24 06:52"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "01beta",
            09,
            "2021-12-24 22:16"
        );


INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            04,
            "2022-10-16 17:26"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            05,
            "2022-10-16 18:09"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            06,
            "2022-10-16 18:10"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            07,
            "2022-10-16 16:33"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            08,
            "2022-10-16 17:56"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            11,
            "2022-10-16 17:56"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            12,
            "2022-10-16 17:56"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            13,
            "2022-10-16 17:56"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            14,
            "2022-10-16 17:56"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            15,
            "2022-10-16 17:56"
        );

INSERT INTO TBAnalisa 
    VALUES (
            "02beta",
            16,
            "2022-10-16 17:56"
        );


INSERT INTO TBBanimento 
    VALUES (
            "Doação de baixa qualidade",
            13,
            1,
            "2022-10-18 18:26",
            "2022-10-19 12:42"
        );

INSERT INTO TBBanimento 
    VALUES (
            "Documentação",
            13,
            2,
            "2022-10-16 16:24",
            null
        );

INSERT INTO TBBanimento 
    VALUES (
            "Doação de baixa qualidade",
            14,
            3,
            "2022-10-10 14:20",
            "2022-10-12 12:39"
        );

INSERT INTO TBBanimento 
    VALUES (
            "toxicidade",
            14,
            3,
            "2022-10-15 17:06",
            "2022-10-16 19:27"
        );

INSERT INTO TBBanimento 
    VALUES (
            "Doação de baixa qualidade",
            14,
            3,
            "2022-10-25 19:26",
            null
        );


INSERT INTO TBTempoAcesso 
    VALUES (
            1,
            "2022-03-26",
            64
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            1,
            "2022-03-28",
            21
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            2,
            "2022-03-29",
            67
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            2,
            "2022-03-30",
            135
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            2,
            "2022-03-31",
            12
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            3,
            "2022-04-24",
            16
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            3,
            "2022-04-26",
            35
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            4,
            "2022-04-27",
            49
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            5,
            "2022-04-27",
            15
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            6,
            "2022-03-29",
            16
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            7,
            "2022-04-03",
            13
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            8,
            "2022-04-04",
            09
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            8,
            "2022-04-09",
            5
        );

INSERT INTO TBTempoAcesso 
    VALUES (
            11,
            "2022-04-10",
            8
        );


INSERT INTO TBBrowser 
    VALUES (
            1,
            "Edge"
        );

INSERT INTO TBBrowser 
    VALUES (
            2,
            "Chrome"
        );

INSERT INTO TBBrowser 
    VALUES (
            3,
            "Opera"
        );

INSERT INTO TBBrowser 
    VALUES (
            4,
            "Brave"
        );

INSERT INTO TBBrowser 
    VALUES (
            5,
            "OperaGX"
        );

INSERT INTO TBBrowser 
    VALUES (
            6,
            "Firefox"
        );

INSERT INTO TBBrowser 
    VALUES (
            7,
            "Safari"
        );


INSERT INTO TBEstatistica 
    VALUES(
            1,
            "2021-08-03 16:44",
            1
        );

INSERT INTO TBEstatistica 
    VALUES(
            2,
            "2021-10-31 13:23",
            5
        );

INSERT INTO TBEstatistica 
    VALUES(
            3,
            "2022-06-14 22:13",
            5
        );

INSERT INTO TBEstatistica 
    VALUES(
            4,
            "2022-03-15 18:09",
            4
        );

INSERT INTO TBEstatistica 
    VALUES(
            5,
            "2021-10-02 18:26",
            null
        );

INSERT INTO TBEstatistica 
    VALUES(
            6,
            "2021-12-18 13:48",
            6
        );

INSERT INTO TBEstatistica 
    VALUES(
            7,
            "2022-02-27 12:41",
            7
        );

INSERT INTO TBEstatistica 
    VALUES(
            8,
            "2021-12-24 06:52",
            4
        );

INSERT INTO TBEstatistica 
    VALUES(
            9,
            "2021-12-24 22:16",
            5
        );

INSERT INTO TBEstatistica 
    VALUES(
            10,
            "2021-10-31 13:23",
            5
        );

INSERT INTO TBEstatistica 
    VALUES(
            11,
            "2021-10-31 13:23",
            2
        );

INSERT INTO TBEstatistica 
    VALUES(
            12,
            "2021-10-31 13:23",
            2
        );

INSERT INTO TBEstatistica 
    VALUES(
            13,
            "2021-10-31 13:23",
            2
        );

INSERT INTO TBEstatistica 
    VALUES(
            14,
            "2021-10-31 13:23",
            2
        );

INSERT INTO TBEstatistica 
    VALUES(
            15,
            "2021-10-31 13:23",
            2
        );

INSERT INTO TBEstatistica 
    VALUES(
            16,
            "2021-10-31 13:23",
            2
        );


INSERT INTO TBCidade 
    VALUES (
            1,
            "Curitiba",
            "PR"
        );
INSERT INTO TBCidade 
    VALUES (
            2,
            "Ubiratã",
            "PR"
        );
INSERT INTO TBCidade 
    VALUES (
            3,
            "São Paulo",
            "SP"
        );
INSERT INTO TBCidade 
    VALUES (
            4,
            "São José dos Pinhais",
            "PR"
        );
INSERT INTO TBCidade 
    VALUES (
            5,
            "Pinhais",
            "PR"
        );
INSERT INTO TBCidade 
    VALUES (
            6,
            "Colombo",
            "PR"
        );
INSERT INTO TBCidade 
    VALUES (
            7,
            "Araucária",
            "PR"
        );
INSERT INTO TBCidade 
    VALUES (
            8,
            "Maringá",
            "PR"
        );

INSERT INTO TBInstituicao 
    VALUES (
            17,
            "1097499700134",
	        "Hortaliças LTDA.",
            "Dona hortência produtinhos",
            "Av. Pres. Kennedy",            
            "2013a",
            "Térreo",
            "Novo Mundo",
            1,
            413777777
    );

INSERT INTO TBInstituicao 
    VALUES (
            18,
            "1797593100169",
	        "Verduraria Ltda.",
            "O moço das verdinhas",
            "Rua Dr. Reinaldo Machado",
            "1340",
            "Ap 505",
            "Prado Velho",
            1,
            4135431588
    );

INSERT INTO TBInstituicao 
    VALUES (
            19,
            "3757593200146",
	        "Frutaria Ltda.",
            "Pai das Papayas",
            "Rua Imaculada Conceição",
            "246c",
            "Esquina",
            "Prado Velho",
            1,
            4193456538
    );

INSERT INTO TBInstituicao 
    VALUES (
            20,
            "1751591200111",
	        "Fundação Casa Própria",
            "Casa Já",
            "Rua Dom Demeterco",
            "12J",
            "Sobreloja",
            "Jardim Botânico",
            6,
            4192422532
    );

INSERT INTO TBInstituicao 
    VALUES (
            21,
            "1751491204111",
	        "Grupo Solidário Ltda",
            "Solidário Doações",
            "Rua Felipe",
            "324",
            "Esquina",
            "Portão",
            1,
            4192152551
    );


INSERT INTO TBAutenticacao 
    VALUES (
            17,
            True,
            "2022-03-18 16:48",
            2
        );
INSERT INTO TBAutenticacao 
    VALUES (
            18,
            False,
            "2022-05-05 17:19",
            1
        );
INSERT INTO TBAutenticacao 
    VALUES (
            18,
            True,
            "2022-06-06 18:20",
            1
        );
INSERT INTO TBAutenticacao 
    VALUES (
            18,
            False,
            "2022-06-06 18:25",
            1
        );
INSERT INTO TBAutenticacao 
    VALUES (
            18,
            True,
            "2022-06-06 18:29",
            1
        );
INSERT INTO TBAutenticacao 
    VALUES (
            19,
            True,
            "2022-04-26 12:47",
            2
        );
INSERT INTO TBAutenticacao 
    VALUES (
            20,
            False,
            "2022-02-02 10:00",
            1
        );

INSERT INTO TBDadosBancarios 
    VALUES (
			1,
            17,
            "104",
            "4037",
            833339,
            "donahortencia@gmail.com"
        );

INSERT INTO TBDadosBancarios 
    VALUES (
			2,
            17,
            "001",
            "2920",
            744448,
            "44546955000114"
        );

INSERT INTO TBDadosBancarios 
    VALUES (
			3,
            18,
            "237",
            "4037",
            832346,
            "greenapple@gmail.com"
        );


INSERT INTO TBDoador VALUES (
            4,
            "Rua dos bobos",
            "0",
            "Casa sem teto nem nada",
            "bairro do limoeiro",
            1
        );

INSERT INTO TBDoador VALUES (
            5,
            "Rua das samambaias",
            "13",
            "Casa com muitas samambaias",
            "bairro do limoeiro",
            1
        );

INSERT INTO TBDoador VALUES (
            6,
            "Rua Alferes Poli",
            "1080",
            "AP211",
            "Centro",
            1
        );

INSERT INTO TBDoador VALUES (
            7,
            "Rua Jockey Clube",
            "206",
            "AP312",
            "Prado Velho",
            1
        );

INSERT INTO TBDoador VALUES (
            8,
            "Avenida das Torres",
            "896",
            "Quintal inclinado",
            "Sim",
            1
        );


INSERT INTO TBTransportador VALUES (
            11,
            "Rua domenico tonatto",
            "133",
            "Frente",
            "Cajuru",
            1,
            "12652878787"
            );

INSERT INTO TBTransportador VALUES (
            12,
            "Maceió",
            "1040",
            "Ap213",
            "Cajuru",
            1,
            null
            );

INSERT INTO TBTransportador VALUES (
            13,
            " Rua alameda",
            "900",
            "Ap 550",
            " Novo mundo",
            2,
            null
            );


INSERT INTO TBCentroCaptacao 
    VALUES (
        1,
        "Inicial",
        "Av. Pres. Kennedy",
        "2013a",
        "Térreo",
        "Novo Mundo",
        1,
        "413777777",
        17
    );
    
INSERT INTO TBCentroCaptacao 
    VALUES (
        2,
        "Central",
        "Av. Brigadeiro Franco",
        "2000",
        "Ao lado da floricultura",
        "Centro",
        1,
        "413777776",
        17
    );

INSERT INTO TBCentroCaptacao 
    VALUES (
        3,
        "Central",
        "Rua principal",
        "154",
        "Ao lado da plantação de milho",
        "Centro",
        2,
        "413777456",
        18
    );

    
INSERT INTO TBVincTranspCapt 
    VALUES (
            11,
            1,
            "2021-12-25 13:48",
            True,
            null
        );

INSERT INTO TBVincTranspCapt 
    VALUES (
            11,
            2,
            "2022-03-21 14:21",
            True,
            Null
        );

INSERT INTO TBVincTranspCapt 
    VALUES (
            12,
            3,
            "2022-04-25 16:37",
            True,
            Null
        );


INSERT INTO TBItemDoacao 
    VALUES (
            1,
            "Roupa"
        );

INSERT INTO TBItemDoacao 
    VALUES (
            2,
            "Lápis escolar"
        );

INSERT INTO TBItemDoacao 
    VALUES (
            3,
            "colchão"
        );

INSERT INTO TBItemDoacao 
    VALUES (
            4,
            "Cobertor"
        );

INSERT INTO TBItemDoacao 
    VALUES (
            5,
            "Mesa"
        );

INSERT INTO TBItemDoacao 
    VALUES (
            6,
            "Sofá"
        );



                    <h3>👁️‍🗨️ Observações:</h3>


INSERT INTO TBDoacao 
    VALUES (
        5,
        2,
        1,
        11,
        6,
        null,
        null,
        null,
        null,
        "2022-11-02 08:00",
        "2022-11-02 08:00",
        "2022-11-02 09:00",
        "2022-11-02 09:00",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        5,
        2,
        3,
        11,
        8,
        null,
        null,
        null,
        null,     
        "2022-11-03 08:10",
        "2022-11-03 08:10",
        "2022-11-02 09:10",
        "2022-11-02 09:10",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        6,
        6,
        2,
        11,
        5,
        120,
        210,
        300,
        40,
        "2022-11-04 08:20",
        "2022-11-04 08:20",
        "2022-11-02 09:20",
        "2022-11-02 09:20",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        6,
        4,
        3,
        11,
        3,
        null,
        null,
        null,
        null,        
        "2022-11-05 08:30",
        "2022-11-05 08:30",
        "2022-11-02 09:30",
        "2022-11-02 09:30",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        6,
        6,
        1,
        11,
        1,
        130,
        250,
        250,
        80,       
        null,
        null,
        null,
        null,
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        6,
        5,
        1,
        11,
        1,
        125,
        250,
        210,
        50,     
        "2022-11-06 08:40",
        "2022-11-06 08:40",
        "2022-11-02 09:40",
        "2022-11-02 09:40",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        7,
        2,
        2,
        11,
        7,
        null,
        null,
        null,
        null,
        "2022-11-07 08:50",
        "2022-11-07 08:50",
        "2022-11-02 09:50",
        "2022-11-02 09:50",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        7,
        3,
        1,
        11,
        6,
        null,
        null,
        null,
        null,   
        "2022-11-08 09:00",
        "2022-11-08 09:00",
        "2022-11-02 10:00",
        "2022-11-02 10:00",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        7,
        1,
        3,
        11,
        3,
        null,
        null,
        null,
        null,      
        "2022-11-09 09:10",
        "2022-11-09 09:10",
        "2022-11-02 10:10",
        "2022-11-02 10:10",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        8,
        2,
        3,
        11,
        5,
        null,
        null,
        null,
        null,        
        null,
        null,
        null,
        null,
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        8,
        1,
        2,
        11,
        6,
        null,
        null,
        null,
        null,        
        "2022-11-10 09:20",
        "2022-11-10 09:20",
        "2022-11-02 10:20",
        "2022-11-02 10:20",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        8,
        3,
        2,
        11,
        3,
        null,
        null,
        null,
        null,      
        "2022-11-11 09:30",
        "2022-11-11 09:30",
        "2022-11-02 10:30",
        "2022-11-02 10:30",
        true
    );

INSERT INTO TBDoacao 
    VALUES (
        8,
        4,
        3,
        null,
        1,
        null,
        null,
        null,
        null,     
        "2022-11-12",
        null,
        null,
        null,
        false
    );

INSERT INTO TBDoacao 
    VALUES (
        8,
        5,
        2,
        null,
        1,
        110,
        200,
        240,
        30,       
        "2022-11-13",
        null,
        null,
        null,
        false
    );

INSERT INTO TBDoacao 
    VALUES (
        8,
        6,
        1,
        null,
        2,
        120,
        100,
        245,
        25,       
        "2022-11-14",
        null,
        null,
        null,
        false
    );


INSERT INTO TBCentroPrecisaDoacao 
    VALUES (
            1,
            1
        );

INSERT INTO TBCentroPrecisaDoacao 
    VALUES (
            1,
            2
        );

INSERT INTO TBCentroPrecisaDoacao 
    VALUES (
            2,
            2
        );

INSERT INTO TBCentroPrecisaDoacao 
    VALUES (
            2,
            3
        );

INSERT INTO TBCentroPrecisaDoacao 
    VALUES (
            2,
            1
        );

INSERT INTO TBCentroPrecisaDoacao 
    VALUES (
            3,
            2
        );


-- 1. Média de peso de doações realizadas por centro
SELECT 
    AVG(peso),
    idCentro
FROM 
    TBDoacao
GROUP BY 
    idCentro;

-- 2. Cidades que mais recebem doações
SELECT 
    DISTINCT C.cidade,
    count(C.cidade) 
FROM 
    TBCidade C,
    TBDoacao D,
    TBCentroCaptacao CC 
WHERE 
    C.id = CC.cidade 
AND 
    CC.id = D.idCentro 
GROUP BY 
    C.cidade;

-- 3. Itens de doação nunca necessitados
SELECT 
    ID.tipo 
FROM 
    TBItemDoacao ID,
    TBCentroPrecisaDoacao CPD 
WHERE 
    ID.id not in (
            SELECT 
                idItemDoacao 
            FROM 
                TBCentroPrecisaDoacao
        ) 
GROUP BY 
    ID.id;

-- 4. Transportador com mais vínculos com centros de captação
SELECT 
    U.nome
FROM 
    TBUsuario U 
    INNER JOIN 
        TBVincTranspCapt VTC 
    ON 
        U.id = VTC.idTransportador
GROUP BY 
    VTC.idTransportador
ORDER BY 
    COUNT(U.id) desc
LIMIT 1;

-- 5.Transportador cadastrado que nunca realizou transporte
SELECT 
    DISTINCT U.nome,
    TBTransportador.idTransportador
FROM 
    TBUsuario U,
    TBDoacao D,
    TBTransportador
WHERE 
    U.id IN ( -- Para que U.id referencie todos os transportadores
            SELECT 
                TBTransportador.idTransportador
            FROM 
                TBTransportador
        )
AND 
    U.id NOT IN ( -- U.id não deverá fazer parte de uma doação que foi entregue por um transportador
            SELECT 
                DISTINCT TBDoacao.idTransportador 
            FROM 
                TBDoacao 
            WHERE 
                TBDoacao.dataHoraTranspEntregaCentro IS NOT NULL
        );
    
-- 6. Os dois browsers mais populares entre os usuários
SELECT 
    b.nome AS "TOP 2 Browsers mais populares"
FROM 
    TBBrowser b
    INNER JOIN 
        TBEstatistica e
	ON 
        b.id = e.browserUltimaSessao
GROUP BY 
    b.nome
ORDER BY 
    COUNT(e.browserUltimaSessao) DESC LIMIT 2;

-- 7. Instituições que ainda não foram analisadas por um administrador
SELECT 
    i.razaoSocial AS "Instituições não Analisadas"
FROM 
    TBInstituicao i 
WHERE 
    i.idInstituicao NOT IN (
        SELECT 
            a.idInstituicao
        FROM 
            TBAutenticacao a
    );

-- 8. Administrador que mais autenticou ou cancelou autenticação de instituições
SELECT 
	u.nome AS "Nome do Administrador", 
    COUNT(a.idAdmin) AS "Quantidade de Análises"
FROM 
    TBUsuario u
    INNER JOIN 
        TBAutenticacao a
	ON 
        u.id = a.idAdmin
GROUP BY 
    a.idAdmin
ORDER BY 
    COUNT(a.idAdmin)
DESC
LIMIT 1;

/* 
9. Lista de todos os anos com pelo menos um cadastro validado e a 
quantidade de validação de cadastro de usuários por ano, em ordem 
decrescente de número de cadastros.
*/
SELECT 
	YEAR(vc.dataValidacao) AS "Ano", 
	COUNT(vc.idUsuario) AS "Quantidade de Usuários Validados"
FROM 
    TBValidacaoCadastro vc
GROUP BY 
    YEAR(vc.dataValidacao)
ORDER BY 
    vc.dataValidacao 
    DESC;

-- 10. Porcentagem de doações cadastradas mas ainda não entregues pelo doador
SELECT 
	(
		(
			SELECT COUNT(*) 
			FROM TBDoacao 
			WHERE dataHoraDoadorEntregou IS NULL
        ) * 100
	) / count(*)
    AS "Porcentagem de doações cadastradas mas não entregues pelo doador"
FROM 
    TBDoacao;

-- 11. Idade média dos usuários (autenticados ou não autenticados)
SELECT AVG 
	(
		TIMESTAMPDIFF(
			YEAR,
            dataNascimento,
            CURDATE()
        )
	) AS "Idade Média dos Usuários"
FROM 
    TBUsuario;

/*12- A instituição com mais dados bancários*/
SELECT 
	nomeFantasia,
	COUNT(*) AS Qtde 
FROM 
	TBDadosbancarios D 
	INNER JOIN TBInstituicao I 
    ON D.IdInstituicao = I.IdInstituicao 
GROUP BY 
    D.idInstituicao
ORDER BY 
    Qtde DESC
LIMIT 1;

/* 13- Os usuários cadastrados que não aceitaram os termos e condições de uso */
SELECT 
	id Id,
	nome Nome 
FROM 
	TBusuario 
WHERE 
	id NOT IN (
		SELECT idUsuario FROM TBAnalisa
    ) AND id NOT IN (
		SELECT idAdmin FROM TBAdministrador
    );

/* 14- Os usuários com mais banimentos, apresentando o email do usuário e a quantidade de banimentos. */
SELECT 
	U.email,
    COUNT(idUsuario) AS VezesBanido 
FROM 
	TBBanimento B 
    INNER JOIN 
        TBUsuario U 
    ON 
        B.idUsuario = U.id 
GROUP BY 
    B.IDUsuario
ORDER BY 
    VezesBanido DESC;

/* 15- Tempo médio de acesso de usuários */
SELECT 
	ROUND(
        AVG(
            tempoAcesso
        )
    ) AS TempoMedioMinutos 
FROM 
	TBTempoAcesso;

/* 16- Transportadores que não possuem CNH */
SELECT 
	id Id,
    nome Nome 
FROM 
	TBUsuario U 
    INNER JOIN 
        TBTransportador T
	ON 
        U.id = T.idTransportador 
WHERE 
    cnh IS NULL;

/* 17 - Os usuários cadastrados que aceitaram apenas os termos e condições de uso da versão 1*/

SELECT 
    idUsuario,
    versao
FROM 
    TBAnalisa AS A
WHERE 
    idUsuario NOT IN (
            SELECT 
                idUsuario 
            FROM 
                TBAnalisa 
            WHERE 
                versao != "02beta" 
    );

/* 18- Doadores e transportadores que moram na mesma cidade */
SELECT 
    d.cidade,
    d.idDoador,
    t.idTransportador
FROM 
    TBDoador AS d
    INNER JOIN 
        TBTransportador AS t
	ON 
        d.cidade=t.cidade;
    
/* 19 - Lista das doacoes que nao foram entregues*/
SELECT  
    *
FROM 
    TBDoacao
WHERE 
    dataHoraDoadorEntregou IS NULL 
    AND
    dataHoraTranspRecebeu IS NULL 
    AND
    dataHoraTranspEntregaCentro IS NULL 
    AND
    dataHoraCentroRecebeu IS NULL;

/* 20 - Quantidade de Instituicoes que possuem centro de captacao em curitiba*/
SELECT 
    COUNT(TBCentroCaptacao.idInstituicao) AS Quantidade
FROM 
    TBCentroCaptacao, TBCidade
WHERE 
	TBCentroCaptacao.cidade = TBCidade.id 
    AND TBCidade.cidade = "Curitiba";