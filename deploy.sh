docker build -t ashutoshbhatt/multi-client:latest -t ashutoshbhatt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashutoshbhatt/multi-server:latest -t ashutoshbhatt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashutoshbhatt/multi-worker:latest -t ashutoshbhatt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ashutoshbhatt/multi-client:latest
docker push ashutoshbhatt/multi-server:latest
docker push ashutoshbhatt/multi-worker:latest

docker push ashutoshbhatt/multi-client:$SHA
docker push ashutoshbhatt/multi-server:$SHA
docker push ashutoshbhatt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=ashutoshbhatt/multi-server
kubectl set image deployments/client-deployments client=ashutoshbhatt/multi-client
kubectl set image deployments/worker-deployments worker=ashutoshbhatt/multi-worker