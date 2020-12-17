# MySQL with Docker

## intro
I guess many of you have a question 
_is it possible running a database service over a docker container_ ?

In my opinion, it doesn't matter as long as it is deployed and managed properly.

**Disclaimer:**
The script i upload here doesn't declare that my method is corect one, i only share my experiences and the methods i have used so far. Until i wrote this repo, this configuration can run quite well.

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
When you build 'data' service over container base you didn't expect to lose your data i guess.
So i think this section is quitely important not just for me. isn't it ?
```
    volumes:
      - './db-data/varlib:/var/lib/mysql/'
      - './db-data/varlog:/var/log/mysql/'
      - './db-data/tmp:/tmp/'
      - './db-conf:/etc/mysql/'
```
this section allow you to store 'raw' data on `db-data` and also `db-conf` (for configuration purpose). Docker call this method 'persistent-volume' and you can dig more deep about it on [Docker Volume](https://docs.docker.com/storage/volumes/).

## optional important things
For me, database is not just services you can deploy it for a second but just dropped for another second.
I want full of control on it, so i give my code for give the container an static IP so i can access my database directly.
In another hand i need them if i want running many database engine in one machine and i need to monitor all of it.

create dedicated docker network
```
networks:
  local:
    driver: bridge
    ipam:
      config:
        - subnet: 172.172.0.8/29
          gateway: 172.172.0.9
```
static ip for my container
```
    networks:
      local:
        ipv4_address: 172.172.0.10
```
*Note : you can change ip configuration base on your own.