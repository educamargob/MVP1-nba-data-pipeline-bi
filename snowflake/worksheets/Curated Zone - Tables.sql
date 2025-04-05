use role accountadmin;

-------------------------------------------------------------------------------------------

// creating db
create database if not exists nba_curated_db;

-------------------------------------------------------------------------------------------

// granting for role created
grant all on database nba_curated_db to role nba_role;

-------------------------------------------------------------------------------------------

use role nba_role;
use warehouse nba_analytics_wh;

// creating schema
create schema if not exists nba_curated_db.nba_curated_schema;
grant all on schema nba_curated_db.nba_curated_schema to role accountadmin;

-------------------------------------------------------------------------------------------


use schema nba_curated_db.nba_curated_schema;

// creating tables


/// Dim Player
create or replace table player
(id number(10,0)         comment 'id Jogador',
full_name varchar(40)    comment 'Nome completo',
first_name varchar(20)   comment 'Nome',
last_name varchar(30)    comment 'Sobrenome',
is_active number(1,0)    comment 'Em atividade'
);

create or replace table common_player_info
(
person_id number(10,0)                      comment 'id Jogador',
first_name varchar(20)                      comment 'Nome',
last_name varchar(30)                       comment 'Sobrenome',
display_first_last varchar(40)              comment 'Nome Sobrenome',
display_last_comma_first varchar(40)        comment 'Sobrenome, Nome',
display_fi_last varchar(40)                 comment 'N. Sobrenome (nome abreviado)',
player_slug varchar(40)                     comment 'nome-sobrenome',
birthdate timestamp                         comment 'DataHora nascimento',
school varchar(50)                          comment 'Universidade',
country varchar(40)                         comment 'País de origem do jogador',
last_affiliation varchar(50)                comment 'Último time',
height varchar(8)                           comment 'Altura em pés',
weight number(5,2)                          comment 'Peso em Libras',
season_exp number(2,0)                      comment 'Tempo de experiência',
jersey varchar(10)                          comment 'N° Camisa',
player_position varchar(40)                 comment 'Posição do Jogador',
rosterstatus varchar(12),
games_played_current_season_flag char(1)    comment 'Flag / Jogou na temporada atual',
team_id number(12,0)                        comment 'id Time',
team_name varchar(40)                       comment 'Nome Time',
team_abbreviation varchar(3)                comment 'Nome Time Abreviado',
team_code varchar(20)                       comment 'Código Time',
team_city varchar(40)                       comment 'Time Cidade',
playercode varchar(40)                      comment 'Código Jogador',
from_year number(4,0)                       comment 'Ano Início Carreira',
to_year number(4,0)                         comment 'Ano Fim Carreira',
dleague_flag char(1)                        comment 'Flag / Jogou na Liga de desenvolvimento',
nba_flag char(1),
games_played_flag char(1),
draft_year varchar(14)                      comment 'Ano Draft',
draft_round varchar(12)                     comment 'Rodada Draft',
draft_number varchar(12)                    comment 'Draft Num Escolha',
greatest_75_flag char(1)
);

create or replace table draft_combine_stats
(season varchar(4)                      comment 'Temporada',
player_id number(12,0)                  comment 'id Jogador',
first_name varchar(20)                  comment 'Nome',
last_name varchar(30)                   comment 'Sobrenome',
player_name varchar(40)                 comment 'Nome Completo',
player_position varchar(8)              comment 'Posição do Jogador',
height_wo_shoes number(8,2)             comment 'Altura sem tênis (Polegadas)',
height_wo_shoes_ft_in varchar(12)       comment 'Altura sem tênis (Pés)',
height_w_shoes number(8,2)              comment 'Altura com tênis (Polegadas)',
height_w_shoes_ft_in varchar(12)        comment 'Altura com tênis (Pés)',
weight number(8,2)                      comment 'Peso (Libras)',
wingspan number(8,2)                    comment 'Envergadura (Polegadas)',
wingspan_ft_in varchar(12)              comment 'Envergadura (Pés)',
standing_reach number(8,2)              comment 'Alcance em pé (Polegadas)',
standing_reach_ft_in varchar(12)        comment 'Alcance em pé (Pés)',
body_fat_pct number(8,2)                comment 'Gordura corporal',
hand_length number(8,2)                 comment 'Comprimento da mão (Polegadas)',
hand_width number(8,2)                  comment 'Largura da mão (Polegadas)',
standing_vertical_leap number(8,2)      comment 'Altura do salto vertical',
max_vertical_leap number(8,2)           comment 'Altura Máxima do salto vertical',
lane_agility_time number(8,2)           comment 'Tempo Agilidade Corrida',
modified_lane_agility_time number(8,2)  comment 'Tempo Agilidade Corrida pista modificada',
three_quarter_sprint number(8,2)        comment 'Corrida 3 Quartos',
bench_press number(8,2)                 comment 'Repetições Supino',
spot_fifteen_corner_left varchar(6)     comment 'Acertos arremesso (corner_left)',
spot_fifteen_break_left varchar(6)      comment 'Acertos arremesso (break_left)',
spot_fifteen_top_key varchar(6)         comment 'Acertos arremesso (top_key)',
spot_fifteen_break_right varchar(6)     comment 'Acertos arremesso (break_right)',
spot_fifteen_corner_right varchar(6)    comment 'Acertos arremesso (corner_right)',
spot_college_corner_left varchar(6)     comment 'Acertos arremesso Universidade (corner_left)',
spot_college_break_left varchar(6)      comment 'Acertos arremesso Universidade (break_left)',
spot_college_top_key varchar(6)         comment 'Acertos arremesso Universidade (top_key)',
spot_college_break_right varchar(6)     comment 'Acertos arremesso Universidade (break_right)',
spot_college_corner_right varchar(6)    comment 'Acertos arremesso Universidade (corner_right)',
spot_nba_corner_left varchar(6)         comment 'Acertos arremesso NBA (corner_left)',
spot_nba_break_left varchar(6)          comment 'Acertos arremesso NBA (break_left)',
spot_nba_top_key varchar(6)             comment 'Acertos arremesso NBA (top_key)',
spot_nba_break_right varchar(6)         comment 'Acertos arremesso NBA (break_right)',
spot_nba_corner_right varchar(6)        comment 'Acertos arremesso NBA (corner_right)',
off_drib_fifteen_break_left varchar(6)  comment 'Acertos arremesso após drible (break_left)',
off_drib_fifteen_top_key varchar(6)     comment 'Acertos arremesso após drible (top_key)',
off_drib_fifteen_break_right varchar(6) comment 'Acertos arremesso após drible (break_right)',
off_drib_college_break_left varchar(6)  comment 'Acertos arremesso após drible Universidade (break_left)',
off_drib_college_top_key varchar(6)     comment 'Acertos arremesso após drible Universidade(top_key)',
off_drib_college_break_right varchar(6) comment 'Acertos arremesso após drible Universidade (break_right)',
on_move_fifteen varchar(6)              comment 'Acertos arremesso em movimento',
on_move_college varchar(6)              comment 'Acertos arremesso em movimento Universidade'
);

create or replace table draft_history
(person_id number(10,0)             comment 'id Jogador',
player_name varchar(40)             comment 'Nome Completo',
season number(6,0)                  comment 'Temporada AnO',
draft_round varchar(4)              comment 'Rodada Draft',
round_pick number(4,0)              comment 'Draft Num Escolha',
overall_pick number(6,0)            comment 'Num Escolha Geral',
draft_type varchar(16)              comment 'Tipo Draft',
team_id number(12,0)                comment 'id Time',
team_city varchar(40)               comment 'Cidade Time',
team_name varchar(30)               comment 'Nome Time',
team_abbreviation varchar(6)        comment 'Nome Time Abreviado',
organization_name varchar(80)       comment 'Nome Organização que revelou jogador',
organization_type varchar(18)       comment 'Tipo Organização que revelou jogador',
player_profile_flag number(1,0)     comment 'Flag Perfil de Jogador'
);

-------------------------------------------------------------------------------------------

/// Fact season stats - changing field names
create or replace table season_stats
(idx number(10,0)                       comment 'Índice',
season_year number(4,0)                 comment 'Ano Draft',
player_name varchar(40)                 comment 'Nome Completo Jogador',
player_position varchar(10)             comment 'Posição do Jogador',
player_age number(3,0)                  comment 'Idade Jogador',
team varchar(10)                        comment 'Nome Time',
games number(4,0)                       comment 'Qtd. Jogos',
games_started number(4,0)               comment 'Qtd. Jogos Iniciados',
minutes_played number(8,0)              comment 'Minutos Jogados',
player_efficiency_rate number(10,2)     comment 'Taxa de Eficiência do Jogador',
true_shooting_perc number(8,2)          comment 'Porcentagem de Arremessos',
three_point_attempt_rate number(8,2)    comment 'Taxa de tentativas de 3 pontos',
free_throw_rate number(8,2)             comment 'Taxa de Acerto lance livres',
offensive_rebound_perc number(8,2)      comment '% Rebotes ofensivos',
defensive_rebound_perc number(8,2)      comment '% Rebotes defensivos',
total_rebound_perc number(8,2)          comment '% Total rebotes',
assist_perc number(8,2)                 comment '% Assistências',
steal_perc number(8,2)                  comment '% Roubos de bola',
block_perc number(8,2)                  comment '% Bloqueios',
turnover_perc number(8,2)               comment '% Turnover',
usage_perc number(8,2)                  comment '% de Uso do jogador',
blank char(1),
offensive_win_shares number(8,2)        comment 'Média de ganho de disputa de bola ofensiva',
defensive_win_shares number(8,2)        comment 'Média de ganho de disputa de bola defensiva',
win_shares number(8,2)                  comment 'Ganho de Disputa de bola',
win_share_per_fortyeight number(8,2)    comment 'Ganho de Disputa de bola por 48 minutos',
blank2 char(1),
offensive_box_plus_minus number(8,2)    comment 'Impacto ofensivo Jogador',
defensive_box_plus_minus number(8,2)    comment 'Impacto defensivo Jogador',
box_plus_minus number(8,2)              comment 'Impacto Jogador',
value_over_replacement number(8,2)      comment 'Valor em relação a reposição',
field_goals number(8,0)                 comment 'Acerto de Aremessos',
field_goals_attempts number(8,0)        comment 'Tentativas de Aremessos',
field_goal_perc number(8,2)             comment '% Acertos Aremessos',
three_point_fg number(8,0)              comment 'Acertos de 3 pts',
three_point_fg_attempt number(8,0)      comment 'Tentativas de 3 pts',
three_point_fg_perc number(8,2)         comment '% Acertos de 3 pts',
two_point_fg number(8,0)                comment 'Acertos de 2 pts',
two_point_fg_attempt number(8,0)        comment 'Tentativas de 2 pts',
two_point_fg_perc number(8,2)           comment '% Acertos de 3 pts',
effective_fg_perc number(8,2)           comment 'Eficiencia dos Aremessos',
ft_point_fg number(8,0)                 comment 'Acerto de Lance Livre',
ft_point_fg_attempt number(8,0)         comment 'Tentativas de Lance Livre',
ft_point_fg_perc number(8,2)            comment '% Acerto de Lance Livre',
offensive_rebound number(8,0)           comment 'Rebotes ofensivos',
defensive_rebound number(8,0)           comment 'Rebotes Defensivos',
total_rebound number(8,0)               comment 'Rebotes Totais',
assists number(8,0)                     comment 'Assistências',
steals number(8,0)                      comment 'Roubos de Bola',
blocks number(8,0)                      comment 'Bloqueios',
turnovers number(8,0)                   comment 'Turnovers',
personal_fouls number(8,0)              comment 'Faltas',
points number(8,0)                      comment 'Pontos Totais',
id_person varchar(40,0)
);

create or replace table inactive_players
(game_id number(10,0)            comment 'id Jogo',
player_id number(12,0)           comment 'id Jogador',
first_name varchar(20)           comment 'Nome Jogador',
last_name varchar(30)            comment 'Sobrenome Jogador',
jersey_num number(10,0)          comment 'N° Camisa',
team_id number(12,0)             comment 'id Time',
team_city varchar(40)            comment 'Cidade Time',
team_name varchar(40)            comment 'Nome Time',
team_abbreviation varchar(3)     comment 'Nome Time Abreviado'
);

-------------------------------------------------------------------------------------------

// Dim Team
create or replace table team
(id number(12,0)            comment 'id Time',
full_name varchar(40)       comment 'Nome Time',
abbreviation varchar(3)     comment 'Nome Time Abreviado',
nickname varchar(20)        comment 'Apelido Time',
city varchar(40)            comment 'Cidade Time',
state varchar(40)           comment 'Estado Time',
year_founded number(8,2)    comment 'Ano Fundação'
);

create or replace table team_details
(team_id number(12,0)          comment 'id Time',
abbreviation varchar(3)        comment 'Nome Time Abreviação',
nickname varchar(20)           comment 'Apelido Time',
yearfounded number(8,0)        comment 'Ano Fundação Time',
city varchar(40)               comment 'Cidade Time',
arena varchar(40)              comment 'Arena Time',
arenacapacity number(8,2)      comment 'Capacidade Arena',
owner varchar(40)              comment 'Dono Time',
generalmanager varchar(40)     comment 'Gerente Geral Time',
headcoach varchar(40)          comment 'Treinador Time',
dleagueaffiliation varchar(40) comment 'Time Liga Desenvolvimento',
facebook varchar(60),
instagram varchar(60),
twitter varchar(60)
);

-------------------------------------------------------------------------------------------

// Fact Game
create or replace table game
(season_id number(8,0)              comment 'id Temporada',
team_id_home number(12,0)           comment 'id Time Casa',
team_abbreviation_home varchar(3)   comment 'Nome Abreviado Time Casa',
team_name_home varchar(40)          comment 'Nome Time Casa',
game_id number(12,0)                comment 'id Jogo',
game_date timestamp                 comment 'Data Jogo',
matchup_home varchar(12)            comment 'Confronto Casa',
wl_home char(1)                     comment 'Vitória/Derrota Casa',
minutes number(3,0)                 comment 'Minutos Jogo',
fgm_home number(8,2)                comment 'Acertos Arremessos Casa',
fga_home number(8,2)                comment 'Tentativas Arremessos Casa',
fg_pct_home number(8,2)             comment '% Acertos Arremessos Casa',
fg3m_home number(8,2)               comment 'Acertos Arremesos 3pts Casa',
fg3a_home number(8,2)               comment 'Tentativas Arremesos 3pts Casa',
fg3_pct_home number(8,2)            comment '% Acertos Arremesos 3pts Casa',
ftm_home number(8,2)                comment 'Acertos Lance Livre Casa',
fta_home number(8,2)                comment 'Tentativas Lance Livre Casa',
ft_pct_home number(8,2)             comment '% Acertos Lance Livre Casa',
oreb_home number(8,2)               comment 'Rebotes Ofensivos Casa',
dreb_home number(8,2)               comment 'Rebotes Defensivos Casa',
reb_home number(8,2)                comment 'Rebotes Totais Casa',
ast_home number(8,2)                comment 'Assistências Casa',
stl_home number(8,2)                comment 'Roubos Casa',
blk_home number(8,2)                comment 'Bloqueios Casa',
tov_home number(8,2)                comment 'Turnovers Casa',
pf_home number(8,2)                 comment 'Faltas Casa',
pts_home number(8,2)                comment 'Pontos Casa',
plus_minus_home number(4,0)         comment 'Impacto do Time Casa',
video_available_home number(1,0)    comment 'Video disponivel Casa',
team_id_away number(12,0)           comment 'id Time Visitante',
team_abbreviation_away varchar(3)   comment 'Nome Abreviado Time Visitante',
team_name_away varchar(40)          comment 'Nome Time Visitante',
matchup_away varchar(12)            comment 'Confronto Visitante',
wl_away char(1)                     comment 'Vitória/Derrota Visitante',
fgm_away number(8,2)                comment 'Acertos Arremessos Visitante',
fga_away number(8,2)                comment 'Tentativas Arremessos Visitante',
fg_pct_away number(8,2)             comment '% Acertos Arremessos Visitante',
fg3m_away number(8,2)               comment 'Acertos Arremessos 3pt Visitante',
fg3a_away number(8,2)               comment 'Tentativas Arremessos 3pt Visitante',
fg3_pct_away number(8,2)            comment '% Acertos Arremessos 3pt Visitante',
ftm_away number(8,2)                comment 'Acertos Lance Livre Visitante',
fta_away number(8,2)                comment 'Tentavias Lance Livre Visitante',
ft_pct_away number(8,2)             comment '% Acertos Lance Livre Visitante',
oreb_away number(8,2)               comment 'Rebotes Ofensivos Visitante',
dreb_away number(8,2)               comment 'Rebotes Defensivos Visitante',
reb_away number(8,2)                comment 'Rebotes Totais Visitante',
ast_away number(8,2)                comment 'Assistências Visitante',
stl_away number(8,2)                comment 'Roubos de Bola Visitante',
blk_away number(8,2)                comment 'Bloqueios Visitante',
tov_away number(8,2)                comment 'Turnovers Visitante',
pf_away number(8,2)                 comment 'Faltas Visitante',
pts_away number(8,2)                comment 'Pontos Visitante',
plus_minus_away number(4,0)         comment 'Impacto Time Visitante',
video_available_away number(1,0)    comment 'Video Disponivel Visitante',
season_type varchar(20)             comment 'Tipo Temporada'
);

create or replace table game_summary
(game_date_est timestamp                        comment 'Data Estimada Jogo',
game_sequence number(8,2)                       comment 'Sequência Jogo Playoff',
game_id number(10,0)                            comment 'id Jogo',
game_status_id number(1,0)                      comment 'id Status Jogo',
game_status_text varchar(30)                    comment 'Status Jogo Texto',
gamecode varchar(20)                            comment 'Código Jogo',
home_team_id number(12,0)                       comment 'id Time Casa',
visitor_team_id number(12,0)                    comment 'id Time Visitante',
season number(8,0)                              comment 'Temporada Ano',
live_period number(1,0),
live_pc_time varchar(10),
natl_tv_broadcaster_abbreviation varchar(20)    comment 'Nome Emissora',
live_period_time_bcast varchar(30),
wh_status number(1,0)
);

-------------------------------------------------------------------------------------------

// Dim Officials
create or replace table officials
(game_id number(12,0)    comment 'id Jogo',
official_id number(12,0) comment 'id Arbitro',
first_name varchar(20)   comment 'Nome Arbitro',
last_name varchar(30)    comment 'Sobrenome Arbitro',
jersey_num number(10,0)  comment 'Num Camisa'
);

-------------------------------------------------------------------------------------------


// loading data into curated tables
insert into player
select * from nba_landing_db.nba_landing_schema.player;

insert into common_player_info
select * from nba_landing_db.nba_landing_schema.common_player_info;

insert into draft_combine_stats
select * from nba_landing_db.nba_landing_schema.draft_combine_stats;

insert into draft_history
select * from nba_landing_db.nba_landing_schema.draft_history;

insert into season_stats
select season_stats.*, null from nba_landing_db.nba_landing_schema.season_stats;

insert into inactive_players
select * from nba_landing_db.nba_landing_schema.inactive_players;

insert into team
select * from nba_landing_db.nba_landing_schema.team;

insert into team_details
select * from nba_landing_db.nba_landing_schema.team_details;

insert into game
select * from nba_landing_db.nba_landing_schema.game;

insert into game_summary
select * from nba_landing_db.nba_landing_schema.game_summary;

insert into officials
select * from nba_landing_db.nba_landing_schema.officials;



