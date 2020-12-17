# MySQL with Docker

## intro
Saya yakin banyak dari teman-teman yang bertanya-tanya, apakah bisa Database di dijalankan sebagai container.

Menurut saya tidak masalah selama dideploy dan di manage dengan baik dan benar.

**Disclaimer:**
Script yang saya upload disini **tidak** mendeklarasikan bahwa cara saya paling benar, Saya hanya berbagi pengalaman dan metode yang saya gunakan sejauh ini. Hingga saat ini konfigurasi ini dapat berjalan dengan cukup baik.

## environment
1. MySQL 5.7.x

## how-to :
### Clone the repo
>**git clone**
### Change Directory
>**cd docker-mysql**
### Pre-config
>**sh deploy.sh**
### Deploy Container
>**docker-compose up -d**

## most important things
Ketika anda membangun sebuah layanan data diatas container saya rasa anda tidak ingin kehilangan data tersebut bukan ?
Jadi saya pikir bagian dibawah ini bukan hanya penting bagi saya, betul tidak ?
```
    volumes:
      - './db-data/varlib:/var/lib/mysql/'
      - './db-data/varlog:/var/log/mysql/'
      - './db-data/tmp:/tmp/'
      - './db-conf:/etc/mysql/'
```
Bagian ini memungkinkan anda untuk menyimpan data mentah layanan anda didalam `db-data` dan juga `db-conf` (untuk kebutuhan konfigurasi). Docker menyebut metode ini 'persistent-volume' anda bisa menggali lebih dalam mengenai hal ini di tautan berikut [Docker Volume](https://docs.docker.com/storage/volumes/).

## optional important things
Bagi saya layanan database bukanlah sebuah layanan yang bisa hidup dan mati dalam hitungan detik.
Saya butuh kontrol penuh terhadap layanan tersebut, jadi saya memberikan IP statis kepada setiap container database saya.
Di kasus yang lain saya membutuhkan ip statis saat jika saya ingin menjalankan lebih dari 1(satu) container database dalam sebuah mesin dan saya ingin mengawasinya.

membuat dedicated docker network
```
networks:
  local:
    driver: bridge
    ipam:
      config:
        - subnet: 172.172.0.8/29
          gateway: 172.172.0.9
```
static ip untuk container
```
    networks:
      local:
        ipv4_address: 172.172.0.10
```
*Note : anda dapat mengganti konfigurasi IP sesuai dengan kebutuhan anda.