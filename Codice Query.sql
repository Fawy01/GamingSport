drop table if exists Spettatore CASCADE;
drop table if exists Team CASCADE;
drop table if exists Giocatore CASCADE;
drop table if exists GameCompany CASCADE;
drop table if exists Indirizzo CASCADE;
drop table if exists Gioco CASCADE;
drop table if exists Arena CASCADE;
drop table if exists Stand CASCADE;
drop table if exists Premio CASCADE;
drop table if exists Partita CASCADE;
drop table if exists Biglietto CASCADE;
drop table if exists Partecipare CASCADE;

CREATE TABLE Indirizzo (Città VARCHAR(30) NOT NULL,
				Via VARCHAR(30) NOT NULL,
				Numero_Civico INT NOT NULL,
				Nazione VARCHAR(30) NOT NULL,
				PRIMARY KEY (Città,Via,Numero_Civico)
);

CREATE TABLE Spettatore (Email VARCHAR(30), 
				Nome VARCHAR(30) NOT NULL,
				Cognome VARCHAR(30) NOT NULL,
				Età INT NOT NULL CHECK(Età > 5 AND Età < 100),
				Sesso VARCHAR(1) NOT NULL CHECK (Sesso = 'M' OR Sesso = 'F'),
				Città VARCHAR,
				Via VARCHAR,
				NCivico INT,
				PRIMARY KEY (Email),
				FOREIGN KEY (Città,Via,NCivico) REFERENCES Indirizzo(Città,Via,Numero_Civico) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE Team ( Nome_Team VARCHAR (30) PRIMARY KEY,
		  Icona_Team VARCHAR(30),
                  Sponsor VARCHAR (30)
);

CREATE TABLE Giocatore ( Email VARCHAR(30), 
				Nome VARCHAR(30) NOT NULL,
				Cognome VARCHAR(30) NOT NULL,
				NickName VARCHAR (16) NOT NULL UNIQUE,
				Età INT NOT NULL CHECK(Età >= 12 AND Età <= 100),
				Sesso VARCHAR(1) NOT NULL CHECK (Sesso = 'M' OR Sesso = 'F'),
				Ruolo VARCHAR,
				Gruppo VARCHAR,
				Città VARCHAR,
				Via VARCHAR,
				NCivico INT,
				PRIMARY KEY (Email),
				FOREIGN KEY (Città,Via,NCivico) REFERENCES Indirizzo(Città,Via,Numero_Civico) ON UPDATE CASCADE ON DELETE CASCADE,
				FOREIGN KEY (Gruppo) REFERENCES Team(Nome_Team) ON UPDATE CASCADE ON DELETE CASCADE,
				CHECK (Ruolo = 'Berserker' OR Ruolo = 'Supporter' OR Ruolo = 'Capo Squadra')
						
);


CREATE TABLE GameCompany ( Id_Gc INT PRIMARY KEY,
				Nome_Gc VARCHAR(30),
				CEO VARCHAR(30),
				Città VARCHAR,
				Via VARCHAR,
				NCivico INT,
				FOREIGN KEY (Città,Via,NCivico) REFERENCES Indirizzo(Città,Via,Numero_Civico) ON UPDATE CASCADE ON DELETE CASCADE

);


CREATE TABLE Gioco ( Nome_Gioco VARCHAR(30) PRIMARY KEY,
			Sviluppatore VARCHAR(30) NOT NULL,
			Anno Date NOT NULL,
			Rating INT NOT NULL CHECK (Rating > 0 AND Rating <=5),
			Genere VARCHAR(16),
			Casa_Produttrice INT,
			FOREIGN KEY (Casa_Produttrice) REFERENCES GameCompany(Id_Gc) ON UPDATE CASCADE ON DELETE CASCADE,
			CHECK ( Genere = 'FPS' OR Genere = 'Arcade' OR Genere = 'Sport')
);


CREATE TABLE Arena (Codice_Arena INT PRIMARY KEY,
			Nome_Arena VARCHAR(16) NOT NULL,
			Altezza INT,
			Area INT
					
);


CREATE TABLE Stand( Codice_Stand INT PRIMARY KEY NOT NULL,
			Posizione VARCHAR(1) CHECK (Posizione = 'N' OR Posizione = 'S' OR Posizione = 'E' OR Posizione = 'O'),
			Nome_Stand VARCHAR(30) NOT NULL,
			Tipo VARCHAR(16),
			Palazzetto INT,
			FOREIGN KEY(Palazzetto) REFERENCES Arena(Codice_Arena) ON UPDATE CASCADE ON DELETE CASCADE,
			CHECK (Tipo = 'Giocattolo'OR Tipo = 'Gadget' OR Tipo = 'Cucina')		
);


CREATE TABLE Partita ( Id_Partita INT PRIMARY KEY,
			Num_Spettatori INT NOT NULL,
			Game VARCHAR,
			Palazzetto INT,
			FOREIGN KEY(Game) REFERENCES Gioco(Nome_Gioco) ON UPDATE CASCADE ON DELETE CASCADE,
			FOREIGN KEY(Palazzetto) REFERENCES Arena(Codice_Arena) ON UPDATE CASCADE ON DELETE CASCADE,
			CHECK ( Num_Spettatori >=0)

);

CREATE TABLE Biglietto (Id INT PRIMARY KEY,
			Prezzo INT NOT NULL,
			Sconto BOOL NOT NULL,
			Possessore VARCHAR,
			Sessione INT,
			FOREIGN KEY(Possessore) REFERENCES Spettatore(Email) ON UPDATE CASCADE ON DELETE CASCADE,
			FOREIGN KEY(Sessione) REFERENCES Partita(Id_Partita) ON UPDATE CASCADE ON DELETE CASCADE,
			CHECK ((Prezzo = 20 AND Sconto = FALSE) OR (Prezzo = 10 AND Sconto = TRUE))
);

CREATE TABLE Partecipare ( Gruppo VARCHAR,
			Sessione INT,
			FOREIGN KEY(Gruppo) REFERENCES Team(Nome_Team) ON UPDATE CASCADE ON DELETE CASCADE,
			FOREIGN KEY(Sessione) REFERENCES Partita(Id_Partita) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Premio( Id_Premio INT PRIMARY KEY,
			Valore INT NOT NULL,
			Data_Vincita DATE,
			Vittoria BOOL NOT NULL,
			Descrizione VARCHAR(50),
			Gruppo VARCHAR,
			Sessione INT,
			FOREIGN KEY(Gruppo) REFERENCES Team(Nome_Team) ON UPDATE CASCADE ON DELETE CASCADE,
			FOREIGN KEY(Sessione) REFERENCES Partita(Id_Partita) ON UPDATE CASCADE ON DELETE CASCADE,
			CHECK (( Vittoria  = true AND Data_Vincita IS NOT NULL AND Gruppo IS NOT NULL) OR (Vittoria = false AND Data_Vincita IS NULL AND GRUPPO IS NULL))
		
);



insert into Indirizzo (Città, Via, Numero_Civico, Nazione) values ('Namysłów', 'Park Meadow', '67396', 'Poland'),
('Wolbrom', 'Texas', '1', 'Poland'),
('São Domingos de Rana', 'Marquette', '68', 'Portugal'),
('Ordem', 'Washington', '650', 'Portugal'),
('Hamburg', 'Charing Cross', '45', 'Germany'),
('Łobez', 'Lindbergh', '47', 'Poland'),
('Januszkowice', 'Graedel', '51', 'Poland'),
('Nowy Korczyn', 'Claremont', '7140', 'Poland'),
('Annecy', 'Ridgeway', '71075', 'France'),
('Marseille', 'Eliot', '54270', 'France'),
('Mikstat', 'Atwood', '70', 'Poland'),
('Paris 15', 'Hayes', '6', 'France'),
('Vitry-sur-Seine', 'Dakota', '2', 'France'),
('Nanterre', 'Elgar', '632', 'France'),
('Mikstat', 'Merry', '03', 'Poland'),
('Yasenskaya', 'Colorado', '864', 'Russia'),
('Tapon', 'Delaware', '8', 'Philippines'),
('Rio Verde de Mato Grosso', 'Mayer', '650', 'Brazil'),
('Longsha', 'Eggendart', '0', 'China'),
('Senador Canedo', 'Gerald', '56', 'Brazil'),
('Shashemenē', 'Nelson', '9', 'Ethiopia'),
('Unaí', 'Mockingbird', '194', 'Brazil'),
('Luoshe', 'Little Fleur', '990', 'China'),
('Fontenay-sous-Bois', 'Toban', '75085', 'France'),
('Nunutba', 'Ridgeview', '77', 'Indonesia'),
('Nizhniy Tagil', 'Talmadge', '511', 'Russia'),
('Bunobogu', 'Dovetail', '2', 'Indonesia'),
('Nedakonice', 'Parkside', '36952', 'Czech Republic'),
('Huibu', 'Tennessee', '72635', 'China'),
('Ráquira', 'Village', '7494', 'Colombia'),
('Yelat’ma', 'Arizona', '43226', 'Russia'),
('Bela Vista do Paraíso', 'Dottie', '5', 'Brazil'),
('Kalpáki', 'Autumn Leaf', '2420', 'Greece'),
('Padangtepung', 'Bobwhite', '892', 'Indonesia'),
('Tosu', 'Basil', '2', 'Japan'),
('Bremerhaven', 'Rieder', '1', 'Germany'),
('Stuttgart', 'Monica', '57493', 'Germany'),
('Dunkerque', 'Northridge', '9664', 'France'),
('Fonteleite', 'Prentice', '377', 'Portugal'),
('Boco', 'Ridge Oak', '20', 'Portugal'),
('Gävle', 'High Crossing', '6', 'Sweden'),
('Falun', 'Briar Crest', '1', 'Sweden'),
('Tarnowiec', 'Mandrake', '8', 'Poland'),
('Pescara', 'Mayfield', '49', 'Italy'),
('Fiais da Beira', 'Prentice', '3', 'Portugal'),
('Beja', 'Kipling', '56061', 'Portugal'),
('Meruge', 'Namekagon', '4', 'Portugal'),
('Bolesławiec', 'Loftsgordon', '93906', 'Poland'),
('Västerås', 'Delaware', '44', 'Sweden'),
('Tabuaço', 'Shasta', '7', 'Portugal'),
('Xinshi', 'Hoard', '96102', 'China'),
('Adar', 'Algoma', '4', 'Morocco'),
('Ash Shajarah', 'Melrose', '64224', 'Syria'),
('Wierzchosławice', 'Prairie Rose', '684', 'Poland'),
('Frederico Westphalen', 'Cottonwood', '71596', 'Brazil'),
('Pingdong', 'Schmedeman', '85', 'China'),
('Shahrak', 'Crest Line', '0', 'Afghanistan'),
('Goroka', 'Ruskin', '0204', 'Papua New Guinea'),
('Mondoteko', 'Delaware', '272', 'Indonesia'),
('Joaquín Suárez', 'Elgar', '52', 'Uruguay');

insert into Spettatore (Email, Nome, Cognome, Età, Sesso, Città, Via, NCivico) values ('cowderay0@gizmodo.com', 'Quintus', 'Cowderay', 12, 'M', 'Bremerhaven', 'Rieder', '1'),
('hlivermore1@myspace.com', 'Haslett', 'Livermore', 18, 'F', 'Wolbrom', 'Texas', '1'),
('dmcelwee2@miitbeian.gov.cn', 'Deane', 'McElwee', 31, 'F','São Domingos de Rana', 'Marquette', '68'),
('rbirtwhistle3@delicious.com', 'Ranice', 'Birtwhistle', 16, 'F', 'Ordem', 'Washington', '650'),
('clightbourne4@surveymonkey.com', 'Coralyn', 'Lightbourne', 52, 'F','Hamburg', 'Charing Cross', '45'),
('wgoodliff5@miitbeian.gov.cn', 'Wilbert', 'Goodliff', 46, 'M', 'Łobez', 'Lindbergh', '47'),
('tgreenall6@tiny.cc', 'Terence', 'Greenall', 71, 'M', 'Januszkowice', 'Graedel', '51'),
('gstronach7@trellian.com', 'Gonzales', 'Stronach', 90, 'M', 'Nowy Korczyn', 'Claremont', '7140'),
('ypowelee8@hc360.com', 'Yasmeen', 'Powelee', 37, 'F', 'Annecy', 'Ridgeway', '71075'),
('djerger9@mashable.com', 'Di', 'Jerger', 25, 'F', 'Marseille', 'Eliot', '54270'),
('lnaullsa@loc.gov', 'Lynelle', 'Naulls', 27, 'M', 'Mikstat', 'Atwood', '70'),
('csomerscalesb@imgur.com', 'Catlee', 'Somerscales', 62, 'F','Paris 15', 'Hayes', '6'),
('caimsonc@toplist.cz', 'Cameron', 'Aimson', 40, 'M', 'Vitry-sur-Seine', 'Dakota', '2'),
('emccorkindaled@tumblr.com', 'Em', 'McCorkindale', 7, 'F', 'Nanterre', 'Elgar', '632'),
('gtraslere@posterous.com', 'Garey', 'Trasler', 20, 'M','Mikstat', 'Merry', '03'),
  ('ctarver0@istockphoto.com', 'Laurène', 'Tarver', 12, 'M', 'Bremerhaven', 'Rieder', '1'),
  ('cdudman1@google.it', 'Angélique', 'Dudman', 62, 'M', 'Stuttgart', 'Monica', '57493'),
  ('pshardlow2@netlog.com', 'Méghane', 'Shardlow', 14, 'M', 'Dunkerque', 'Northridge', '9664'),
  ('dsmy3@economist.com', 'Miléna', 'Smy', 59, 'F', 'Fonteleite', 'Prentice', '377'),
  ('awrassell4@ibm.com', 'Gérald', 'Wrassell', 61, 'M', 'Boco', 'Ridge Oak', '20'),
  ('hplaskitt5@webmd.com', 'Simplifiés', 'Plaskitt', 37, 'M', 'Gävle', 'High Crossing', '6'),
  ('salvarado6@opera.com', 'Maïlis', 'Alvarado', 66, 'M', 'Falun', 'Briar Crest', '1'),
  ('thylden7@mapy.cz', 'Marlène', 'Hylden', 86, 'F', 'Tarnowiec', 'Mandrake', '8'),
  ('chymus8@addtoany.com', 'Léa', 'Hymus', 51, 'M', 'Pescara', 'Mayfield', '49'),
  ('jnewns9@123-reg.co.uk', 'Loïc', 'Newns', 9, 'F', 'Fiais da Beira', 'Prentice', '3'),
  ('talawaya@techcrunch.com', 'Dù', 'Alaway', 32, 'M', 'Beja', 'Kipling', '56061'),
  ('jjewerb@histats.com', 'Gösta', 'Jewer', 11, 'F', 'Meruge', 'Namekagon', '4'),
  ('gmullengerc@sakura.ne.jp', 'Marie-hélène', 'Mullenger', 47, 'M', 'Bolesławiec', 'Loftsgordon', '93906'),
  ('thamprechtd@yellowbook.com', 'Hélène', 'Hamprecht', 34, 'M', 'Västerås', 'Delaware', '44'),
  ('kcysone@dell.com', 'Réjane', 'Cyson', 34, 'F', 'Tabuaço', 'Shasta', '7'),
  ('cdelff@discuz.net', 'Annotés', 'Delf', 25, 'M', 'Xinshi', 'Hoard', '96102'),
  ('qcowderay0@gizmodo.com', 'Méryl', 'Petran', 10, 'M', 'Adar', 'Algoma', '4'),
  ('trostronh@marriott.com', 'Almérinda', 'Rostron', 29, 'F', 'Ash Shajarah', 'Melrose', '64224'),
  ('wcarabinei@newyorker.com', 'Audréanne', 'Carabine', 46, 'F', 'Wierzchosławice', 'Prairie Rose', '684'),
  ('rliveingj@wp.com', 'Loïca', 'Liveing', 42, 'F', 'Frederico Westphalen', 'Cottonwood', '71596'),
  ('cmonteauxk@naver.com', 'Angèle', 'Monteaux', 27, 'M', 'Pingdong', 'Schmedeman', '85'),
  ('asheal@bravesites.com', 'Nadège', 'Shea', 26, 'M', 'Shahrak', 'Crest Line', '0'),
  ('yplumridegem@go.com', 'Adèle', 'Plumridege', 61, 'M', 'Goroka', 'Ruskin', '0204'),
  ('hgaughann@live.com', 'Françoise', 'Gaughan', 69, 'M', 'Mondoteko', 'Delaware', '272'),
  ('tdownhamo@slashdot.org', 'Léonie', 'Downham', 50, 'M', 'Joaquín Suárez', 'Elgar', '52');

insert into Team (Nome_Team, Icona_Team, Sponsor) values ('Virtus', 'Orso', 'McClure LLC'),
('FNatic', 'Mazza Da Baseball', NULL),
('BMF', 'Croce', 'Koepp-Balistreri'),
('G2', 'Elmo', 'Spinka-Kilback'),
('NiP', 'Pistola', 'McClure Group');

insert into Giocatore (Email, Nome, Cognome, NickName, Età, Sesso, Ruolo, Gruppo,Città, Via, NCivico) values ('jholstein0@hostgator.com', 'Juieta', 'Holstein', 'Gigia01', 16, 'F', 'Capo Squadra', 'Virtus','Stuttgart', 'Monica', '57493'),
('rdilworth1@google.ru', 'Ros', 'Dilworth', 'DilanDog', 19, 'F', 'Supporter', 'Virtus', 'Dunkerque', 'Northridge', '9664'),
('zgibson2@springer.com', 'Zonda', 'Gibson', 'Gizo', 28, 'F', 'Supporter','Virtus', 'Fonteleite', 'Prentice', '377'),
('tnewcome3@java.com', 'Tore', 'Newcome', 'NewTown', 24, 'M', 'Berserker', 'FNatic','Boco', 'Ridge Oak', '20'),
('pmcenteggart4@ameblo.jp', 'Pattin', 'McEnteggart', 'PattyB', 31, 'M', 'Capo Squadra','FNatic', 'Gävle', 'High Crossing', '6'),
('mwrotchford5@free.fr', 'Merrilee', 'Wrotchford', 'Rossa01', 31, 'F', 'Berserker', 'FNatic','Falun', 'Briar Crest', '1'),
('tkapelhof6@lycos.com', 'Timmie', 'Kapelhof', 'Timmy', 42, 'M', 'Supporter', 'BMF','Tarnowiec', 'Mandrake', '8'),
('jhofner7@gravatar.com', 'Justina', 'Hofner', 'Giustizia', 23, 'F', 'Capo Squadra','BMF', 'Pescara', 'Mayfield', '49'),
('ndulany8@huffingtonpost.com', 'Nicolette', 'Dulany', 'Nick', 34, 'F', 'Capo Squadra', 'BMF','Fiais da Beira', 'Prentice', '3'),
('lsallter9@msn.com', 'Lisette', 'Sallter', 'Lisa', 55, 'F', 'Supporter', 'G2','Beja', 'Kipling', '56061'),
('rdunbabina@yahoo.com', 'Read', 'Dunbabin', 'Lenia11', 21, 'M', 'Berserker', 'G2','Meruge', 'Namekagon', '4'),
('cdavidowichb@phoca.cz', 'Crawford', 'Davidowich', 'Diabolik', 33, 'M', 'Supporter', 'G2','Bolesławiec', 'Loftsgordon', '93906'),
('dflemyngc@npr.org', 'Donny', 'Flemyng', 'Doremi', 24, 'F', 'Berserker', 'NiP','Västerås', 'Delaware', '44'),
('tsimmondsd@wordpress.com', 'Tan', 'Simmonds', 'Timoty', 15, 'M', 'Capo Squadra', 'NiP','Tabuaço', 'Shasta', '7'),
('sstetsone@time.com', 'Sophia', 'Stetson', 'Soson', 17, 'F', 'Berserker', 'NiP','Namysłów', 'Park Meadow', '67396');


insert into GameCompany (Id_Gc, Nome_Gc, CEO, Città, Via, NCivico) values (1, 'Schowalter, D''Amore and Ferry', 'Dougy', 'Tosu', 'Basil', '2'),
(2, 'Cummings Group', 'Maribeth', 'Padangtepung', 'Bobwhite', '892'),
(3, 'Swift, King and Kreiger', 'Marwin', 'Kalpáki', 'Autumn Leaf', '2420'),
(4, 'Boyer, Flatley and Vandervort', 'Aurore', 'Bela Vista do Paraíso', 'Dottie', '5'),
(5, 'Marks, Herman and Stamm', 'Tamiko', 'Yelat’ma', 'Arizona', '43226'),
(6, 'Bernier-Cassin', 'Georgeanna', 'Ráquira', 'Village', '7494'),
 (7, 'Kuhlman Inc', 'Alli', 'Huibu', 'Tennessee', '72635'),
(8, 'Kreiger Group', 'Ferdie', 'Nedakonice', 'Parkside', '36952'),
(9, 'Hodkiewicz, Connelly and Boyer', 'Rosamond', 'Bunobogu', 'Dovetail', '2'),
(10, 'Lebsack-Dooley', 'Brook', 'Nizhniy Tagil', 'Talmadge', '511'),
(11, 'Auer Group', 'Paige', 'Nunutba', 'Ridgeview', '77'),
(12, 'Maggio-Barton', 'Wash', 'Fontenay-sous-Bois', 'Toban', '75085'),
(13, 'Hansen-Gleason', 'Saunder', 'Luoshe', 'Little Fleur', '990'),
(14, 'Gusikowski, Bogan and Wolff', 'Darcie', 'Unaí', 'Mockingbird', '194'),
(15, 'Fahey Group', 'Renate', 'Shashemenē', 'Nelson', '9'),
(16, 'Gislason-Goodwin', 'Bay', 'Senador Canedo', 'Gerald', '56'),
(17, 'Shields-Dare', 'Melisent', 'Longsha', 'Eggendart', '0'),
 (18, 'Bednar, Dicki and Gutkowski', 'Norman', 'Rio Verde de Mato Grosso', 'Mayer', '650'),
(19, 'Hettinger-Hegmann', 'Marabel', 'Tapon', 'Delaware', '8'),
(20, 'Muller-Dare', 'Cord', 'Yasenskaya', 'Colorado', '864');


insert into Gioco (Nome_Gioco, Sviluppatore, Anno, Genere, Rating, Casa_Produttrice) values ('Twolife', 'Engracia', '2003-08-14', 'Arcade', 3, 20),
('Fusiondoom', 'Georgianne', '1999-12-09', 'FPS', 2, 13),
('Dreamland', 'Lezlie', '2022-02-05', 'Sport', 1, 2),
('Ultralife', 'Chaim', '2016-06-07','FPS', 2, 16),
('Demonsite', 'Eolande', '1996-05-18','Arcade', 2, 20),
('Ultrawatch', 'Leroi', '2016-11-08', 'Arcade', 4, 1),
('Bladegene', 'Eloise', '2016-11-08', 'Sport', 1, 5),
('Sonic', 'Lanette', '1998-07-04', 'FPS', 5, 6),
('Castleline', 'Donnie', '2015-09-20', 'Sport', 3, 9),
('Blocklight', 'Cordula','1993-10-18', 'FPS', 2, 19),
('Deltashot', 'Reggi', '1993-10-18', 'FPS', 3, 13),
('SuperHot', 'Amie', '2002-01-20', 'FPS', 4, 10),
('NoGame', 'Kessia', '2011-09-10', 'Arcade', 5, 2),
('Astroplan', 'Odella', '2018-11-12', 'Sport', 5, 14),
('Clusterrush', 'Verna', '2009-05-23', 'Sport', 5, 12),
('Fusionnite', 'Gordan','2005-11-29', 'Arcade', 2, 5),
('Astroworks', 'Susy','2001-03-12', 'Sport', 5, 8),
('Archeshock', 'Arthur', '2001-03-12', 'FPS', 4, 10),
('Blockdark', 'Muffin', '2001-03-12', 'FPS', 5, 7),
('Endorreign', 'Rosalind', '2001-03-12', 'Arcade', 1, 3),
('NoTime', 'Elvira', '2010-03-15', 'Arcade', 2, 4),
('Bluemania', 'Yevette', '1993-10-18', 'FPS', 1, 15),
('Alterwhite', 'Thia', '2012-06-27', 'Arcade', 3, 18),
('Hellstar', 'Lucilia', '2015-09-09', 'FPS', 1, 17),
('Hundredlight', 'Henrik', '1999-01-23', 'FPS', 3, 11);


insert into Arena (Codice_Arena, Nome_Arena, Altezza, Area) values (1, 'Gembucket', 10, 75),
(2, 'Zontrax', 8, 85),
(3, 'Hatity', 6, 100),
(4, 'Aerified', 5, 75),
(5, 'Treeflex', 8, 85),
(6, 'Stronghold', 5, 70),
(7, 'Wrapsafe', 4, 45),
(8, 'Flexidy', 4, 45),
(9, 'Flexidy', 6, 100),
(10, 'Voltsillam', 5, 60);


insert into Stand (Codice_Stand, Posizione, Nome_Stand, Tipo, Palazzetto) values (1, 'E', 'RISPEND', 'Giocattolo', 3),
(2, 'O', 'Lido', 'Gadget', 7),
(3, 'N', 'Walgreens', 'Gadget', 4),
(4, 'O', 'Aspiration', 'Giocattolo', 5),
(5, 'S', 'Cefur', 'Cucina', 7),
(6, 'N', 'Aten', 'Giocattolo', 9),
(7, 'N', 'Rubus', 'Gadget', 9),
(8, 'O', 'Otic', 'Gadget', 2),
(9, 'O', 'Mirta', 'Cucina', 5),
(10, 'O', 'Wal', 'Gadget', 8),
(11, 'N', 'Drainer', 'Cucina', 2),
(12, 'N', 'Oxy', 'Cucina', 1),
(13, 'E', 'Quack Grass', 'Giocattolo', 4),
(14, 'N', 'Ready America', 'Cucina', 6),
(15, 'O', 'Relief', 'Giocattolo', 10),
(16, 'S', 'HOM', 'Gadget', 9),
(17, 'E', 'BestGad', 'Giocattolo', 8),
(18, 'O', 'Brivio', 'Giocattolo', 7),
(19, 'E', 'M&M', 'Gadget', 6),
(20, 'S', 'HeightHigh', 'Gadget', 5),
(21, 'S', 'Papa s Pizza', 'Cucina', 4),
(22, 'E', 'RampD', 'Gadget', 3),
(23, 'S', 'PAUL', 'Giocattolo', 2),
(24, 'N', 'Mantle', 'Gadget', 1),
(25, 'S', 'Bob', 'Giocattolo', 9),
(26, 'O', 'Mauv', 'Giocattolo', 7),
(27, 'E', 'Blue', 'Gadget', 4),
(28, 'S', 'Yellow', 'Cucina', 1),
(29, 'N', 'Purple', 'Cucina', 5),
(30, 'S', 'Turquoise', 'Cucina', 9),
(32, 'E', 'Red', 'Gadget', 9),
(31, 'O', 'Indigo', 'Gadget', 9),
(33, 'E', 'Violet', 'Cucina', 8),
(34, 'O', 'Khaki', 'Gadget', 9),
(35, 'N', 'Green', 'Gadget', 2),
(36, 'E', 'Fuscia', 'Giocattolo', 3);

 insert into Partita (Id_Partita, Num_Spettatori, Game, Palazzetto) values (1, 0, 'Blockdark', 3),
  (2, 0, 'Bluemania', 2),
  (3, 0, 'SuperHot', 4),
  (4, 0, 'Fusiondoom', 9),
  (5, 0, 'Archeshock', 1),
  (6, 0, 'Bladegene', 10),
  (7, 0, 'Astroplan', 4),
  (8, 0, 'Ultrawatch', 10),
  (9, 0, 'Endorreign', 2),
  (10, 0, 'Castleline', 1),
  (11, 0, 'Twolife', 7),
  (12, 0, 'Demonsite', 10),
  (13, 0, 'Astroworks', 10),
  (14, 0, 'Twolife', 10),
  (15, 0, 'Dreamland', 4),
  (16, 0, 'Bluemania', 10),
  (17, 0, 'Castleline', 3),
  (18, 0, 'Bluemania', 3),
  (19, 0, 'Astroplan', 7),
  (20, 0, 'Dreamland', 2),
  (21, 0, 'Fusionnite', 4),
  (22, 0, 'Blocklight', 3),
  (23, 0, 'NoGame', 8),
  (24, 0, 'Alterwhite', 5),
  (25, 0, 'Blocklight', 10),
  (26, 0, 'NoTime', 10),
  (27, 0, 'Astroplan', 10),
  (28, 0, 'Astroplan', 1),
  (29, 0, 'Bladegene', 3),
  (30, 0, 'Sonic', 1),
  (31, 0, 'Ultrawatch', 9),
  (32, 0, 'Clusterrush', 7),
  (33, 0, 'Bladegene', 9),
  (34, 0, 'Dreamland', 7),
 (35, 0, 'Ultrawatch', 5),
  (36, 0, 'Astroplan', 2),
  (37, 0, 'Blockdark', 2),
  (38, 0, 'Ultralife', 7),
  (39, 0, 'Blocklight', 10),
  (40, 0, 'Twolife', 1),
  (41, 0, 'NoTime', 3),
  (42, 0, 'Bladegene', 7),
  (43, 0, 'Fusiondoom', 7),
  (44, 0, 'Deltashot', 2),
  (45, 0, 'Astroplan', 5),
  (46, 0, 'Dreamland', 7),
  (47, 0, 'Blockdark', 1),
  (48, 0, 'Dreamland', 2),
  (49, 0, 'Hellstar', 1),
  (50, 0, 'Alterwhite', 8),
  (51, 0, 'Blocklight', 7),
  (52, 0, 'SuperHot', 10),
  (53, 0, 'Fusionnite', 6),
  (54, 0, 'Blocklight', 4),
  (55, 0, 'Ultralife', 3),
  (56, 0, 'Hundredlight', 4),
  (57, 0, 'Demonsite', 3),
  (58, 0, 'Bluemania', 3),
  (59, 0, 'Sonic', 5),
  (60, 0, 'Astroplan', 5);

insert into Biglietto (Id, Prezzo, Sconto, Possessore, Sessione) values(121, 20, FALSE, 'hlivermore1@myspace.com', 54) ,
  (174, 10, TRUE, 'qcowderay0@gizmodo.com', 37) ,
  (171, 20, FALSE, 'dmcelwee2@miitbeian.gov.cn', 13) ,
  (128, 20, FALSE, 'rbirtwhistle3@delicious.com', 43) ,
  (194, 20, FALSE, 'clightbourne4@surveymonkey.com', 43) ,
  (158, 20, FALSE, 'wgoodliff5@miitbeian.gov.cn', 55) ,
  (152, 20, FALSE, 'tgreenall6@tiny.cc', 23) ,
  (177, 20, FALSE, 'gstronach7@trellian.com', 3) ,
  (160, 20, FALSE, 'ypowelee8@hc360.com', 22) ,
  (100, 20, FALSE, 'djerger9@mashable.com', 40) ,
  (101, 20, FALSE, 'lnaullsa@loc.gov', 6) ,
  (186, 20, FALSE, 'csomerscalesb@imgur.com', 51) ,
  (137, 20, FALSE, 'caimsonc@toplist.cz', 55) ,
  (166, 10, TRUE, 'emccorkindaled@tumblr.com', 14) ,
  (149, 20, FALSE, 'gtraslere@posterous.com', 9) ,
  (108, 10, TRUE, 'ctarver0@istockphoto.com', 48) ,
  (134,20,FALSE,'kcysone@dell.com',14),
  (188, 20, FALSE, 'cdudman1@google.it', 4) ,
  (195, 20, FALSE, 'pshardlow2@netlog.com', 13) ,
  (116, 20, FALSE, 'dsmy3@economist.com', 60) ,
  (140, 20, FALSE, 'awrassell4@ibm.com', 59) ,
  (122, 20, FALSE, 'hplaskitt5@webmd.com', 55) ,
  (119, 20, FALSE, 'salvarado6@opera.com', 42) ,
  (151, 20, FALSE, 'thylden7@mapy.cz', 40) ,
  (185, 20, FALSE, 'chymus8@addtoany.com', 29) ,
  (164, 10, TRUE, 'jnewns9@123-reg.co.uk', 14) ,
  (139, 20, FALSE, 'gmullengerc@sakura.ne.jp', 12) ,
  (199, 20, FALSE, 'thamprechtd@yellowbook.com', 38) ,
  (129, 10, TRUE, 'cowderay0@gizmodo.com', 15) ,
  (170, 20, FALSE, 'cdelff@discuz.net', 12) ,
  (103, 20, FALSE, 'trostronh@marriott.com', 41) ,
  (159, 20, FALSE, 'trostronh@marriott.com', 27) ,
  (198, 20, FALSE, 'wcarabinei@newyorker.com', 51) ,
  (135, 20, FALSE, 'rliveingj@wp.com', 3) ,
  (173, 20, FALSE, 'cmonteauxk@naver.com', 44) ,
  (191, 20, FALSE, 'asheal@bravesites.com', 30) ,
  (148, 20, FALSE, 'yplumridegem@go.com', 12) ,
  (111, 20, FALSE, 'hgaughann@live.com', 42) ,
  (156, 20, FALSE, 'tdownhamo@slashdot.org', 59) ,
  (168, 20, FALSE, 'dsmy3@economist.com', 55) ,
  (162, 20, FALSE, 'lnaullsa@loc.gov', 55) ,
  (176, 20, FALSE, 'gstronach7@trellian.com', 11) ,
  (102, 20, FALSE, 'wgoodliff5@miitbeian.gov.cn', 44) ,
  (114, 20, FALSE, 'chymus8@addtoany.com', 37) ,
  (130, 20, FALSE, 'dmcelwee2@miitbeian.gov.cn', 31) ,
  (181, 20, FALSE, 'ypowelee8@hc360.com', 11) ,
  (157, 20, FALSE, 'asheal@bravesites.com', 36) ,
  (197, 20, FALSE, 'gmullengerc@sakura.ne.jp', 47) ,
  (180, 20, FALSE, 'hplaskitt5@webmd.com', 33) ,
  (107, 10, TRUE, 'qcowderay0@gizmodo.com', 42) ,
  (127, 20, FALSE, 'gstronach7@trellian.com', 44) ,
  (123, 20, FALSE, 'talawaya@techcrunch.com', 39) ,
  (190, 20, FALSE, 'cdudman1@google.it', 31) ,
  (113, 20, FALSE, 'thamprechtd@yellowbook.com', 4) ,
  (161, 10, TRUE, 'jjewerb@histats.com', 15) ,
  (126, 10, TRUE, 'emccorkindaled@tumblr.com', 43) ,
  (163, 10, TRUE, 'ctarver0@istockphoto.com', 14) ,
  (141, 20, FALSE, 'rbirtwhistle3@delicious.com', 17) ,
  (193, 20, FALSE, 'gmullengerc@sakura.ne.jp', 47) ,
  (143, 10, TRUE, 'qcowderay0@gizmodo.com', 15) ,
  (136, 10, TRUE, 'qcowderay0@gizmodo.com', 29);
  

insert into Partecipare (Gruppo, Sessione) values ('Virtus', 1);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 2);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 3);
insert into Partecipare (Gruppo, Sessione) values ('G2', 4);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 5);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 6);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 7);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 8);
insert into Partecipare (Gruppo, Sessione) values ('G2', 9);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 10);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 11);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 12);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 13);
insert into Partecipare (Gruppo, Sessione) values ('G2', 14);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 15);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 16);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 17);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 18);
insert into Partecipare (Gruppo, Sessione) values ('G2', 19);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 20);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 21);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 22);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 23);
insert into Partecipare (Gruppo, Sessione) values ('G2', 24);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 25);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 26);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 27);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 28);
insert into Partecipare (Gruppo, Sessione) values ('G2', 29);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 30);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 31);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 32);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 33);
insert into Partecipare (Gruppo, Sessione) values ('G2', 34);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 35);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 36);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 37);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 38);
insert into Partecipare (Gruppo, Sessione) values ('G2', 39);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 40);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 41);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 42);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 43);
insert into Partecipare (Gruppo, Sessione) values ('G2', 44);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 45);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 46);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 47);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 48);
insert into Partecipare (Gruppo, Sessione) values ('G2', 49);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 50);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 51);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 52);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 53);
insert into Partecipare (Gruppo, Sessione) values ('G2', 54);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 55);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 56);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 57);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 58);
insert into Partecipare (Gruppo, Sessione) values ('G2', 59);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 60);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 2);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 3);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 4);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 5);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 7);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 8);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 9);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 10);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 12);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 13);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 14);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 15);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 17);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 18);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 19);
insert into Partecipare (Gruppo, Sessione) values ('Virtus', 20);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 25);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 31);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 48);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 4);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 21);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 29);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 5);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 16);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 30);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 59);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 28);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 34);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 39);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 59);
insert into Partecipare (Gruppo, Sessione) values ('FNatic', 44);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 50);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 1);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 34);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 15);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 2);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 10);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 9);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 44);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 32);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 47);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 6);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 35);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 47);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 23);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 55);
insert into Partecipare (Gruppo, Sessione) values ('BMF', 10);
insert into Partecipare (Gruppo, Sessione) values ('G2', 5);
insert into Partecipare (Gruppo, Sessione) values ('G2', 10);
insert into Partecipare (Gruppo, Sessione) values ('G2', 38);
insert into Partecipare (Gruppo, Sessione) values ('G2', 11);
insert into Partecipare (Gruppo, Sessione) values ('G2', 27);
insert into Partecipare (Gruppo, Sessione) values ('G2', 10);
insert into Partecipare (Gruppo, Sessione) values ('G2', 42);
insert into Partecipare (Gruppo, Sessione) values ('G2', 31);
insert into Partecipare (Gruppo, Sessione) values ('G2', 28);
insert into Partecipare (Gruppo, Sessione) values ('G2', 36);
insert into Partecipare (Gruppo, Sessione) values ('G2', 33);
insert into Partecipare (Gruppo, Sessione) values ('G2', 60);
insert into Partecipare (Gruppo, Sessione) values ('G2', 37);
insert into Partecipare (Gruppo, Sessione) values ('G2', 12);
insert into Partecipare (Gruppo, Sessione) values ('G2', 18);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 1);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 49);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 33);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 7);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 17);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 3);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 41);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 28);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 59);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 48);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 46);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 11);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 12);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 21);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 53);
insert into Partecipare (Gruppo, Sessione) values ('NiP', 36);


insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (1, 0, NULL, false, 'Premio di Google', NULL, 1);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (2, 0, NULL, false, 'Premio di Google', NULL, 2);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (3, 0, '2022-10-11', true, 'Premio di Google', 'NiP', 3);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (4, 0, '2022-10-25', true, 'Premio di Facebook', 'FNatic', 4);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (5, 0, '2022-10-11', true, 'Premio di Facebook', 'FNatic', 5);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (6, 0, '2022-10-09', true, 'Premio di Google', 'Virtus', 6);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (7, 0, '2022-10-26', true, 'Premio di Facebook', 'NiP', 7);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (8, 0, NULL, false, 'Premio di Facebook', NULL, 8);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (9, 0, '2022-10-07', true, 'Premio di Amazon', 'BMF', 9);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (10, 0, '2022-10-08', true, 'Premio di Facebook', 'G2', 10);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (11, 0, '2022-10-21', true, 'Premio di Amazon', 'NiP', 11);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (12, 0, NULL, false, 'Premio di Amazon', NULL, 12);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (13, 0, '2022-10-12', true, 'Premio di Facebook', 'BMF', 13);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (14, 0, '2022-10-27', true, 'Premio di Google', 'Virtus', 14);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (15, 0, NULL, false, 'Premio di Facebook', NULL, 15);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (16, 0, '2022-10-05', true, 'Premio di Facebook', 'FNatic', 16);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (17, 0, '2022-10-07', true, 'Premio di Google', 'NiP', 17);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (18, 0, '2022-10-05', true, 'Premio di Facebook', 'G2', 18);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (19, 0, NULL, false, 'Premio di Facebook', NULL, 19);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (20, 0, NULL, false, 'Premio di Amazon', NULL, 20);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (21, 0, NULL, false, 'Premio di Google', NULL, 21);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (22, 0, NULL, false, 'Premio di Google', NULL, 22);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (23, 0, '2022-10-17', true, 'Premio di Facebook', 'BMF', 23);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (24, 0, '2022-10-17', true, 'Premio di Google', 'G2', 24);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (25, 0, '2022-10-26', true, 'Premio di Amazon', 'FNatic', 25);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (26, 0, '2022-10-14', true, 'Premio di Facebook', 'Virtus', 26);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (27, 0, '2022-10-03', true, 'Premio di Facebook', 'G2', 27);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (28, 0, NULL, false, 'Premio di Google', NULL, 28);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (29, 0, NULL, false, 'Premio di Google', NULL, 29);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (30, 0, NULL, false, 'Premio di Google', NULL, 30);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (31, 0, '2022-10-18', true, 'Premio di Google', 'G2', 31);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (32, 0, '2022-10-18', true, 'Premio di Amazon', 'BMF', 32);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (33, 0, NULL, false, 'Premio di Google', NULL, 33);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (34, 0, '2022-10-02', true, 'Premio di Amazon', 'FNatic', 34);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (35, 0, NULL, false, 'Premio di Google', NULL, 35);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (36, 0, '2022-10-08', true, 'Premio di Amazon', 'NiP', 36);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (37, 0, '2022-10-19', true, 'Premio di Google', 'G2', 37);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (38, 0, NULL, false, 'Premio di Amazon', NULL, 38);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (39, 0, '2022-10-25', true, 'Premio di Amazon', 'G2', 39);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (40, 0, NULL, false, 'Premio di Google', NULL, 40);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (41, 0, '2022-10-10', true, 'Premio di Google', 'NiP', 41);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (42, 0, NULL, false, 'Premio di Google', NULL, 42);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (43, 0, NULL, false, 'Premio di Google', NULL, 43);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (44, 0, '2022-10-20', true, 'Premio di Amazon', 'BMF', 44);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (45, 0, NULL, false, 'Premio di Amazon', NULL, 45);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (46, 0, NULL, false, 'Premio di Facebook', NULL, 46);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (47, 0, NULL, false, 'Premio di Facebook', NULL, 47);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (48, 0, '2022-10-19', true, 'Premio di Amazon', 'FNatic', 48);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (49, 0, NULL, false, 'Premio di Amazon', NULL, 49);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (50, 0, NULL, false, 'Premio di Google', NULL, 50);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (51, 0, '2022-10-22', true, 'Premio di Google', 'Virtus', 51);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (52, 0, '2022-10-06', true, 'Premio di Facebook', 'FNatic', 52);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (53, 0, '2022-10-01', true, 'Premio di Google', 'NiP', 53);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (54, 0, NULL, false, 'Premio di Facebook', NULL, 54);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (55, 0, NULL, false, 'Premio di Amazon', NULL, 55);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (56, 0, NULL, false, 'Premio di Google', NULL, 56);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (57, 0, '2022-10-11', true, 'Premio di Google', 'FNatic', 57);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (58, 0, '2022-10-04', true, 'Premio di Google', 'BMF', 58);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (59, 0, NULL, false, 'Premio di Amazon', NULL, 59);
insert into Premio (Id_Premio, Valore, Data_Vincita, Vittoria, Descrizione, Gruppo, Sessione) values (60, 0, NULL, false, 'Premio di Facebook', NULL, 60);


--fare update di num spettatori contando i biglietti
UPDATE Partita AS P1
set Num_Spettatori =(
			COALESCE((SELECT COUNT(*)
			FROM Biglietto AS B
			WHERE P2.Id_Partita = B.Sessione
			GROUP BY P2.Id_Partita),0)
		)
FROM Partita AS P2
WHERE P1.Id_Partita = P2.Id_Partita;


UPDATE Premio AS P
set Valore = (20* S.Num_Spettatori)
FROM Partita as S
WHERE S.Id_Partita = P.Sessione;


--Mostrare quali Team, restituendo nome e icona, ad aver giocato più partite durante il torneo.
drop view if exists PartiteTeam;
CREATE VIEW PartiteTeam(NomeTeam, Icona,npartite)AS
SELECT Nome_Team, Icona_Team, COUNT(*)
FROM Team AS T, Partecipare AS K
WHERE T.Nome_Team = K.Gruppo
GROUP BY Nome_Team;

SELECT NomeTeam, Icona, npartite
FROM PartiteTeam
WHERE npartite = (SELECT MAX(npartite) FROM PartiteTeam);


--Mostrare il numero di stand dello stesso tipo che sono presenti nell'arena '9'
SELECT Tipo, COUNT(*)
FROM Stand AS S, Arena AS A
WHERE S.Palazzetto = A.Codice_Arena
GROUP BY Tipo, A.Codice_Arena
HAVING A.Codice_Arena = 9;

--Calcolare la quantità di biglietti ridotti, quindi ad un target bambino, che sono stati venduti per poter partecipare alla partita con codice '5'

SELECT Sessione, COUNT(*)
FROM Biglietto AS B, Spettatore AS S
WHERE S.Email = B.Possessore AND Sessione = 15 AND S.Età <=12
GROUP BY Sessione;


--Visualizzare tutte le arene (codice e nome relativo) dove sono state svolte le partite del gioco con il best rated (quello con la miglior valutazione)
drop view if exists bestRated_Match;
CREATE VIEW bestRated_Match(Codice_Partita) AS
SELECT P.Id_Partita
FROM Gioco AS G,Partita AS P
WHERE P.Game  =G.Nome_Gioco
GROUP BY Id_Partita,G.Rating
HAVING G.Rating = (SELECT DISTINCT MAX (G.Rating)
                  FROM Gioco
                  );

SELECT A.Codice_Arena, A.Nome_Arena
FROM bestRated_Match AS B, Arena AS A
WHERE B.Codice_Partita = A.Codice_Arena;

--Mostrare il nome del gioco con relativo id della partita dove è stato vinto il premio di maggior valore e il relativo team vincitore
drop view if exists higher_price CASCADE;
CREATE VIEW higher_price (NomeTeam, valorepremio) AS
SELECT P.Gruppo, MAX(P.Valore)
FROM Team AS T, Premio AS P
WHERE P.Gruppo = T.Nome_Team AND Vittoria = TRUE
GROUP BY P.Gruppo;


SELECT Id_Partita, P.Valore, H.NomeTeam, A.Game
FROM higher_price AS H, Partita AS A, Premio AS P
WHERE A.Id_Partita = P.Sessione AND P.Gruppo = H.NomeTeam AND P.Valore = ( SELECT MAX(valorepremio)
                                                                        FROM higher_price
                                                                );

--Per un sondaggio relativo agli spettatori si chiede di mostrare quante tra le persone che partecipano come tali all’International GamingSport sono di sesso femminile e quanti di sesso maschile con relativa età media

drop view if exists gender_count;
drop view if exists avg_age;
CREATE VIEW gender_count (Genere, npartecipanti) AS
SELECT Sesso, COUNT(*) 
FROM Spettatore
GROUP BY Sesso;

CREATE VIEW avg_age (Genere, etàmedia) AS
SELECT Sesso, AVG(età)::REAL
FROM Spettatore
GROUP BY Sesso;

SELECT G.Genere, G.npartecipanti, A.etàmedia 
FROM gender_count AS G, avg_age AS A
WHERE A.Genere=G.Genere;



