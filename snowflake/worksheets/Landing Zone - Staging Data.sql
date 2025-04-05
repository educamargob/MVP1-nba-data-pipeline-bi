use role accountadmin;

-------------------------------------------------------------------------------------------

// creating dw, db and role
create warehouse nba_staging_wh with warehouse_size='x-small';
create database if not exists nba_landing_db;
create role if not exists nba_role;

-------------------------------------------------------------------------------------------

// granting for role created
show grants on warehouse nba_staging_wh;

grant usage on warehouse nba_staging_wh to role nba_role;
grant all on database nba_landing_db to role nba_role;

-------------------------------------------------------------------------------------------

use role nba_role;

// creating schema
create schema if not exists nba_landing_db.nba_landing_schema;
grant all on schema nba_landing_db.nba_landing_schema to role accountadmin;

-------------------------------------------------------------------------------------------

// creating stage
create stage nba_stage directory = ( enable = true ) encryption = ( type = 'SNOWFLAKE_SSE' );
//check the contents of the stage
-- list @nba_stage;

-------------------------------------------------------------------------------------------

// creating file format
create or replace file format CSV
    type = csv 
    ield_delimiter = ',' 
    field_optionally_enclosed_by='"' //Evita considerar virgula dentro de strings
    skip_header = 1;

-------------------------------------------------------------------------------------------

use schema nba_landing_db.nba_landing_schema;

// creating tables

/// Dim Player
create or replace table player
(id integer         comment 'id Jogador',
full_name string    comment 'Nome completo',
first_name string   comment 'Nome',
last_name string    comment 'Sobrenome',
is_active integer   comment 'Em atividade'
);

create or replace table common_player_info
(
person_id integer                          comment 'id Jogador',
first_name string                           comment 'Nome',
last_name string                            comment 'Sobrenome',
display_first_last string                   comment 'Nome Sobrenome',
display_last_comma_first string             comment 'Sobrenome, Nome',
display_fi_last string                      comment 'N. Sobrenome (nome abreviado)',
player_slug string                          comment 'nome-sobrenome',
birthdate timestamp                         comment 'DataHora nascimento',
school string                               comment 'Universidade',
country string                              comment 'País de origem do jogador',
last_affiliation string                     comment 'Último time',
height string                               comment 'Altura em pés',
weight float                                comment 'Peso em Libras',
season_exp integer                          comment 'Tempo de experiência',
jersey string                               comment 'N° Camisa',
player_position string                      comment 'Posição do Jogador',
rosterstatus string,
games_played_current_season_flag string     comment 'Flag / Jogou na temporada atual',
team_id integer                             comment 'id Time',
team_name string                            comment 'Nome Time',
team_abbreviation string                    comment 'Nome Time Abreviado',
team_code string                            comment 'Código Time',
team_city string                            comment 'Time Cidade',
playercode string                           comment 'Código Jogador',
from_year integer                           comment 'Ano Início Carreira',
to_year integer                             comment 'Ano Fim Carreira',
dleague_flag string                         comment 'Flag / Jogou na Liga de desenvolvimento',
nba_flag string,
games_played_flag string,
draft_year string                           comment 'Ano Draft',
draft_round string                          comment 'Rodada Draft',
draft_number string                         comment 'Draft Num Escolha',
greatest_75_flag string
);

create or replace table draft_combine_stats
(season string                          comment 'Temporada',
player_id integer                       comment 'id Jogador',
first_name string                       comment 'Nome',
last_name string                        comment 'Sobrenome',
player_name string                      comment 'Nome Completo',
player_position string                  comment 'Posição do Jogador',
height_wo_shoes float                   comment 'Altura sem tênis (Polegadas)',
height_wo_shoes_ft_in string            comment 'Altura sem tênis (Pés)',
height_w_shoes float                    comment 'Altura com tênis (Polegadas)',
height_w_shoes_ft_in string             comment 'Altura com tênis (Pés)',
weight float                            comment 'Peso (Libras)',
wingspan float                          comment 'Envergadura (Polegadas)',
wingspan_ft_in string                   comment 'Envergadura (Pés)',
standing_reach float                    comment 'Alcance em pé (Polegadas)',
standing_reach_ft_in string             comment 'Alcance em pé (Pés)',
body_fat_pct float                      comment 'Gordura corporal',
hand_length float                       comment 'Comprimento da mão (Polegadas)',
hand_width float                        comment 'Largura da mão (Polegadas)',
standing_vertical_leap float            comment 'Altura do salto vertical',
max_vertical_leap float                 comment 'Altura Máxima do salto vertical',
lane_agility_time float                 comment 'Tempo Agilidade Corrida',
modified_lane_agility_time float        comment 'Tempo Agilidade Corrida pista modificada',
three_quarter_sprint float              comment 'Corrida 3 Quartos',
bench_press float                       comment 'Repetições Supino',
spot_fifteen_corner_left string         comment 'Acertos arremesso (corner_left)',
spot_fifteen_break_left string          comment 'Acertos arremesso (break_left)',
spot_fifteen_top_key string             comment 'Acertos arremesso (top_key)',
spot_fifteen_break_right string         comment 'Acertos arremesso (break_right)',
spot_fifteen_corner_right string        comment 'Acertos arremesso (corner_right)',
spot_college_corner_left string         comment 'Acertos arremesso Universidade (corner_left)',
spot_college_break_left string          comment 'Acertos arremesso Universidade (break_left)',
spot_college_top_key string             comment 'Acertos arremesso Universidade (top_key)',
spot_college_break_right string         comment 'Acertos arremesso Universidade (break_right)',
spot_college_corner_right string        comment 'Acertos arremesso Universidade (corner_right)',
spot_nba_corner_left string             comment 'Acertos arremesso NBA (corner_left)',
spot_nba_break_left string              comment 'Acertos arremesso NBA (break_left)',
spot_nba_top_key string                 comment 'Acertos arremesso NBA (top_key)',
spot_nba_break_right string             comment 'Acertos arremesso NBA (break_right)',
spot_nba_corner_right string            comment 'Acertos arremesso NBA (corner_right)',
off_drib_fifteen_break_left string      comment 'Acertos arremesso após drible (break_left)',
off_drib_fifteen_top_key string         comment 'Acertos arremesso após drible (top_key)',
off_drib_fifteen_break_right string     comment 'Acertos arremesso após drible (break_right)',
off_drib_college_break_left string      comment 'Acertos arremesso após drible Universidade (break_left)',
off_drib_college_top_key string         comment 'Acertos arremesso após drible Universidade(top_key)',
off_drib_college_break_right string     comment 'Acertos arremesso após drible Universidade (break_right)',
on_move_fifteen string                  comment 'Acertos arremesso em movimento',
on_move_college string                  comment 'Acertos arremesso em movimento Universidade'
);

create or replace table draft_history
(person_id integer              comment 'id Jogador',
player_name string              comment 'Nome Completo',
season integer                  comment 'Temporada Ano',
draft_round string              comment 'Rodada Draft',
round_pick integer              comment 'Draft Num Escolha',
overall_pick integer            comment 'Num Escolha Geral',
draft_type string               comment 'Tipo Draft',
team_id integer                 comment 'id Time',
team_city string                comment 'Cidade Time',
team_name string                comment 'Nome Time',
team_abbreviation string        comment 'Nome Time Abreviado',
organization_name string        comment 'Nome Organização que revelou jogador',
organization_type string        comment 'Tipo Organização que revelou jogador',
player_profile_flag integer     comment 'Flag Perfil de Jogador'
);

-------------------------------------------------------------------------------------------

/// Fact season stats - changing field names
create or replace table season_stats
(idx integer                    comment 'Índice',
season_year integer             comment 'Ano Draft',
player_name string              comment 'Nome Completo Jogador',
player_position string          comment 'Posição do Jogador',
player_age integer              comment 'Idade Jogador',
team string                     comment 'Nome Time',
games integer                   comment 'Qtd. Jogos',
games_started integer           comment 'Qtd. Jogos Iniciados',
minutes_played integer          comment 'Minutos Jogados',
player_efficiency_rate float    comment 'Taxa de Eficiência do Jogador',
true_shooting_perc float        comment 'Porcentagem de Arremessos',
three_point_attempt_rate float  comment 'Taxa de tentativas de 3 pontos',
free_throw_rate float           comment 'Taxa de Acerto lance livres',
offensive_rebound_perc float    comment '% Rebotes ofensivos',
defensive_rebound_perc float    comment '% Rebotes defensivos',
total_rebound_perc float        comment '% Total rebotes',
assist_perc float               comment '% Assistências',
steal_perc float                comment '% Roubos de bola',
block_perc float                comment '% Bloqueios',
turnover_perc float             comment '% Turnover',
usage_perc float                comment '% de Uso do jogador',
blank string,
offensive_win_shares float      comment 'Média de ganho de disputa de bola ofensiva',
defensive_win_shares float      comment 'Média de ganho de disputa de bola defensiva',
win_shares float                comment 'Ganho de Disputa de bola',
win_share_per_fortyeight float  comment 'Ganho de Disputa de bola por 48 minutos',
blank2 string,
offensive_box_plus_minus float  comment 'Impacto ofensivo Jogador',
defensive_box_plus_minus float  comment 'Impacto defensivo Jogador',
box_plus_minus float            comment 'Impacto Jogador',
value_over_replacement float    comment 'Valor em relação a reposição',
field_goals integer             comment 'Acerto de Aremessos',
field_goals_attempts integer    comment 'Tentativas de Aremessos',
field_goal_perc float           comment '% Acertos Aremessos',
three_point_fg integer          comment 'Acertos de 3 pts',
three_point_fg_attempt integer  comment 'Tentativas de 3 pts',
three_point_fg_perc float       comment '% Acertos de 3 pts',
two_point_fg integer            comment 'Acertos de 2 pts',
two_point_fg_attempt integer    comment 'Tentativas de 2 pts',
two_point_fg_perc float         comment '% Acertos de 3 pts',
effective_fg_perc float         comment 'Eficiencia dos Aremessos',
ft_point_fg integer             comment 'Acerto de Lance Livre',
ft_point_fg_attempt integer     comment 'Tentativas de Lance Livre',
ft_point_fg_perc float          comment '% Acerto de Lance Livre',
offensive_rebound integer       comment 'Rebotes ofensivos',
defensive_rebound integer       comment 'Rebotes Defensivos',
total_rebound integer           comment 'Rebotes Totais',
assists integer                 comment 'Assistências',
steals integer                  comment 'Roubos de Bola',
blocks integer                  comment 'Bloqueios',
turnovers integer               comment 'Turnovers',
personal_fouls integer          comment 'Faltas',
points integer                  comment 'Pontos Totais'
);

create or replace table inactive_players
(game_id integer            comment 'id Jogo',
player_id integer           comment 'id Jogador',
first_name string           comment 'Nome Jogador',
last_name string            comment 'Sobrenome Jogador',
jersey_num integer          comment 'N° Camisa',
team_id integer             comment 'id Time',
team_city string            comment 'Cidade Time',
team_name string            comment 'Nome Time',
team_abbreviation string    comment 'Nome Time Abreviado'
);

-------------------------------------------------------------------------------------------

// Dim Team
create or replace table team
(id integer         comment 'id Time',
full_name string    comment 'Nome Time',
abbreviation string comment 'Nome Time Abreviado',
nickname string     comment 'Apelido Time',
city string         comment 'Cidade Time',
state string        comment 'Estado Time',
year_founded float  comment 'Ano Fundação'
);

create or replace table team_details
(team_id integer            comment 'id Time',
abbreviation string         comment 'Nome Time Abreviação',
nickname string             comment 'Apelido Time',
yearfounded float           comment 'Ano Fundação Time',
city string                 comment 'Cidade Time',
arena string                comment 'Arena Time',
arenacapacity float         comment 'Capacidade Arena',
owner string                comment 'Dono Time',
generalmanager string       comment 'Gerente Geral Time',
headcoach string            comment 'Treinador Time',
dleagueaffiliation string   comment 'Time Liga Desenvolvimento',
facebook string,
instagram string,
twitter string
);

-------------------------------------------------------------------------------------------

// Fact Game
create or replace table game
(season_id integer              comment 'id Temporada',
team_id_home integer            comment 'id Time Casa',
team_abbreviation_home string   comment 'Nome Abreviado Time Casa',
team_name_home string           comment 'Nome Time Casa',
game_id integer                 comment 'id Jogo',
game_date timestamp             comment 'Data Jogo',
matchup_home string             comment 'Confronto Casa',
wl_home string                  comment 'Vitória/Derrota Casa',
minutes integer                 comment 'Minutos Jogo',
fgm_home float                  comment 'Acertos Arremessos Casa',
fga_home float                  comment 'Tentativas Arremessos Casa',
fg_pct_home float               comment '% Acertos Arremessos Casa',
fg3m_home float                 comment 'Acertos Arremesos 3pts Casa',
fg3a_home float                 comment 'Tentativas Arremesos 3pts Casa',
fg3_pct_home float              comment '% Acertos Arremesos 3pts Casa',
ftm_home float                  comment 'Acertos Lance Livre Casa',
fta_home float                  comment 'Tentativas Lance Livre Casa',
ft_pct_home float               comment '% Acertos Lance Livre Casa',
oreb_home float                 comment 'Rebotes Ofensivos Casa',
dreb_home float                 comment 'Rebotes Defensivos Casa',
reb_home float                  comment 'Rebotes Totais Casa',
ast_home float                  comment 'Assistências Casa',
stl_home float                  comment 'Roubos Casa',
blk_home float                  comment 'Bloqueios Casa',
tov_home float                  comment 'Turnovers Casa',
pf_home float                   comment 'Faltas Casa',
pts_home float                  comment 'Pontos Casa',
plus_minus_home integer         comment 'Impacto do Time Casa',
video_available_home integer    comment 'Video disponivel Casa',
team_id_away integer            comment 'id Time Visitante',
team_abbreviation_away string   comment 'Nome Abreviado Time Visitante',
team_name_away string           comment 'Nome Time Visitante',
matchup_away string             comment 'Confronto Visitante',
wl_away string                  comment 'Vitória/Derrota Visitante',
fgm_away float                  comment 'Acertos Arremessos Visitante',
fga_away float                  comment 'Tentativas Arremessos Visitante',
fg_pct_away float               comment '% Acertos Arremessos Visitante',
fg3m_away float                 comment 'Acertos Arremessos 3pt Visitante',
fg3a_away float                 comment 'Tentativas Arremessos 3pt Visitante',
fg3_pct_away float              comment '% Acertos Arremessos 3pt Visitante',
ftm_away float                  comment 'Acertos Lance Livre Visitante',
fta_away float                  comment 'Tentavias Lance Livre Visitante',
ft_pct_away float               comment '% Acertos Lance Livre Visitante',
oreb_away float                 comment 'Rebotes Ofensivos Visitante',
dreb_away float                 comment 'Rebotes Defensivos Visitante',
reb_away float                  comment 'Rebotes Totais Visitante',
ast_away float                  comment 'Assistências Visitante',
stl_away float                  comment 'Roubos de Bola Visitante',
blk_away float                  comment 'Bloqueios Visitante',
tov_away float                  comment 'Turnovers Visitante',
pf_away float                   comment 'Faltas Visitante',
pts_away float                  comment 'Pontos Visitante',
plus_minus_away integer         comment 'Impacto Time Visitante',
video_available_away integer    comment 'Video Disponivel Visitante',
season_type string              comment 'Tipo Temporada'
);

create or replace table game_summary
(game_date_est timestamp                    comment 'Data Estimada Jogo',
game_sequence float                         comment 'Sequência Jogo Playoff',
game_id integer                             comment 'id Jogo',
game_status_id integer                      comment 'id Status Jogo',
game_status_text string                     comment 'Status Jogo Texto',
gamecode string                             comment 'Código Jogo',
home_team_id integer                        comment 'id Time Casa',
visitor_team_id integer                     comment 'id Time Visitante',
season integer                              comment 'Temporada Ano',
live_period integer,
live_pc_time string,
natl_tv_broadcaster_abbreviation string     comment 'Nome Emissora',
live_period_time_bcast string,
wh_status integer
);

-------------------------------------------------------------------------------------------

// Dim Officials
create or replace table officials
(game_id integer    comment 'id Jogo',
official_id integer comment 'id Arbitro',
first_name string   comment 'Nome Arbitro',
last_name string    comment 'Sobrenome Arbitro',
jersey_num integer  comment 'Num Camisa'
);

-------------------------------------------------------------------------------------------

// loading data into tables
copy into player from @nba_stage
files = ( 'player.csv' )
file_format = CSV;

select * from player;

copy into common_player_info from @nba_stage  //ERRO Atenção
files = ( 'common_player_info.csv' )
file_format = CSV;

select * from common_player_info;

copy into draft_combine_stats from @nba_stage
files = ( 'draft_combine_stats.csv' )
file_format = CSV;

select * from draft_combine_stats;

copy into draft_history from @nba_stage
files = ( 'draft_history.csv' )
file_format = CSV;

select * from draft_history;

copy into season_stats from @nba_stage
files = ( 'Seasons_Stats.csv' )
file_format = CSV;

select * from season_stats;

copy into inactive_players from @nba_stage
files = ( 'inactive_players.csv' )
file_format = CSV;

select * from inactive_players;

copy into team from @nba_stage
files = ( 'team.csv' )
file_format = CSV;

select * from team;

copy into team_details from @nba_stage
files = ( 'team_details.csv' )
file_format = CSV;

select * from team_details;

copy into game from @nba_stage
files = ( 'game.csv' )
file_format = CSV;

select * from game;

copy into game_summary from @nba_stage
files = ( 'game_summary.csv' )
file_format = CSV;

select * from game_summary;

copy into officials from @nba_stage
files = ( 'officials.csv' )
file_format = CSV;

select * from officials;

-------------------------------------------------------------------------------------------

// drop wh, db and role
-- use role accountadmin;

-- drop warehouse if exists nba_staging_wh;
-- drop database if exists nba_landing_db;
-- drop role if exists nba_role;