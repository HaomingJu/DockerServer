#!/usr/bin/env bash

pushd ./semaphore
     docker container rm semaphore-semaphore-1 semaphore-mysql-1 -f
     docker volume rm semaphore_semaphore-mysql
     docker compose up
popd
