docker build -t pkn2009/multi-client:latest -t pkn2009/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pkn2009/multi-server:latest -t pkn2009/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pkn2009/multi-worker:latest -t pkn2009/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pkn2009/multi-client:latest
docker push pkn2009/multi-server:latest
docker push pkn2009/multi-worker:latest
docker push pkn2009/multi-client:$SHA
docker push pkn2009/multi-server:$SHA
docker push pkn2009/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=pkn2009/multi-server:$SHA
kubectl set image deployments/client-deployment client=pkn2009/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pkn2009/multi-worker:$SHA

