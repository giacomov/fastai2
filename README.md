# Welcome to fastai v2
> NB: This is still in early development. Use v1 unless you want to contribute to the next version of fastai


To learn more about the library, read our introduction in the [paper](https://arxiv.org/abs/2002.04688) presenting it.

## Installing

### Normal installation

You can get all the necessary dependencies by simply installing fastai v1: `conda install -c fastai -c pytorch fastai`. Or alternatively you can automatically install the dependencies into a new environment:

```bash
git clone https://github.com/fastai/fastai2
cd fastai2
conda env create -f environment.yml
source activate fastai2
```

Then, you can install fastai v2 with pip: `pip install fastai2`. 

Or you can use an editable install (which is probably the best approach at the moment, since fastai v2 is under heavy development):
``` 
git clone https://github.com/fastai/fastai2
cd fastai2
pip install -e ".[dev]"
``` 
You should also use an editable install of [`fastcore`](https://github.com/fastai/fastcore) to go with it.

If you want to browse the notebooks and build the library from them you will need nbdev:
``` 
pip install nbdev
``` 

To use `fastai2.medical.imaging` you'll also need to:

```bash
conda install pyarrow
pip install pydicom kornia opencv-python scikit-image
```

### Docker

If you have docker>=19.03 set up (see [here](https://github.com/NVIDIA/nvidia-docker/wiki) for installing it with GPU support) you can use fastai2 without installing anything:

#### Running jupyter lab

The first time you need to run:
```bash
docker run --name fastai2 --gpus all -p 8890:8890 giacomov/fastai2 jupyter lab --ip='*' --port 8890 --no-browser
```

After a few seconds you will see something like:

```
The Jupyter Notebook is running at:
http://fe4c6f41277b:8890/?token=6aac41e796bae49489abf941d277f668d384b429210bedbe
 or http://127.0.0.1:8890/?token=6aac41e796bae49489abf941d277f668d384b429210bedbe
```
Copy paste the latest url (starting with `http://127.0.0.1`) into your browser and enjoy fastai!

From Jupyter Lab you can also open a terminal in the container, if you need a command line.

Use Ctrl-C in the same terminal where you started the container to stop it. Your file will be kept in the container.

The next time you can simply do:

```
docker start -i fastai2
```

to resume where you stopped.

#### Where are my files

Everything you create in the container stays in the container, until you remove the container with `docker rm fastai2`. If you want to export
your files to the host you can use the command `docker cp`. You can also mount directories in the container, see the docker documentation for
that.

## Tests

To run the tests in parallel, launch:

```bash
nbdev_test_nbs
```
or 
```bash
make test
```

## Contributing

After you clone this repository, please run `nbdev_install_git_hooks` in your terminal. This sets up git hooks, which clean up the notebooks to remove the extraneous stuff stored in the notebooks (e.g. which cells you ran) which causes unnecessary merge conflicts.

Before submitting a PR, check that the local library and notebooks match. The script `nbdev_diff_nbs` can let you know if there is a difference between the local library and the notebooks.
* If you made a change to the notebooks in one of the exported cells, you can export it to the library with `nbdev_build_lib` or `make fastai2`.
* If you made a change to the library, you can export it back to the notebooks with `nbdev_update_lib`.
