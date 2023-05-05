# VHDL projekt - UART

### Členi týmu

* Peter Pánisz (ja)
* Eduard Chyba
* Martin Borka

## Theoretical description and explanation

UART (z anglického Universal asynchronous receiver-transmitter) je sběrnice, která slouží k asynchronnímu sériovému přenosu dat.

Popis přenosu

Když vysílač nevysílá tak je vysílaný signál nastaven na logickou hodnotu 1, při vysílaní se nejdříve pošle start bit reprezentovám logickou 0 a pak jáslebují bity přenášených dat. Může následovat paritní bit který je volitelný, a nakonec stop bit reprezentován logickou 1.

## Hardware

V tomto projektu využíváme desku nexys a7-50t od firmy Nexys. Tato deska nabízí mnoho možných vstupů a výstupů. V našem případě používáme přepínače a jedno tlačítko, pro nastavení zařízení.

V případu vysílače slouží 8 přepínačů v pravo (SW 0-7) pro nastavení 8 bitů které budeme odesílat přez port JA(0). Poté je tu ještě přepínač nalevo (SW 15) díky kterému mužeme nastavovat rychlost přenosu neboli bautrate. Poslední ovládací prvek je prostřední tlačítko, které zastává funkci reset (vyresetuje vnitřní program pokud by bylo potřeba).

Přijímač přímá na portu JD(0) přepínač 15 a tlačítko reset zde zastávají stejnou funkci. U obou dvou programech se vysílaná či příjmaná 8 bitová zpráva ukázuje na osmi sedmi segmentových displejích.

## Software description

TX:

Data navolená na přepínačích jdou jak do driveru pro zobrazení na displeji tak to samotného vysílače tx, kde jsou pomocí clock_en a čítače postupně odesílány podle pravidel UART. Rychlost odesílání neboli rychlost čítače a clock_en jsou závislé na bautratu který můžeme měnit mezi 2 předem nastavenými hodnotami. tok dat je z tx následně odeslán dále.

![Screenshot_2](https://user-images.githubusercontent.com/124675843/235603958-2d143e35-bda2-410f-bf94-b7b2e43c558b.png)

![Screenshot_3](https://user-images.githubusercontent.com/124675843/235604029-a33e8a77-291d-4fd4-af66-0bf1092bd1fe.png)

RX:

Data přijatá z portu se pomocí clock_en a čítače zapíší do vnitřního signálu který dále potuje to zobrazovací metody. Zprávné dekódování a zapsaní hodnot je závislé na bautratu který se může měnit mezi 2 předem nastavenými hodnotami.

![Screenshot_4](https://user-images.githubusercontent.com/124675843/235610020-72f0992c-9d3c-44c9-afda-89ca4fcbbedc.png)


## Ovládání
naše UART jsou 2 ruzné programy rx a tx.

TX:

8 Přepínačů na pravo (SW 0-7): nastavování hodnot odesílaných bitů 8, které se zobrazí na displejích

Přepínač vlevo (SW 15): přepnutí mezi 9600 a 19200 BD

Prostřední tlačítko: reset

Zpráva se vysílá portem JA(0)

RX:

Přijmací port je JD(0) a přijaté byty se zobrazí na displejích

Přepínač vlevo (SW 15): přepnutí mezi 9600 a 19200 BD

Prostřední tlačítko: reset

Fotky a video při ovládání
https://drive.google.com/drive/u/0/folders/1ZnK623iUQfYHucdSUApsKEXAbp9egKUu

## References

1. https://cs.wikipedia.org/wiki/UART
