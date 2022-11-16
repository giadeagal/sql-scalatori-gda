/*
1
Calcolare l'insieme (non il multi-insieme) delle coppie (A,B) tali che A è uno scalatore e B è un continente in cui A ha effettuato una scalata.*/

SELECT DISTINCT 
    SR.cf AS scalatore,
    N.continente
FROM 
    scalata AS ST
    JOIN scalatore AS SR
        ON SR.cf = ST.scalatore 
    JOIN nazione AS N
        ON ST.nazione = N.nome

/*
2
Per ogni scalatore nato prima del 1980, calcolare tutti i continenti in cui ha effettuato una scalata, ordinando il risultato per codice fiscale e, a parità di codice fiscale, per il nome del continente.*/
SELECT DISTINCT
    SR.cf AS scalatore,
    N.nome AS continente
FROM 
    scalata AS ST
    JOIN scalatore AS SR
        ON SR.cf = ST.scalatore 
    JOIN nazione AS N
        ON ST.nazione = N.nome
ORDER BY  
    SR.cf

/*
3
Calcolare le nazioni (mostrando, per ciascuna, anche il continente) nelle quali è stata effettuata almeno una scalata da uno scalatore minorenne.*/

SELECT 
    N.nome AS nazione,
    N.continente
FROM  
    scalata AS ST
    JOIN scalatore AS SR
        ON SR.cf = ST.scalatore 
    JOIN nazione AS N
        ON ST.nazione = N.nome
WHERE 
    (ST.anno - SR.annonascita) < 18

/*
4
Per ogni nazione, calcolare il numero di scalate effettuate da scalatori nati in quella nazione.*/

SELECT
    N.nome AS nazione,
    count(*) AS numScalatoriNativi
FROM 
    scalata AS ST
    JOIN scalatore AS SR
        ON SR.cf = ST.scalatore 
    JOIN nazione AS N
        ON ST.nazione = N.nome
WHERE 
    ST.nazione = SR.nazionenascita
GROUP BY 
    N.nome

/*
5
Per ogni continente, calcolare il numero di scalate effettuate da scalatori nati in una nazione di quel continente.*/

SELECT 
    N1.continente,
    count(DISTINCT SR.cf) AS scalatenativi
FROM 
    scalatore AS SR
    JOIN nazione AS N1
        ON SR.nazionenascita = N1.nome
    JOIN scalata AS ST
        ON ST.scalatore = SR.cf
    JOIN nazione AS N2
        ON ST.nazione = N2.Nome
WHERE
    N1.continente = N2.continente
GROUP BY
    N1.continente

/*
6
Calcolare codice fiscale, nazione di nascita, continente di nascita di ogni scalatore nato in un continente diverso dall’America, e, solo se egli ha effettuato almeno una scalata, affiancare queste informazioni alle nazioni in cui ha effettuato scalate.*/

SELECT 
    SR.cf AS scalatore, 
    N.nome AS nazione, 
    N.continente
FROM 
    scalatore AS SR
    JOIN scalata AS ST 
        ON SR.cf = ST.scalatore
    JOIN nazione AS N
        ON ST.nazione = N.nome
WHERE
    N.continente != 'America'

/*
7
Per ogni nazione e per ogni anno, calcolare il numero di scalate effettuate in quella nazione e in quell’anno Nel risultato le nazioni dello stesso continente devono essere mostrati in tuple contigue, e le tuple relative allo stesso continente devono essere ordinate per anno.*/

SELECT
N.nome,
ST.anno,
count(N.nome) AS scalatenaz,
count(ST.*) AS scalateanno
FROM 
    scalatore AS SR
    JOIN scalata AS ST 
        ON SR.cf = ST.scalatore
    JOIN nazione AS N
        ON ST.nazione = N.nome
GROUP BY 
    N.nome, N.continente, ST.nazione, ST.anno
ORDER BY 
    N.continente, ST.anno DESC
        

/*
8
Per ogni nazione N, calcolare il numero medio di scalate effettuate all’anno in N da scalatori nati in nazioni diverse da N.*/

/*
9
Calcolare gli scalatori tali che tutte le scalate che hanno effettuato nella nazione di nascita le hanno effettuate quando erano minorenni.*/
