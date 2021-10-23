.PHONY: docker-build
docker-build:
	docker build -t kobayashi/disn-train container

.PHONY: docker-run
docker-run:
	docker run -it -d --gpus all -v `pwd`:/usr/workspace -v ~/hdd01/:/hdd01/ -v ~/datasets/:/ssd/datasets/ --name disn-train kobayashi/disn-train

.PHONY: docker-exec
docker-exec:
	docker exec -it disn-train /bin/bash

.PHONY: clean
clean:
	-docker stop disn-train
	docker rm disn-train

.PHONY: demo
demo:
	python -u demo/demo.py --cam_est --log_dir checkpoint/my_train/ --cam_log_dir cam_est/checkpoint/cam_DISN/ --img_feat_twostream --sdf_res 64 > log/create_sdf.log

.PHONY: cam-train
cam-train:
	python -u cam_est/train_sdf_cam.py --log_dir cam_est/checkpoint/my_train_twostream --batch_size 16 --restore_modelcnn models/CNN/pretrained_model/vgg_16.ckpt --gpu 0 --loss_mode 3D --learning_rate 2e-5 > log/cam_3d_all_two.log 2>&1
	
.PHONY: sdf-train
sdf-train:
	python -u train/train_sdf.py --gpu 0 --img_feat_twostream --restore_modelcnn ./models/CNN/pretrained_model/vgg_16.ckpt --log_dir checkpoint/1023_train_twostream --category all --num_sample_points 2048 --batch_size 20 --learning_rate 0.0001 --cat_limit 36000 > log/1023_sdf_train.log 2>&1