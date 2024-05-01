# track the build timestamp in Dockerfile.build so the Dockerfile is rebuilt when dependencies change
Dockerfile.build: Dockerfile watch.sh
	docker build -t typst-docker .
	touch $@

clean:
	rm Dockerfile.build

watch: Dockerfile.build
	@docker run  -v ./:/src --rm -it typst-docker watch.sh
