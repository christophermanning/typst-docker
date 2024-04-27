build:
	docker build -t typst-docker .

watch: build
	docker run  -v ./:/src -it typst-docker
