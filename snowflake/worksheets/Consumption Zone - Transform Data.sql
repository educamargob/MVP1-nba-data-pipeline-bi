use role accountadmin;

-------------------------------------------------------------------------------------------

// creating dw specific for analytics, db
create warehouse nba_analytics_wh with warehouse_size='small';
create database if not exists nba_consumption_db;

-------------------------------------------------------------------------------------------

// granting for role created
show grants on warehouse nba_analytics_wh;

grant usage on warehouse nba_analytics_wh to role nba_role;
grant all on database nba_consumption_db to role nba_role;

-------------------------------------------------------------------------------------------

use role nba_role;
use warehouse nba_analytics_wh;

// creating schema
create schema if not exists nba_consumption_db.nba_consumption_schema;
grant all on schema nba_consumption_db.nba_consumption_schema to role accountadmin;

-------------------------------------------------------------------------------------------

use schema nba_consumption_db.nba_consumption_schema;

//transformation queries
// Query Dim_Jogador
select 
    dh.person_id                    as pk_player,
    pl.full_name                    as nome_completo,
    pl.first_name                   as nome,
    pl.last_name                    as sobrenome,
    Nvl(pl.is_active, 0)            as em_atividade,
    to_date(pli.birthdate)          as data_nascimento,
    Nvl(pli.school, dh.organization_name)   as universidade,
    pli.country                     as pais,
    Round((Substr(height, 1, charindex('-',height)-1)*12) + Substr(height, charindex('-',height)+1, Length(height))) as altura_polegadas,
    Round(((Substr(height, 1, charindex('-',height)-1)*12) + Substr(height, charindex('-',height)+1, Length(height)))*2.54) as altura_cm,
    Replace(height, '-', '\'')      as altura_pes,
    Round(pli.weight)               as peso_libras,
    Round(pli.weight/2.205)         as peso_kg,
    pli.season_exp                  as temporadas,
    pli.jersey                      as num_camisa,
    pli.player_position             as posicao,
    Date(Nvl(pli.from_year, dh.season), 'yyyy')     as primeiro_ano_nba,
    Date(pli.to_year, 'yyyy')                       as ultimo_ano_nba,
    dh.draft_round                  as rodada_draft,
    To_char(dh.round_pick)          as numero_escolha_draft,
    Nvl(pli.greatest_75_flag, 'N')  as top_75_jogadores,
    dh.team_name                    as time_draft,
    dh.team_city                    as time_draft_cidade,
    dh.team_abbreviation            as time_abrv,
    dh.organization_name            as organizacao_antes_nba,
    dh.organization_type            as organizacao_tipo
from nba_curated_db.nba_curated_schema.player pl
inner join nba_curated_db.nba_curated_schema.common_player_info pli 
    on pl.id = pli.person_id
inner join nba_curated_db.nba_curated_schema.draft_history dh
    on pl.id = dh.person_id;
    
// Query Fato_Stats_Temporada
select
    pl.id                       as pk_player,
    tm.id                       as pk_team,
    season_year-1 || '-' || Substr(season_year, 3, 4)        as temporada,
    sst.player_age              as idade_jogador,
    sst.player_position         as posicao_jogador,
    sst.games                   as jogos,
    sst.minutes_played          as minutos_jogados,
    sst.field_goals_attempts    as tentativas_arremessos,
    sst.field_goals             as acertos_aremessos,
    sst.field_goal_perc         as perc_acertos_arremessos,
    sst.three_point_fg_attempt  as tentativas_arremessos_3pt,
    sst.three_point_fg          as acertos_aremessos_3pt,
    sst.three_point_fg_perc     as perc_acertos_arremessos_3pt,
    sst.two_point_fg_attempt    as tentativas_arremessos_2pt,
    sst.two_point_fg            as acertos_aremessos_2pt,
    sst.two_point_fg_perc       as perc_acertos_arremessos_2pt,
    sst.effective_fg_perc       as perc_eficiencia_arremessos,
    sst.ft_point_fg_attempt     as tentativas_arremessos_lancelivre,
    sst.ft_point_fg             as acertos_aremessos_lancelivre,
    sst.ft_point_fg_perc        as perc_acertos_arremessos_lancelivre,
    sst.offensive_rebound       as rebotes_ofensivos,
    sst.defensive_rebound       as rebotes_defensivos,
    sst.assists                 as assistencias,
    sst.steals                  as roubos,
    sst.blocks                  as bloqueios,
    sst.turnovers               as turnovers,
    sst.personal_fouls          as faltas,
    sst.points                  as pontos
    
from nba_curated_db.nba_curated_schema.season_stats sst
inner join nba_curated_db.nba_curated_schema.player pl
    on pl.id = sst.id_person
inner join nba_curated_db.nba_curated_schema.team tm
    on sst.team = tm.abbreviation
order by sst.season_year asc;

// Query Dim_Time
select
    tm.id           as pk_time,
    tm.full_name    as nome_time,
    tm.abbreviation as nome_abreviado,
    tm.nickname     as apelido,
    tm.state        as estado,
    tm.city         as cidade,
    tm.year_founded as ano_fundacao
from nba_curated_db.nba_curated_schema.team tm;

// Query Fato_Jogo
select
    gm.game_id              as pk_jogo,
    gm.team_id_away         as pk_time,
    'Casa'                  as posicao_time,
    gms.season || '-' || Substr(gms.season+1, 3, 4) as temporada,
    to_date(gm.game_date)   as data_jogo,
    gm.team_name_away       as adversario,
    gm.wl_away              as ganhou_perdeu,
    gm.reb_away             as rebotes,
    gm.ast_away             as assistencias,
    gm.stl_away             as roubos,
    gm.blk_away             as bloqueios,
    gm.tov_away             as turnovers,
    gm.pf_away              as faltas,
    gm.pts_away             as pontos,
    gm.season_type          as tipo_temporada,
from nba_curated_db.nba_curated_schema.game gm
left join nba_curated_db.nba_curated_schema.game_summary gms
    on gm.game_id = gms.game_id
where gm.season_type not in ('Pre Season', 'All Star', 'All-Star')
    
UNION ALL

select
    gm.game_id              as pk_jogo,
    gm.team_id_home         as pk_time,
    'Visitante'             as posicao_time,
    gms.season || '-' || Substr(gms.season+1, 3, 4) as temporada,
    to_date(gm.game_date)   as data_jogo,
    gm.team_name_away       as adversario,
    gm.wl_home              as ganhou_perdeu,
    gm.reb_home             as rebotes,
    gm.ast_home             as assistencias,
    gm.stl_home             as roubos,
    gm.blk_home             as bloqueios,
    gm.tov_home             as turnovers,
    gm.pf_home              as faltas,
    gm.pts_home             as pontos,
    gm.season_type          as tipo_temporada,
from nba_curated_db.nba_curated_schema.game gm
left join nba_curated_db.nba_curated_schema.game_summary gms
    on gm.game_id = gms.game_id
where gm.season_type not in ('Pre Season', 'All Star', 'All-Star');

//Query Dim_Arbitro_Jogo
select
    off.official_id as pk_arbitro,
    off.game_id     as pk_jogo,
    off.first_name  as nome,
    off.last_name   as sobrenome
from nba_curated_db.nba_curated_schema.officials off;


-------------------------------------------------------------------------------------------    

//Table Dim_Jogador
create or replace table dim_jogador 
(
    pk_player number(12,0)              comment 'id jogador',
    nome_completo varchar(40)           comment 'Nome completo jogador',
    nome varchar(20)                    comment 'Primeiro nome jogador',
    sobrenome varchar(30)               comment 'Sobrenome jogador',
    em_atividade number(1,0)            comment 'Flag para definir se o jogador esteve em atividade até 2023',
    data_nascimento date                comment 'Data de nascimento do jogador',
    universidade varchar(80)            comment 'Universidade em que o jogador jogou',
    pais varchar(40)                    comment 'Pais de origem do jogador',
    altura_polegadas number(3,0)        comment 'Altura do jogador em polegadas',
    altura_cm number(3,0)               comment 'Altura do jogador em cm',
    altura_pes varchar(4)               comment 'Altura do jogador em pés',
    peso_libras number(3,0)             comment 'Peso do jogador em libras',
    peso_kg number(3,0)                 comment 'Peso do jogador em kg',
    temporadas number(2,0)              comment 'Temporadas as quais o jogador atuou até 2023',
    num_camisa varchar(10)              comment 'Último número da camisa',
    posicao varchar(20)                 comment 'Posição do jogador',
    primeiro_ano_nba date               comment 'Primeiro ano de NBA',
    ultimo_ano_nba date                 comment 'Último ano de NBA registrado até 2023',
    rodada_draft varchar(3)             comment 'Rodada de escolha do jogador no draft',
    numero_escolha_draft varchar(3)     comment 'Número da escolha do jogador na rodada do draft',
    top_75_jogadores varchar(1)         comment 'Flag para definir se o jogador é um dos maiores 75 de todos os tempos',
    time_draft varchar(80)              comment 'Time que "draftou" o jogador',
    time_draft_cidade varchar(40)       comment 'Cidade do time que "draftou" o jogador',
    time_abrv varchar(3)                comment 'Nome abreviado do time que "draftou" o jogador',
    organizacao_antes_nba varchar(80)   comment 'Organização a qual o jogador atuou antes de ser "draftado"',
    organizacao_tipo varchar(18)        comment 'Tipo de organização a qual o jogador atuou antes de ser "draftado"'
);

//Table Fato_Stats_Temporada
create or replace table fato_stats_temporada 
(
    pk_player number(12,0)                          comment 'id jogador',
    pk_team number(12,0)                            comment 'id Time',
    temporada varchar(20)                           comment 'Temporada em que o jogador atuou',
    idade_jogador number(2,0)                       comment 'Idade do jogador',
    posicao_jogador varchar(20)                     comment 'Posição do jogador',
    jogos number(3,0)                               comment 'Quantidade de jogos em que o jogador atuou',
    minutos_jogados number(5,0)                     comment 'Minutos jogados pelo jogador',
    tentativas_arremessos number(4,0)               comment 'Total de arremessos',
    acertos_aremessos number(4,0)                   comment 'Total de acertos de arremessos',
    perc_acertos_arremessos number(4,2)             comment 'Percentual de acertos sobre arremessos',
    tentativas_arremessos_3pt number(4,0)           comment 'Total de arremessos de 3pt',
    acertos_aremessos_3pt number(4,0)               comment 'Total de acertos de arremessos de 3pt',
    perc_acertos_arremessos_3pt number(4,2)         comment 'Percentual de acertos sobre arremessos de 3pt',
    tentativas_arremessos_2pt number(4,0)           comment 'Total de arremessos de 2pt',
    acertos_aremessos_2pt number(4,0)               comment 'Total de acertos de arremessos de 2pt',
    perc_acertos_arremessos_2pt number(4,2)         comment 'Percentual de acertos sobre arremessos de 2pt',
    perc_eficiencia_arremessos number(4,2)          comment 'Percentual de arremessos eficazes, leva em consideração que os arremessos de 3pt valem mais',
    tentativas_arremessos_lancelivre number(4,0)    comment 'Total de lances livres',
    acertos_aremessos_lancelivre number(4,0)        comment 'Total de acertos em lances livres',
    perc_acertos_arremessos_lancelivre number(4,2)  comment 'Percentual de acertos sobre lances livres',
    rebotes_ofensivos number(4,0)                   comment 'Total de rebotes ofensivos',
    rebotes_defensivos number(4,0)                  comment 'Total de rebotes defensivos',
    assistencias number(4,0)                        comment 'Total de assistências',
    roubos number(4,0)                              comment 'Total de roubos de bola',
    bloqueios number(4,0)                           comment 'Total de bloqueios',
    turnovers number(4,0)                           comment 'Total de turnovers',
    faltas number(4,0)                              comment 'Total de Faltas',
    pontos number(4,0)                              comment 'Total de pontos'
);

//Table Dim_Time
create or replace table dim_time 
(
    pk_time number(12,0)        comment 'id_time',
    nome_time varchar(40)       comment 'Nome do time',
    nome_abreviado varchar(30)  comment 'Nome abreviado do time',
    apelido varchar(30)         comment 'Apelido do time',
    estado varchar(40)          comment 'Estado do time',
    cidade varchar(40)          comment 'Cidade do time',
    ano_fundacao number(4,0)    comment 'Ano de Fundação do time'
);

//Table Fato_Jogo
create or replace table fato_jogo
(
    pk_jogo number(12,0)        comment 'id Jogo',
    pk_time number(12,0)        comment 'id Time',
    posicao_time varchar(20)    comment 'Define se o time jogou em casa ou fora',
    temporada varchar(20)       comment 'Temporada',
    data_jogo date              comment 'Data do jogo',
    adversario varchar(40)      comment 'Adversario',
    ganhou_perdeu varchar(12)   comment 'Define se o time venceu ou perdeu a partida',
    rebotes number(4,0)         comment 'Total de rebotes',
    assistencias number(4,0)    comment 'Total de assistências',
    roubos number(4,0)          comment 'Total de roubos',
    bloqueios number(4,0)       comment 'Total de bloqueios',
    turnovers number(4,0)       comment 'Total de turnovers',
    faltas number(4,0)          comment 'Total de faltas',
    pontos number(4,0)          comment 'Total de pontos',
    tipo_temporada varchar(30)  comment 'Define qual é a situação da temporada (regular/playoffs)'
);

//Table Dim_Arbitro_Jogo
create or replace table dim_arbitro_jogo
(
    pk_arbitro number(12,0) comment 'id Arbitro',
    pk_jogo number(12,0)    comment 'id Jogo',
    nome varchar(30)        comment 'Nome Arbitro',
    sobrenome varchar(30)   comment 'Sobrenome Arbitro'
);

-------------------------------------------------------------------------------------------

// Load data into dimensions/facts
insert into dim_jogador
select 
    dh.person_id                    as pk_player,
    pl.full_name                    as nome_completo,
    pl.first_name                   as nome,
    pl.last_name                    as sobrenome,
    Nvl(pl.is_active, 0)            as em_atividade,
    to_date(pli.birthdate)          as data_nascimento,
    Nvl(pli.school, dh.organization_name)   as universidade,
    pli.country                     as pais,
    Round((Substr(height, 1, charindex('-',height)-1)*12) + Substr(height, charindex('-',height)+1, Length(height))) as altura_polegadas,
    Round(((Substr(height, 1, charindex('-',height)-1)*12) + Substr(height, charindex('-',height)+1, Length(height)))*2.54) as altura_cm,
    Replace(height, '-', '\'')      as altura_pes,
    Round(pli.weight)               as peso_libras,
    Round(pli.weight/2.205)         as peso_kg,
    pli.season_exp                  as temporadas,
    pli.jersey                      as num_camisa,
    pli.player_position             as posicao,
    Date(Nvl(pli.from_year, dh.season), 'yyyy')     as primeiro_ano_nba,
    Date(pli.to_year, 'yyyy')                       as ultimo_ano_nba,
    dh.draft_round                  as rodada_draft,
    To_char(dh.round_pick)          as numero_escolha_draft,
    Nvl(pli.greatest_75_flag, 'N')  as top_75_jogadores,
    dh.team_name                    as time_draft,
    dh.team_city                    as time_draft_cidade,
    dh.team_abbreviation            as time_abrv,
    dh.organization_name            as organizacao_antes_nba,
    dh.organization_type            as organizacao_tipo
from nba_curated_db.nba_curated_schema.player pl
inner join nba_curated_db.nba_curated_schema.common_player_info pli 
    on pl.id = pli.person_id
inner join nba_curated_db.nba_curated_schema.draft_history dh
    on pl.id = dh.person_id;


//
insert into fato_stats_temporada
select
    pl.id                       as pk_player,
    tm.id                       as pk_team,
    season_year-1 || '-' || Substr(season_year, 3, 4)        as temporada,
    sst.player_age              as idade_jogador,
    sst.player_position         as posicao_jogador,
    sst.games                   as jogos,
    sst.minutes_played          as minutos_jogados,
    sst.field_goals_attempts    as tentativas_arremessos,
    sst.field_goals             as acertos_aremessos,
    sst.field_goal_perc         as perc_acertos_arremessos,
    sst.three_point_fg_attempt  as tentativas_arremessos_3pt,
    sst.three_point_fg          as acertos_aremessos_3pt,
    sst.three_point_fg_perc     as perc_acertos_arremessos_3pt,
    sst.two_point_fg_attempt    as tentativas_arremessos_2pt,
    sst.two_point_fg            as acertos_aremessos_2pt,
    sst.two_point_fg_perc       as perc_acertos_arremessos_2pt,
    sst.effective_fg_perc       as perc_eficiencia_arremessos,
    sst.ft_point_fg_attempt     as tentativas_arremessos_lancelivre,
    sst.ft_point_fg             as acertos_aremessos_lancelivre,
    sst.ft_point_fg_perc        as perc_acertos_arremessos_lancelivre,
    sst.offensive_rebound       as rebotes_ofensivos,
    sst.defensive_rebound       as rebotes_defensivos,
    sst.assists                 as assistencias,
    sst.steals                  as roubos,
    sst.blocks                  as bloqueios,
    sst.turnovers               as turnovers,
    sst.personal_fouls          as faltas,
    sst.points                  as pontos
from nba_curated_db.nba_curated_schema.season_stats sst
inner join nba_curated_db.nba_curated_schema.player pl
    on pl.id = sst.id_person
inner join nba_curated_db.nba_curated_schema.team tm
    on sst.team = tm.abbreviation
order by sst.season_year asc;

//
insert into dim_time
select
    tm.id           as pk_time,
    tm.full_name    as nome_time,
    tm.abbreviation as nome_abreviado,
    tm.nickname     as apelido,
    tm.state        as estado,
    tm.city         as cidade,
    tm.year_founded as ano_fundacao
from nba_curated_db.nba_curated_schema.team tm;

//
insert into fato_jogo
select
    gm.game_id              as pk_jogo,
    gm.team_id_away         as pk_time,
    'Casa'                  as posicao_time,
    gms.season || '-' || Substr(gms.season+1, 3, 4) as temporada,
    to_date(gm.game_date)   as data_jogo,
    gm.team_name_away       as adversario,
    gm.wl_away              as ganhou_perdeu,
    gm.reb_away             as rebotes,
    gm.ast_away             as assistencias,
    gm.stl_away             as roubos,
    gm.blk_away             as bloqueios,
    gm.tov_away             as turnovers,
    gm.pf_away              as faltas,
    gm.pts_away             as pontos,
    gm.season_type          as tipo_temporada,
from nba_curated_db.nba_curated_schema.game gm
left join nba_curated_db.nba_curated_schema.game_summary gms
    on gm.game_id = gms.game_id
where gm.season_type not in ('Pre Season', 'All Star', 'All-Star')
    
UNION ALL

select
    gm.game_id              as pk_jogo,
    gm.team_id_home         as pk_time,
    'Visitante'             as posicao_time,
    gms.season || '-' || Substr(gms.season+1, 3, 4) as temporada,
    to_date(gm.game_date)   as data_jogo,
    gm.team_name_away       as adversario,
    gm.wl_home              as ganhou_perdeu,
    gm.reb_home             as rebotes,
    gm.ast_home             as assistencias,
    gm.stl_home             as roubos,
    gm.blk_home             as bloqueios,
    gm.tov_home             as turnovers,
    gm.pf_home              as faltas,
    gm.pts_home             as pontos,
    gm.season_type          as tipo_temporada,
from nba_curated_db.nba_curated_schema.game gm
left join nba_curated_db.nba_curated_schema.game_summary gms
    on gm.game_id = gms.game_id
where gm.season_type not in ('Pre Season', 'All Star', 'All-Star');

//
insert into dim_arbitro_jogo
select
    off.official_id as pk_arbitro,
    off.game_id     as pk_jogo,
    off.first_name  as nome,
    off.last_name   as sobrenome
from nba_curated_db.nba_curated_schema.officials off;
    
-------------------------------------------------------------------------------------------