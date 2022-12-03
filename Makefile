VERSION=v1
DOCKERUSER=gagankshetty
PROJECT=search-service
NAMESPACE=search-service 
build:
	mvn clean install -Dmaven.test.skip=true
	docker build -f Dockerfile -t ${PROJECT} .

push:
	docker tag ${PROJECT} $(DOCKERUSER)/${PROJECT}:$(VERSION)
	docker push $(DOCKERUSER)/${PROJECT}:$(VERSION)
	docker tag ${PROJECT} $(DOCKERUSER)/${PROJECT}:latest
	docker push $(DOCKERUSER)/${PROJECT}:latest

deploy:
	kubectl create namespace ${NAMESPACE}
	kubectl apply -f ./kubernetes -n ${NAMESPACE}

cleanup:
	kubectl delete -f ./kubernetes -n ${NAMESPACE}
	kubectl delete namespace ${NAMESPACE}