use role nba_role;
use schema nba_curated_db.nba_curated_schema;
use warehouse nba_staging_wh;

// Upadte incorrect names / nicknames of players in SEASON_STATS table to match PLAYER table
delete from season_stats where player_name is null; //delete invalid reg 
update season_stats set player_name = Replace(player_name, '*', '') where player_name like'%*'; //Remove '*'
update season_stats set player_name = 'Metta World Peace' where player_name like'%Metta World%'; 
update season_stats set player_name = 'Paul Armstrong' where player_name like'%Curly Armstrong%';
update season_stats set player_name = 'Frank Brian' where player_name like'%Frankie Brian%';
update season_stats set player_name = 'Francis Crossin' where player_name like'%Chink Crossin%';
update season_stats set player_name = 'Billy Gabor' where player_name like'%Bill Gabor%'; 
update season_stats set player_name = 'Norman Glick' where player_name like'%Normie Glick%'; 
update season_stats set player_name = 'Bob Hahn' where player_name like'%Robert Hahn%';
update season_stats set player_name = 'Johnny Logan' where player_name like'%John Logan%';
update season_stats set player_name = 'John Niemiera' where player_name like'%Richie Niemiera%';
update season_stats set player_name = 'Frank Saul' where player_name like'%Pep Saul%';
update season_stats set player_name = 'Walter Budko' where player_name like'%Walt Budko%';
update season_stats set player_name = 'Thomas Eddleman' where player_name like'%Dike Eddleman%';
update season_stats set player_name = 'Elmer R. Gainer' where player_name like'%Elmer Gainer%';
update season_stats set player_name = 'Clarence Hermsen' where player_name like'%Kleggie Hermsen%';
update season_stats set player_name = 'Sidney Hertzberg' where player_name like'%Sonny Hertzberg%';
update season_stats set player_name = 'David Ralph Johnson' where player_name like'%Ralph Johnson%';
update player set full_name = 'David Ralph Johnson' where id like'%77139%';
update season_stats set player_name = 'Horace McKinney' where player_name like'%Bones McKinney%';
update season_stats set player_name = 'Estes Parham' where player_name like'%Easy Parham%';
update season_stats set player_name = 'Joseph Reiser' where player_name like'%Chick Reiser%';
update season_stats set player_name = 'Paul \'The Bear\' Hoffman' where player_name like'%Paul Hoffman%';
update season_stats set player_name = 'Goebel Ritter' where player_name like'%Tex Ritter%';
update season_stats set player_name = 'Butch Van Breda Kolff' where player_name like'%Butch Van%';
update season_stats set player_name = 'Whitey Von Nieda' where player_name like'%Whitey Von%';
update season_stats set player_name = 'Buckshot O\'Brien' where player_name like'%Ralph O\'Brien%';
update season_stats set player_name = 'Henry Darcey' where player_name like'%Pete Darcey%';
update season_stats set player_name = 'Francis Mahoney' where player_name like'%Mo Mahoney%';
update season_stats set player_name = 'Jim Phelan' where player_name like'%James Phelan%';
update season_stats set player_name = 'Richard Atha' where player_name like'%Dick Atha%';
update season_stats set player_name = 'Medford Park' where player_name like'%Med Park%';
update season_stats set player_name = 'Ken Sears' where player_name like'%Kenny Sears%';
update season_stats set player_name = 'William Bell' where player_name like'%Whitey Bell%';
update season_stats set player_name = 'George H. Bon Salle' where player_name like'%George Bon%';
update season_stats set player_name = 'Thomas Sanders' where player_name like'%Tom Sanders%';
update season_stats set player_name = 'Enoch Olsen' where player_name like'%Bud Olsen%';
update season_stats set player_name = 'Charles Vaughn' where player_name like'%Chico Vaughn%';
update season_stats set player_name = 'Emmette Bryant' where player_name like'%Em Bryant%';
update season_stats set player_name = 'Lloyd Dove' where player_name like'%Sonny Dove%';
update season_stats set player_name = 'Dennis Layton' where player_name like'%Mo Layton%';
update season_stats set player_name = 'Fred Boyd' where player_name like'%Freddie Boyd%';
update season_stats set player_name = 'Dewayne Scales' where player_name like'%DeWayne Scales%';
update season_stats set player_name = 'Flip Murray' where player_name like'%Ronald Murray%';
update season_stats set player_name = 'Gigi Datome' where player_name like'%Luigi Datome%';
update season_stats set player_name = 'Otto Porter Jr.' where player_name like'%Otto Porter%';
update season_stats set player_name = 'Wallace Jones' where player_name like'%Wah Wah%';
update season_stats set player_name = 'William Towery' where player_name like'%Blackie Towery%';
update season_stats set player_name = 'Al McGuire' where player_name like'%Alfred McGuire%';
update season_stats set player_name = 'Michael Kearns' where player_name like'%Mike Kearns%';
update season_stats set player_name = 'Lucian Whitaker' where player_name like'%Skippy Whitaker%';
update season_stats set player_name = 'James Davis' where player_name like'%Red Davis%';
update season_stats set player_name = 'Walter Devlin' where player_name like'%Corky Devlin%';
update season_stats set player_name = 'William Kennedy' where player_name like'%Pickles Kennedy%';
update season_stats set player_name = 'Bob Leonard' where player_name like'%Slick Leonard%';
update season_stats set player_name = 'Mccoy McLemore' where player_name like'%McCoy McLemore%';
update season_stats set player_name = 'Wilmer Hosket' where player_name like'%Bill Hosket%';
update season_stats set player_name = 'Cliff T. Robinson' where player_name like'%Cliff Robinson%';
update season_stats set player_name = 'John Cox' where player_name like'%Chubby Cox%';
update season_stats set player_name = 'World Free' where player_name like'%World B.%';
update season_stats set player_name = 'Sammy Smith' where player_name like'%Sam Smith%';
update season_stats set player_name = 'Dwayne Washington' where player_name like'%Pearl Washington%';
update season_stats set player_name = 'Juan Carlos Navarro' where player_name like'%Juan Carlos%';
update season_stats set player_name = 'Pooh Jeter' where player_name like'%Eugene Jeter%';
update season_stats set player_name = 'Dick Eichhorst' where player_name like'%Rich Eichhorst%';
update season_stats set player_name = 'Edward Davis' where player_name like'%Mickey Davis%';
update season_stats set player_name = 'Jeffrey Crompton' where player_name like'%Geoff Crompton%';
update season_stats set player_name = 'Keith Van Horn' where player_name like'%Keith Van%';
update season_stats set player_name = 'John Dillon' where player_name like'%Hook Dillon%';
update season_stats set player_name = 'Chuck Halbert' where player_name like'%Chick Halbert%';
update season_stats set player_name = 'Johnny Oldham' where player_name like'%John Oldham%';
update season_stats set player_name = 'Ward Gibson' where player_name like'%Hoot Gibson%';
update season_stats set player_name = 'George Sobek' where player_name like'%Chips Sobek%';
update season_stats set player_name = 'Robert Zawoluk' where player_name like'%Zeke Zawoluk%';
update season_stats set player_name = 'Bill Kenville' where player_name like'%Billy Kenville%';
//update season_stats set player_name = 'Bill Kenville' where player_name like'%Bobby Watson%';
update season_stats set player_name = 'Joel Ingram' where player_name like'%McCoy Ingram%';
update season_stats set player_name = 'Harvey Halbrook' where player_name like'%Swede Halbrook%';
update season_stats set player_name = 'Ronald Martin' where player_name like'%Whitey Martin%';
update season_stats set player_name = 'Charles Nash' where player_name like'%Cotton Nash%';
update season_stats set player_name = 'Luke Rackley' where player_name like'%Luther Rackley%';
update season_stats set player_name = 'Norm Van Lier' where player_name like'%Norm Van%';
update season_stats set player_name = 'Thomas Barr' where player_name like'%Moe Barr%';
update season_stats set player_name = 'Alvin Holt' where player_name like'%A.W. Holt%';
update season_stats set player_name = 'Charles Kupec' where player_name like'%C.J. Kupec%';
update season_stats set player_name = 'Eric Marsh' where player_name like'%Ricky Marsh%';
update season_stats set player_name = 'David Britton' where player_name like'%Dave Britton%';
update season_stats set player_name = 'Ronnie Grandison' where player_name like'%Ron Grandison%';
update season_stats set player_name = 'KJ McDaniels' where player_name like'%K.J. McDaniels%';
update season_stats set player_name = 'Mal McMullan' where player_name like'%Mal McMullen%';
update season_stats set player_name = 'Paul McConnell' where player_name like'%Bucky McConnell%';
update season_stats set player_name = 'Don Meineke' where player_name like'%Monk Meineke%';
update season_stats set player_name = 'Donald Ackerman' where player_name like'%Don Ackerman%';
update season_stats set player_name = 'Rabbit Walthour' where player_name like'%Isaac Walthour%';
update season_stats set player_name = 'Johnny Kerr' where player_name like'%Red Kerr%';
update season_stats set player_name = 'Arlen Bockhorn' where player_name like'%Bucky Bockhorn%';
update season_stats set player_name = 'John Clemens' where player_name like'%Barry Clemens%';
update season_stats set player_name = 'Dick Van Arsdale' where player_name like'%Dick Van%';
update season_stats set player_name = 'John Austin' where player_name like'%Johnny Austin%';
update season_stats set player_name = 'Chuck Lowery' where player_name like'%Charlie Lowery%';
update season_stats set player_name = 'Willie Smith' where player_name like'%William Smith%';
update season_stats set player_name = 'Tommy Patterson' where player_name like'%Tom Patterson%';
update season_stats set player_name = 'Russell Lee' where player_name like'%Russ Lee%';
update season_stats set player_name = 'Daniel Anderson' where player_name like'%Dan Anderson%';
update season_stats set player_name = 'Eugene Kennedy' where player_name like'%Goo Kennedy%';
update season_stats set player_name = 'Ted \'Hound Dog\' McClain' where player_name like'%Ted McClain%';
update season_stats set player_name = 'Jan Van Breda Kolff' where player_name like'%Jan Van%';
update season_stats set player_name = 'Micheal Ray Richardson' where player_name like'%Micheal Ray%';
update season_stats set player_name = 'Thomas Wilson' where player_name like'%Bubba Wilson%';
update season_stats set player_name = 'Jim Ray' where player_name like'%James Ray%';
update season_stats set player_name = 'Peter Verhoeven' where player_name like'%Pete Verhoeven%';
update season_stats set player_name = 'Eddielee Wilkins' where player_name like'%Eddie Lee%';
update season_stats set player_name = 'Luther Burden' where player_name like'%Ticky Burden%';
update season_stats set player_name = 'Michael Holton' where player_name like'%Mike Holton%';
update season_stats set player_name = 'Mike Phelps' where player_name like'%Michael Phelps%';
update season_stats set player_name = 'Vinny Del Negro' where player_name like'%Vinny Del%';
update season_stats set player_name = 'Ike Austin' where player_name like'%Isaac Austin%';
update season_stats set player_name = 'Michael Sweetney' where player_name like'%Mike Sweetney%';
update season_stats set player_name = 'Peter John Ramos' where player_name like'%Peter John%';
update season_stats set player_name = 'DJ Strawberry' where player_name like'%D.J. Strawberry%';
update season_stats set player_name = 'Luc Mbah a Moute' where player_name like'%Luc Mbah%';
update season_stats set player_name = 'AJ Price' where player_name like'%A.J. Price%';
update season_stats set player_name = 'Enes Freedom' where player_name like'%Enes Kanter%';
update season_stats set player_name = 'Perry Jones III' where player_name like'%Perry Jones%';
update season_stats set player_name = 'Johnny O\'Bryant III' where player_name like'%Johnny O\'Bryant%';
update season_stats set player_name = 'RJ Hunter' where player_name like'%R.J. Hunter%';
update season_stats set player_name = 'Kelly Oubre Jr.' where player_name like'%Kelly Oubre%';
update season_stats set player_name = 'Juancho Hernangomez' where player_name like'%Juan Hernangomez%';
update season_stats set player_name = 'Robert Nordmann' where player_name like'%Bevo Nordmann%';
update season_stats set player_name = 'Dwight Morrison' where player_name like'%Red Morrison%';
update season_stats set player_name = 'Tom Van Arsdale' where player_name like'%Tom Van%';
update season_stats set player_name = 'Tom Kron' where player_name like'%Tommy Kron%';
update season_stats set player_name = 'Arthur Williams' where player_name like'%Art Williams%';
update season_stats set player_name = 'Ernie Killum' where player_name like'%Earnie Killum%';
update season_stats set player_name = 'Nate Archibald' where player_name like'%Tiny Archibald%';
update season_stats set player_name = 'William Averitt' where player_name like'%Bird Averitt%';
update season_stats set player_name = 'Joey Hassett' where player_name like'%Joe Hassett%';
update season_stats set player_name = 'Roylee Hamilton' where player_name like'%Roy Hamilton%';
update season_stats set player_name = 'Joe Barry Carroll' where player_name like'%Joe Barry%';
update season_stats set player_name = 'Ron Valentine' where player_name like'%Ronnie Valentine%';
update season_stats set player_name = 'Charles Whitney' where player_name like'%Hawkeye Whitney%';
update season_stats set player_name = 'Lafayette Lever' where player_name like'%Fat Lever%';
update season_stats set player_name = 'Mike Wilson' where player_name like'%Michael Wilson%';
update season_stats set player_name = 'Kent Edelin' where player_name like'%Kenton Edelin%';
update season_stats set player_name = 'Lou Dampier' where player_name like'%Louie Dampier%';
update season_stats set player_name = 'Tommy Green' where player_name like'%Tommie Green%';
update season_stats set player_name = 'Edmund Sherod' where player_name like'%Ed Sherod%';
update season_stats set player_name = 'Robert Rose' where player_name like'%Rob Rose%';
update season_stats set player_name = 'Nick Van Exel' where player_name like'%Nick Van%';
update season_stats set player_name = 'Mark Baker' where player_name like'%LaMark Baker%';
update season_stats set player_name = 'Jeff Sheppard' where player_name like'%Jeffrey Sheppard%';
update season_stats set player_name = 'Roger Mason Jr.' where player_name like'%Roger Mason%';
update season_stats set player_name = 'DJ Mbenga' where player_name like'%Didier Ilunga-Mbenga%';
update season_stats set player_name = 'CJ Miles' where player_name like'%C.J. Miles%';
update season_stats set player_name = 'JJ Hickson' where player_name like'%J.J. Hickson%';
update season_stats set player_name = 'DJ White' where player_name like'%D.J. White%';
update season_stats set player_name = 'DJ Stephens' where player_name like'%D.J. Stephens%';
update season_stats set player_name = 'James Michael McAdoo' where player_name like'%James Michael%';
update season_stats set player_name = 'Sheldon Mac' where player_name like'%Sheldon McClellan%';
update season_stats set player_name = 'Taurean Prince' where player_name like'%Taurean Waller-Prince%';
update season_stats set player_name = 'Eldo Garrett' where player_name like'%Dick Garrett%';
update season_stats set player_name = 'Talvin Skinner' where player_name like'%Tal Skinner%';
update season_stats set player_name = 'James Owens' where player_name like'%Red Owens%';
update season_stats set player_name = 'Charlie Shipp' where player_name like'%Charley Shipp%';
update season_stats set player_name = 'Marko Todorovich' where player_name like'%Mike Todorovich%';
update season_stats set player_name = 'Costic Borsavage' where player_name like'%Ike Borsavage%';
update season_stats set player_name = 'Charles Acton' where player_name like'%Bud Acton%';
update season_stats set player_name = 'Johnny Warren' where player_name like'%John Warren%';
update season_stats set player_name = 'Jojo White' where player_name like'%Jo Jo%';
update season_stats set player_name = 'Double D Davis' where player_name like'%Dwight Davis%';
update season_stats set player_name = 'Charles Johnson' where player_name like'%Charles Johnson%';
update season_stats set player_name = 'Emanuel Leaks' where player_name like'%Manny Leaks%';
update season_stats set player_name = 'Larue Martin' where player_name like'%LaRue Martin%';
update season_stats set player_name = 'Isaac Stallworth' where player_name like'%Bud Stallworth%';
update season_stats set player_name = 'Carlos Ogden' where player_name like'%Bud Ogden%';
update season_stats set player_name = 'Roland Taylor' where player_name like'%Fatty Taylor%';
update season_stats set player_name = 'David Greenwood' where player_name like'%Dave Greenwood%';
update season_stats set player_name = 'Willie Jones' where player_name like'%Hutch Jones%';
update season_stats set player_name = 'Charlie Pittman' where player_name like'%Charles Pittman%';
update season_stats set player_name = 'Dan Schayes' where player_name like'%Danny Schayes%';
update season_stats set player_name = 'Mo Martin' where player_name like'%Maurice Martin%';
update season_stats set player_name = 'Stephen Bardo' where player_name like'%Steve Bardo%';
update season_stats set player_name = 'Log Vander Velden' where player_name like'%Logan Vander%';
update season_stats set player_name = 'Makhtar N\'diaye' where player_name like'%Makhtar N\'Diaye%';
update season_stats set player_name = 'Ike Fontaine' where player_name like'%Isaac Fontaine%';
update season_stats set player_name = 'Mamadou N\'diaye' where player_name like'%Mamadou N\'Diaye%';
update season_stats set player_name = 'Ha Seung-jin' where player_name like'%Ha Seung-Jin%';
update season_stats set player_name = 'JR Smith' where player_name like'%J.R. Smith%';
update season_stats set player_name = 'Hamady Ndiaye' where player_name like'%Hamady N\'Diaye%';
update season_stats set player_name = 'CJ McCollum' where player_name like'%C.J. McCollum%';
update season_stats set player_name = 'Edy Tavares' where player_name like'%Walter Tavares%';
update season_stats set player_name = 'Charlie Share' where player_name like'%Chuck Share%';
update season_stats set player_name = 'Hot Rod Williams' where player_name like'%Hot Rod%';
update season_stats set player_name = 'Alvin Attles' where player_name like'%Al Attles%';
update season_stats set player_name = 'Garfield Heard' where player_name like'%Gar Heard%';
update season_stats set player_name = 'Billyray Bates' where player_name like'%Billy Ray%';
update season_stats set player_name = 'Ed Lawrence' where player_name like'%Edmund Lawrence%';
update season_stats set player_name = 'Charlie Davis' where player_name like'%Charles Davis%';
update season_stats set player_name = 'Don Williams' where player_name like'%Duck Williams%';
update season_stats set player_name = 'Mel Turpin' where player_name like'%Melvin Turpin%';
update season_stats set player_name = 'Labradford Smith' where player_name like'%LaBradford Smith%';
update season_stats set player_name = 'Steven Smith' where player_name like'%Steve Smith%';
update season_stats set player_name = 'Clar. Weatherspoon' where player_name like'%Clarence Weatherspoon%';
update season_stats set player_name = 'Richard Manning' where player_name like'%Rich Manning%';
update season_stats set player_name = 'Slava Medvedenko' where player_name like'%Stanislav Medvedenko%';
update season_stats set player_name = 'Norman Richardson' where player_name like'%Norm Richardson%';
update season_stats set player_name = 'Efthimios Rentzias' where player_name like'%Efthimi Rentzias%';
update season_stats set player_name = 'Ibrahim Kutluay' where player_name like'%Ibo Kutluay%';
update season_stats set player_name = 'Boniface Ndong' where player_name like'%Boniface N\'Dong%';
update season_stats set player_name = 'JJ Redick' where player_name like'%J.J. Redick%';
update season_stats set player_name = 'Nando De Colo' where player_name like'%Nando De%';
update season_stats set player_name = 'James Ennis III' where player_name like'%James Ennis%';
update season_stats set player_name = 'JJ O\'Brien' where player_name like'%J.J. O\'Brien%';
update season_stats set player_name = 'Wade Baldwin IV' where player_name like'%Wade Baldwin%';
update season_stats set player_name = 'AJ Hammons' where player_name like'%A.J. Hammons%';
update season_stats set player_name = 'Danuel House Jr.' where player_name like'%Danuel House%';
update season_stats set player_name = 'Derrick Jones Jr.' where player_name like'%Derrick Jones%';
update season_stats set player_name = 'Wang Zhi-zhi' where player_name like'%Wang Zhizhi%';
update season_stats set player_name = 'Nene' where player_name like'%Nene Hilario%';
update season_stats set player_name = 'Marcus Morris Sr.' where player_name like'%Marcus Morris%';
update season_stats set player_name = 'PJ Hairston' where player_name like'%P.J. Hairston%';
update season_stats set player_name = 'Alexander Ellis' where player_name like'%Boo Ellis%';
update season_stats set player_name = 'Michael Anderson' where player_name like'%J.J. Anderson%';
update season_stats set player_name = 'Lynbert Johnson' where player_name like'%Cheese Johnson%';
update season_stats set player_name = 'Mckinley Singleton' where player_name like'%McKinley Singleton%';
update season_stats set player_name = 'Robert Lock' where player_name like'%Rob Lock%';
update season_stats set player_name = 'Freddie Scolari' where player_name like'%Fred Scolari%';
update season_stats set player_name = 'Charlie Johnson' where player_name like'%Charles Johnson%';

// Set value of ID_PERSON in SESON_STATS where match PLAYER.full_name = season_stats.player_name
// Using listagg to find players with same name
update season_stats sst set sst.id_person = pl.id from (select pl.full_name, listagg(pl.id, ',') id from player pl group by (pl.full_name)) pl
where pl.full_name = sst.player_name;

// Adjust ids of players with same name;
update season_stats set id_person = '77268' where idx in (548,686,833,962,1074,1288);
update season_stats set id_person = '78380' where idx in (1013);
update season_stats set id_person = '78382' where idx in (1799);
update season_stats set id_person = '77818' where idx in (1201,1312);
update season_stats set id_person = '77819' where idx in (5988,6347,6713,7090,7439,7789,8170,8545,8955,8956,8957,9385,9847);
update season_stats set id_person = '77202' where idx in (1634,1743,1872,2012,2150);
update season_stats set id_person = '77203' where idx in (7005,7360);
update season_stats set id_person = '78209' where idx in (1796);
update season_stats set id_person = '78207' where idx in (3526,3795);
update season_stats set id_person = '76610' where idx in (1836,1972,1973,1974,1975,2111);
update season_stats set id_person = '77193' where idx in (4814,5186,5547,5894,6253,6623,6997,7356,7704,8087);
update season_stats set id_person = '200784' where idx in (18478,19037,19038,19039,19040,19041,19042);
update season_stats set id_person = '1585' where idx in (13936,14446,16468);
update season_stats set id_person = '76990' where idx in (8432,8433,8434);
update season_stats set id_person = '1538' where idx in (13616,14154,14666,15171,15706);
update season_stats set id_person = '279' where idx in (7358,7706,7707,7708,7709,8089,8090,8468,8867,8868,9292,9291,9746,10211,10665,11105,11584,12045,12525,13093,13650);
update season_stats set id_person = '77178' where idx in (14191,14706);
update season_stats set id_person = '293' where idx in (9448,9912,10361,10828,11270,11757,12210,12736,12737,12735,13314);
update season_stats set id_person = '1520' where idx in (9911,10360,12734);
update season_stats set id_person = '78179' where idx in (13841,13842,13843,14383,15927,16403,18113,18114,18115);
update season_stats set id_person = '76519' where idx in (3362,3632,3633,3634,3898);
update season_stats set id_person = '1520' where idx in (6523,6897,7276,7624,7626,7625,7997,8757,8758,8759,9191,9631);
update season_stats set id_person = '202419' where idx in (20827,20828,20829,21412,21413,21414,21946);
update season_stats set id_person = '203187' where idx in (21946,21947,22560,23167,23168,23169,23170,23793);
update season_stats set id_person = '203147' where idx in (22758);
update season_stats set id_person = '1814' where idx in (11271,11758,12211);
update season_stats set id_person = '202874' where idx in (21669,22857);
update season_stats set id_person = '203203' where idx in (22244);
update season_stats set id_person = '244' where idx in (10053,10506,10965,11415,11890,12346,12895,13475,13474,13473,14016,14532,15022,15570);
update season_stats set id_person = '200793' where idx in (18290,19420,19421,19422);
update season_stats set id_person = '77144' where idx in (5177,5540,5885,6240,6605,6978,7344,7694,8075,8076,8077,8456);
update season_stats set id_person = '698' where idx in (6606,6979,7345,7695,8074,8457,8857,9280,9732,10204,10205,10206,10661,11101,11579,12520,13087,13088,13089,13646,14188);
update season_stats set id_person = '77147' where idx in (3185,3694,3953);
update season_stats set id_person = '77149' where idx in (3695,3954,4222,4494,4808,4809,4810,5178,5541,5886,6241,6608,6981,7697,8079);
update season_stats set id_person = '77148' where idx in (5542,5887,6242,6609,6982,7347,7698,8080);
update season_stats set id_person = '76993' where idx in (5867,6217,6582,6961,7329,7678,8052,8435,8436,8437,8823,8824,8825,9260,9708,9710,9709,10181,10631,10632,10633);
update season_stats set id_person = '201945' where idx in (20151,20780,21352,21903,22521,23125,23737,24322);
update season_stats set id_person = '779' where idx in (9874,10329,10788,11235,11723,12172,12687,13263,13790,14345,14853,15384,15890,16370,16931);
update season_stats set id_person = '203318' where idx in (22718,23353);
update season_stats set id_person = '78190' where idx in (2829,3029,3264,3522,3523,3524,3793,3792,3791,4048,4313,4600);
update season_stats set id_person = '202962' where idx in (21570,22148,22759,23403,23996);
update season_stats set id_person = '76526' where idx in (4723,5092,5463,5812,6154,6524,6898,7277,7627,7998,7999,8000);
update season_stats set id_person = '77154' where idx in (8081);
update season_stats set id_person = '2256' where idx in (16234);
update season_stats set id_person = '77156' where idx in (5182);
update season_stats set id_person = '913' where idx in (10663,11104,11583,12043,12523,13092,13649,14190,14705,15206);
update season_stats set id_person = '1626122' where idx in (14283);
update season_stats set id_person = '200766' where idx in (18729,19314,19903,20486);
update season_stats set id_person = '201173' where idx in (19315,19316,19317,19904);
update season_stats set id_person = '76528' where idx in (9192,9193,9194);
update season_stats set id_person = '707' where idx in (12398,12961,13535,14077,14594);
update season_stats set id_person = '2891' where idx in (17366);
update season_stats set id_person = '90000' where idx in (7362);
update season_stats set id_person = '76908' where idx in (2394,2545,2729,2928,3157,3158,3159,3395,3672,3930,3931,3932,3933,4199,4468,4469,4470);
update season_stats set id_person = '78197' where idx in (9918,10366,12214);
update season_stats set id_person = '63' where idx in (12215,12741,13320,13847,13848,13849,14385,14880,15418);
update season_stats set id_person = '76616' where idx in (4738,5108,5110,5109,5471,5822,6172,6538,6910,7286,7635,9206,9649);
update season_stats set id_person = '2399' where idx in (16130,16648,17235,17807,18352,18353,18354,18890,19505,20070,20682,21263,21826,22437,23039,23653,24235,24236,24237);
update season_stats set id_person = '2229' where idx in (15732,16224,16747,16748,16749,17345,17346,17347,17919,18461,19018,19020,19019,19612,19613,19614,20208,21396,21934,22549);
update season_stats set id_person = '121' where idx in (8020,8404,8785,9216,9662,10132,10584,11033,11499,11971,12434,12995,13568,14106,14618,15116,15649);
update season_stats set id_person = '201607' where idx in (20699);
update season_stats set id_person = '199' where idx in (9088,9535,9991,9992,9993,9994,10424,10425,10426,10893,11340,11825,12277,12813,13396,13397,13398);
update season_stats set id_person = '202130' where idx in (20489,21108,21658,22240,22851,23495,24671);
update season_stats set id_person = '120' where idx in (10834,11277,11765,12216,12217,12218,12742,13321,13850,14386,14881,15420,15933,16405,16961,17548,17549,17550);
update season_stats set id_person = '200848' where idx in (18658);
update season_stats set id_person = '203183' where idx in (22645);
update season_stats set id_person = '203502' where idx in (22646);
update season_stats set id_person = '78048' where idx in (7119,7472,7820,8198,8576,8985);
update season_stats set id_person = '201041' where idx in (21547);


// Adjust the teams with diff abbreviations and insert old ones;

select * from team;
update team set abbreviation = 'CHO' where id = 1610612766;
update season_stats set team = 'CHO' where team = 'CHH';
update season_stats set team = 'PHX' where team = 'PHO';
update season_stats set team = 'BKN' where team = 'BRK';
update season_stats set team = 'DEN' where team = 'DNN';

insert into team Values
(1610612767, 'Charlotte Bobcats', 'CHA', 'Bobcats', 'Charlotte', 'North Carolina', 2004);
insert into team Values
(1610612768, 'New Orleans Hornets', 'NOH', 'Hornets', 'New Orleans', 'Louisiana', 2002);
insert into team Values
(1610612769, 'New Jersey Nets', 'NJN', 'Nets', 'New Jersey', 'New Jersey', 1977);
insert into team Values
(1610612770, 'New Jersey Nets', 'NJN', 'Nets', 'New Jersey', 'New Jersey', 1977);
insert into team Values
(1610612771, 'Seattle SuperSonics', 'SEA', 'SuperSonics', 'Seattle', 'Seattle', 1967);
insert into team Values
(1610612772, 'New Orleans/Oklahoma City Hornets', 'NOK', 'Hornets', 'New Orleans/Oklahoma City', 'Louisiana', 2005);
insert into team Values
(1610612773, 'Vancouver Grizzlies', 'VAN', 'Grizzlies', 'Vancouver', 'British Columbia', 1995);
insert into team Values
(1610612774, 'Washington Bullets', 'WSB', 'Bullets', 'Washington', 'Washington', 1974);
insert into team Values
(1610612775, 'Kansas City Kings', 'KCK', 'Kings', 'Kansas City', 'Missouri', 1975);
insert into team Values
(1610612776, 'San Diego Clippers', 'SDC', 'Clippers', 'San Diego', 'Califórnia', 1978);
insert into team Values
(1610612777, 'New Orleans Jazz', 'NOJ', 'Jazz', 'New Orleans', 'Louisiana', 1974);
insert into team Values
(1610612778, 'Buffalo Braves', 'BUF', 'Braves', 'Buffalo', 'New York', 1974);
insert into team Values
(1610612779, 'New York Nets', 'NYN', 'Nets', 'New York', 'New York', 1968);
insert into team Values
(1610612780, 'Kansas City-Omaha Kings', 'KCO', 'Kings', 'Kansas City-Omaha', 'Missouri', 1974);
insert into team Values
(1610612781, 'Capital Bullets', 'CAP', 'Bullets', 'Washington', 'Washington', 1973);
insert into team Values
(1610612782, 'Baltimore Bullets', 'BAL', 'Bullets', 'Baltimore', 'Maryland', 1944);
insert into team Values
(1610612783, 'Cincinnati Royals', 'CIN', 'Royals', 'Cincinnati', 'Ohio', 1957);
insert into team Values
(1610612784, 'San Francisco Warriors', 'SFW', 'Warriors', 'San Francisco', 'Califórnia', 1962);
insert into team Values
(1610612785, 'San Diego Rockets', 'SDR', 'Rockets', 'San Diego', 'Califórnia', 1967);
insert into team Values
(1610612786, 'St. Louis Hawks', 'STL', 'Hawks', 'St. Louis', 'Missouri', 1955);
insert into team Values
(1610612787, 'Syracuse Nationals', 'SYR', 'Nationals', 'Syracuse', 'New York', 1939);
insert into team Values
(1610612788, 'Chicago Zephyrs', 'CHZ', 'Zephyrs', 'Chicago', 'Illinois', 1962);
insert into team Values
(1610612789, 'Philadelphia Warriors', 'PHW', 'Warriors', 'Philadelphia', 'Pennsylvania', 1946);
insert into team Values
(1610612790, 'Chicago Packers', 'CHP', 'Packers', 'Chicago', 'Illinois', 1961);
insert into team Values
(1610612791, 'Minneapolis Lakers', 'MNL', 'Lakers', 'Minneapolis', 'Minnesota', 1947);
insert into team Values
(1610612792, 'Fort Wayne Pistons', 'FTW', 'Pistons', 'Fort Wayne', 'Indiana', 1941);
insert into team Values
(1610612793, 'Rochester Royals', 'ROC', 'Royals', 'Rochester', 'New York', 1950);
insert into team Values
(1610612794, 'Milwaukee Hawks', 'MLH', 'Hawks', 'Milwaukee', 'Wisconsin', 1951);
insert into team Values
(1610612795, 'Baltimore Bullets', 'BLB', 'Bullets', 'Baltimore', 'Maryland', 1963);
insert into team Values
(1610612796, 'Indianapolis Olympians', 'INO', 'Olympians', 'Indianapolis', 'Indiana', 1949);
insert into team Values
(1610612797, 'Indianapolis Olympians', 'INO', 'Olympians', 'Indianapolis', 'Indiana', 1949);
insert into team Values
(1610612798, 'Tri-Cities Blackhawks', 'TRI', 'Blackhawks', 'Tri-Cities', 'Washington', 1949);
insert into team Values
(1610612799, 'Washington Capitols', 'WSC', 'Capitols', 'Washington', 'Washington', 1946);
insert into team Values
(1610612800, 'Waterloo Hawks', 'WAT', 'Hawks', 'Waterloo', 'Ontario', 1948);
insert into team Values
(1610612801, 'Anderson Packers', 'AND', 'Packers', 'Anderson', 'South Carolina', 1946);
insert into team Values
(1610612802, 'St. Louis Bombers', 'STB', 'Bombers', 'St. Louis', 'Missouri', 1946);
insert into team Values
(1610612803, 'Chicago Stags', 'CHS', 'Stags', 'Chicago', 'Illinois', 1946);
insert into team Values
(1610612804, 'Sheboygan Red Skins', 'SHE', 'Red Skins', 'Sheboygan', 'Wisconsin', 1938);

//match id team with game table
update team tm set tm.id = gm.team_id_home from (select distinct gm.team_name_home, gm.team_id_home from game gm where gm.season_type not in ('Pre Season')) gm
where tm.full_name = gm.team_name_home;

update team set id = 1610612765 where id = 1610612792;

