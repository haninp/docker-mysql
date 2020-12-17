#!/bin/bash
mkdir db-data;
mkdir db-data/tmp;
mkdir db-data/varlib;
mkdir db-data/varlog;
chmod -R 777 db-data;
echo "create initial directory done";
docker-compose up -d;
echo "deploy container done";