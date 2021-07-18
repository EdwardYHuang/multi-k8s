docker build -t edwardyhuang/multi-client:latest -t edwardyhuang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t edwardyhuang/multi-server:latest -t edwardyhuang/multi-server:$SHA -f ./server/Dockerfule ./server
docker build -t edwardyhuang/multi-worker:latest -t edwardyhuang/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push edwardyhuang/multi-client:latest
docker push edwardyhuang/multi-server:latest
docker push edwardyhuang/multi-worker:latest

docker push edwardyhuang/multi-client:$SHA
docker push edwardyhuang/multi-server:$SHA
docker push edwardyhuang/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=edwardyhuang/multi-server:$SHA
kubectl set image deployments/client-deployment client=edwardyhuang/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=edwardyhuang/multi-worker:$SHA
