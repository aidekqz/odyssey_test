build_odyssey:
	docker build -t test_odyssey:0.1 -f Dockerfile .

get_bin:
	docker run --name test_odyssey_tmp -d --rm test_odyssey:0.1	sleep 100
	docker cp test_odyssey_tmp:/odyssey/build/sources/odyssey ./
	docker rm --force test_odyssey_tmp

make run: get_bin
	bash run.sh
