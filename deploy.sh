docker build -t apjd/multi-client:latest -t apjd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t apjd/multi-server:latest -t apjd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t apjd/multi-worker:latest -t apjd/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push apjd/multi-client:latest
docker push apjd/multi-server:latest
docker push apjd/multi-worker:latest
docker push apjd/multi-client:$SHA
docker push apjd/multi-server:$SHA
docker push apjd/multi-worker:$SHA
k
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=apjd/multi-server:$SHA
kubectl set image deployment/client-deployment client=apjd/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=apjd/multi-worker:$SHA
