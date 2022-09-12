# zasoby

- <https://www.mkgmap.org.uk/pipermail/mkgmap-dev/2018q1/028152.html>

# wprowadzenie

- latitude / Szerokość geograficzna / symbol φ
- longitude / Długość geograficzna / symbol λ

Cała ta zabawa służy aby na mapie były zawarte izohipsy (warstwice) - czyli linie, łączące punkty o tej samej wysokości.
Projekt OSM nie ma w sobie żadnych informacji odnośnie wysokości.

Są dwa możliwości osiągnięcia tego celu

1. [Srtm2Osm]<https://wiki.openstreetmap.org/wiki/Srtm2Osm>
1. [phyghtmap]<http://katze.tfiu.de/projects/phyghtmap/index.html>

## Srtm2Osm

Narzędzie używa Windows .Net Library :) niespodziewałem się, że można uruchomic taki program na Linux'ie bez żadnych zmian, a tutaj prosze jaka niespodzianka.

1. Przygotowanie obrazu ubuntu

```bash
apt update \
    && apt install -y wget unzip gnupg ca-certificates \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb <https://download.mono-project.com/repo/ubuntu> stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt update \
    && apt install -y mono-devel

wget <http://osm.michis-pla.net/code/Srtm2Osm-1.15.4.0.zip>
unzip Srtm2Osm-1.15.4.0.zip
cd /Srtm2Osm
```

Jesteśmy teraz gotowi do pobrania danych SRTM i wygenerowania plików .osm

```bash
mono Srtm2Osm.exe -step 25 -cat 500 100 25 -large -bounds1 31 -7 31.5 -6.5 -o moroccoSRTM.osm
```

Dalsze procedowanie już w pipeline  osmosis -> spliter -> mkgmap.

- przerabiamy surowy .osm na posortowany .pbf

```bash
JAVACMD_OPTIONS=-Xmx10G /osmosis/bin/osmosis --read-xml /data/moroccoSRTM.osm --sort --write-pbf /data/moroccoSRTM-sorted.osm.pbf
```

- łączymy posortowany.pbf i danymi z geofabric

```bash
JAVACMD_OPTIONS=-Xmx10G /osmosis/bin/osmosis --read-pbf /data/moroccoSRTM-sorted.osm.pbf  --read-pbf morocco-latest.osm.pbf  --sort  --merge  --write-pbf /data/morocco-final.osm.pbf
```

## phyghtmap

1. zalety -> można mu wrzucić polygon jako granice obszaru (łatwo je pobrać z geofabric)
