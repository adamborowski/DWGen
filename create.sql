USE HD;

CREATE TABLE Restauracje (
  id INT PRIMARY KEY,
  nazwa VARCHAR(32) NOT NULL,
  adres VARCHAR(255) NOT NULL,
  godzina_otwarcia TINYINT NOT NULL,
  godzina_zamkniecia TINYINT NOT NULL,
  liczba_miejsc SMALLINT NOT NULL
);

CREATE TABLE Kelnerzy (
  id INT PRIMARY KEY,
  id_restauracji INT REFERENCES Restauracje,
  nazwisko VARCHAR(64) NOT NULL,
  imie VARCHAR(32) NOT NULL,
  data_zatrudnienia SMALLDATETIME NOT NULL  
);

CREATE TABLE Zamowienia (
  id INT PRIMARY KEY,
  id_kelnera INT REFERENCES Kelnerzy NOT NULL,
  data_przyjecia SMALLDATETIME NOT NULL,
  data_platnosci SMALLDATETIME NOT NULL,
  nr_stolika SMALLINT NOT NULL,
  kod_rabatu CHAR(13),
  platnosc VARCHAR(16)
);

CREATE TABLE Kategorie (
  id INT PRIMARY KEY,
  nazwa VARCHAR(32) NOT NULL,
  opis VARCHAR(255)
);

CREATE TABLE Dania (
  id INT PRIMARY KEY,
  id_kategorii INT REFERENCES Kategorie NOT NULL,
  nazwa VARCHAR(64) NOT NULL,
  cena DECIMAL(7, 2) NOT NULL,
  porcja SMALLINT NOT NULL,
  jednostka CHAR(3) NOT NULL,
  CONSTRAINT ck_dania_jednostka
		CHECK (jednostka IN ('g', 'ml', 'szt'))
);

CREATE TABLE ZamowieniaDania (
  id_zamowienia INT REFERENCES Zamowienia,
  id_dania INT REFERENCES Dania,
  liczba_porcji TINYINT NOT NULL,
  cena_za_porcje DECIMAL(7, 2) NOT NULL,
  CONSTRAINT pk_zamowieniadania PRIMARY KEY (id_zamowienia, id_dania)
);

