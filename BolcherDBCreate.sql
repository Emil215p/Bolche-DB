CREATE DATABASE Bolcher;
GO

USE Bolcher;

CREATE TABLE BolcheStats ( --data.type
  StatsID int IDENTITY PRIMARY KEY NOT NULL,  
  Name nvarchar(255) NOT NULL,
  Unit nvarchar(255) NOT NULL
);
GO

CREATE TABLE BolcheType ( --item.type
  TypeID int IDENTITY PRIMARY KEY NOT NULL,
  Name nvarchar(255) NOT NULL
); 
GO

CREATE TABLE Bolcher ( --item
  BolcheID int IDENTITY PRIMARY KEY NOT NULL,
  Name nvarchar(255) NOT NULL,
  TypeID int FOREIGN KEY REFERENCES BolcheType(TypeID) NOT NULL
);
GO

CREATE TABLE TypeofTrait ( --item.TraitType
  TraitTypeID int IDENTITY PRIMARY KEY NOT NULL,
  Name nvarchar(255) NOT NULL
);
GO

CREATE TABLE ItemTraits ( --item.Trait
  BolcheID int FOREIGN KEY REFERENCES Bolcher(BolcheID) NOT NULL,
  TraitTypeID int FOREIGN KEY REFERENCES TypeofTrait(TraitTypeID) NOT NULL,
  StatsID int FOREIGN KEY REFERENCES BolcheStats(StatsID) NOT NULL,
  Value nvarchar(255) NOT NULL
);
GO

CREATE TABLE Indkøbsvogn (
IndkøbsvognID int IDENTITY PRIMARY KEY NOT NULL,
BolcheID int FOREIGN KEY REFERENCES Bolcher(BolcheID) NOT NULL,
Mængde int NOT NULL,
);
GO

CREATE TABLE ForsendelsesInfo (
ForsendelsesInfoID int PRIMARY KEY IDENTITY NOT NULL,
Adresse nvarchar(255) NOT NULL,
Postnummer int NOT NULL,
ByNavn nvarchar(255) NOT NULL --Called ByNavn cause By is not a valid name.
);
GO

CREATE TABLE Kunder (
KundeID int IDENTITY PRIMARY KEY NOT NULL,
Navn nvarchar(255) NOT NULL,
Email nvarchar(255) NOT NULL,
Telefon nvarchar(255) UNIQUE NOT NULL,
Adgangskode nvarchar(255) NOT NULL,
ForsendelsesInfoID int FOREIGN KEY REFERENCES ForsendelsesInfo(ForsendelsesInfoID)
);
GO

CREATE TABLE Ordre (
OrdreID int IDENTITY PRIMARY KEY NOT NULL,
KundeID int FOREIGN KEY REFERENCES Kunder(KundeID),
IndkøbsvognID int FOREIGN KEY REFERENCES Indkøbsvogn(IndkøbsvognID) NOT NULL,
ForsendelsesInfoID int FOREIGN KEY REFERENCES ForsendelsesInfo(ForsendelsesInfoID) NOT NULL,
OrdreDato datetime2(3) NOT NULL
);
GO