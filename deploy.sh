#!/usr/bin/env bash
docker build -t olegpochanskiy/multi-client:latest -t olegpochanskiy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olegpochanskiy/multi-server:latest -t olegpochanskiy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olegpochanskiy/multi-worker:latest -t olegpochanskiy/multi-worker:$SHA -f ./worker/Dockerfile ./worker/

docker push olegpochanskiy/multi-client:latest
docker push olegpochanskiy/multi-server:latest
docker push olegpochanskiy/multi-worker:latest

docker push olegpochanskiy/multi-client:$SHA
docker push olegpochanskiy/multi-server:$SHA
docker push olegpochanskiy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olegpochanskiy/multi-server:$SHA
kubectl set image deployments/client-deployment client=olegpochanskiy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=olegpochanskiy/multi-worker:$SHA