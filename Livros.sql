create database db_cds;
use db_cds;

create table tb_artista(
    pk_id_codArt int primary key not null auto_increment,
    nome_art varchar (50)
);

describe tb_artista;
select * from tb_artista;

insert into tb_artista
(nome_art) value
('Anitta'),
('Marilia Mendonça'),
('Henrique e Juliano');

create table tb_gravadora (
    pk_id_grav int primary key not null auto_increment,
    nome_grav varchar(50)
);

describe tb_gravadora;
select * from tb_gravadora;

insert into tb_gravadora (nome_grav) values
('Warner Music Brasil'),
('Som Livre'),
('Work Show');

create table tb_categoria (
    pk_id_cat int primary key not null auto_increment,
    nome_cat varchar(50)
);

describe tb_categoria;
select * from tb_categoria;

insert into tb_categoria (nome_cat) values
('Funk'),
('Sertanejo'),
('Sertanejo');  -- Este valor está duplicado


create table tb_Estado (
    pk_id_Sigla_Est int primary key not null,
    nome_Est varchar(50)
);

describe tb_Estado;
select * from tb_Estado;

insert into tb_Estado (pk_id_Sigla_Est, nome_Est) values
('RJ', 'Rio de Janeiro'),
('GO', 'Goias'),
('TO', 'Tocantins');

create table cidade(
PK_cod_cid int primary key not null,
nome_cid varchar(100) not null,
sigla_est char(2) not null,

foreign key (sigla_est) references estado(PK_sigla_est)
);

create table cliente(
cod_cli int not null primary key,
cod_cid int not null , -- chave estrangeira
nome_cli varchar(100) not null,
end_cli varchar(100) not null,
renda_cli decimal(10,2) not null default 0 check (renda_cli >= 0),
sexo_cli char(1) not null default 'F' check (sexo_cli in ('F', 'M')),

foreign key (cod_cid) references cidade(PK_cod_cid)
);

create table tb_cliente (
    pk_id_codCli int primary key not null auto_increment,
    fk_cod_cid int not null,
    nome_cli varchar(100),
    end_cli varchar(200),
    renda_cli decimal(10,2),
    sexo_cli char(1),
    foreign key (fk_cod_cid) references tb_cidade(pk_id_cod_cid)
);

create database db_conjuge;
use db_conjuge;

create table Conjuge(
    cod_cli int primary key not null,
    nome_conj varchar(100) not null,
    renda_conj decimal(10,2) not null default 0 check (renda_conj >= 0),
    sexo_conj char(1) not null default 'M' check (sexo_conj in ('F', 'M')),

    foreign key (cod_cli) references cliente(PK_idcli)
);

create database db_funcionario;
use db_funcionario;

create table funcionario(
    cod_func int primary key not null,
    nome_func varchar(100) not null,
    end_func varchar(200) not null,
    sal_func decimal(10,2) not null default 0 check (sal_func >= 0),
    sexo_func char(1) not null default 'M' check (sexo_func in ('F', 'M'))
);

create table dependente (
    cod_dep int not null primary key,
    cod_func int not null,
    nome_dep varchar(100) not null,
    sexo_dep char(1) not null default 'M' check (sexo_dep in ('F', 'M')),

    foreign key (cod_func) references funcionario (cod_func)
);

create table Titulo (
    cod_tit int not null primary key,
    cod_cat int not null, -- chave estrangeira
    cod_grav int not null, -- chave estrangeira
    nome_cd varchar(100) not null unique,
    val_cd decimal(10,2) not null DEFAULT 0 CHECK (val_cd > 0),
    qtd_estq int not null DEFAULT 0 CHECK (qtd_estq >= 0),

    foreign key (cod_cat) references categoria(PK_cod_cat),
    foreign key (cod_grav) references gravadora(PK_cod_grav)
);

create table Pedido (
    num_Ped int primary key not null, 
    cod_cli int not null, -- chave estrangeira
    cod_func int not null, -- chave estrangeira
    data_ped datetime not null,
    val_ped decimal(10,2) not null default 0 check (val_ped >= 0),

    foreign key (cod_cli) references cliente(cod_cli),
    foreign key (cod_func) references funcionario(cod_func)
);

create table  Titulo_Pedido (
    num_ped INT NOT NULL,
    cod_Tit INT NOT NULL,
    qtd_CD INT NOT NULL CHECK (qtd_CD >= 1),
    val_CD DECIMAL(10,2) NOT NULL CHECK (val_CD > 0),

    PRIMARY KEY (num_ped, cod_Tit),
    FOREIGN KEY (num_ped) REFERENCES Pedido(num_Ped),
    FOREIGN KEY (cod_Tit) REFERENCES Titulo(cod_tit)
);

create table Titulo_Artista (
    cod_tit int not null,
    cod_art int not null,

    PRIMARY KEY (cod_tit, cod_art),
    FOREIGN KEY (cod_tit) REFERENCES Titulo(cod_tit),
    FOREIGN KEY (cod_art) REFERENCES Artista(cod_art)
);



