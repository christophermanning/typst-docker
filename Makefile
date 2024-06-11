NAME=typst-docker

# if the image doesn't exist, delete Dockerfile.build to build the image
build:
	@if [ -z "$(shell docker images -q ${NAME})" ]; then make clean; fi
	@make -s Dockerfile.build

# track the build timestamp in Dockerfile.build and build the image if the listed dependencies are newer than the image
Dockerfile.build: Dockerfile watch.sh
	docker build -t ${NAME} .
	touch $@

clean:
	rm Dockerfile.build

watch: build
	@docker run  -v ./:/src --rm -it ${NAME} watch.sh

shell: build
	@docker run  -v ./:/src --rm -it ${NAME} /bin/sh

dev:
	-tmux kill-session -t "${NAME}"
	tmux new-session -s "${NAME}" -d -n vi
	tmux send-keys -t "${NAME}:vi" "vi" Enter
	tmux new-window -t "${NAME}" -n shell "/bin/zsh"
	tmux new-window -t "${NAME}" -n build
	tmux send-keys -t "${NAME}:build" "make watch" Enter
	tmux select-window -t "${NAME}:vi"
	tmux attach-session -t "${NAME}"
