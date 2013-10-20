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

