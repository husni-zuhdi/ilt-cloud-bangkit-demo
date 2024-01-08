# Employee Retention Prediction Machine Learning Model with Tensorflow

Develop a simple Machine Learning Model to predict Employee Retention with Tensorflow
**Use it as reference only!**

## Stacks
* [Python 3.11 with (Mini) Conda](https://docs.conda.io/projects/miniconda/en/latest/)
* [Tensorflow 2.15](https://www.tensorflow.org/)
* [Taskfile](https://taskfile.dev/)

## Development Step
1. Create conda environment with taskfile command
```
task conda-create
```
2. Activate the new created conda environment
```
conda activate <env_name |default: 1-ml-model>
```
3. Install conda requirements first then pip environments (Must in this sequence![2](https://www.anaconda.com/blog/using-pip-in-a-conda-environment))
```
task conda-install
task pip-install
```
4. Start Jupyter Notebook
```
jupyter notebook
```

## Misc

* If you encounter error below, run `sudo apt install python3-tk`
```
ModuleNotFoundError: No module named 'tkinter'
```

## References : 
[1] https://www.digitalocean.com/community/tutorials/how-to-build-a-deep-learning-model-to-predict-employee-retention-using-keras-and-tensorflow

[1] https://www.anaconda.com/blog/using-pip-in-a-conda-environment

