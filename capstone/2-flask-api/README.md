# Employee Retention Prediction backend API with Tensorflow, Flask, and Cloud Run

Create a simple Machine Learning API to predict Employee Retention
**Use it as reference only!**

## Stacks
* [Python 3.11 with (Mini) Conda](https://docs.conda.io/projects/miniconda/en/latest/)
* [Tensorflow 2.15](https://www.tensorflow.org/)
* [Flask 2.10](https://flask.palletsprojects.com/en/2.1.x/)
* [docker (compose)](https://www.docker.com/)

## Development Step
1. Create conda environment with taskfile command
```
task conda-create
```
2. Activate the new created conda environment
```
conda activate <env_name |default: 2-flask-api>
```
3. Install conda requirements first then pip environments (Must in this sequence![2](https://www.anaconda.com/blog/using-pip-in-a-conda-environment))
```
task conda-install
task pip-install
```
4. Create `.env` file in root folder with this specifications

| Variables             | Function                          | Example                                          |
| --------------------- |:--------------------------------: | ------------------------------------------------:|
| PORT                  | your_API_port                     | 8081                                             |
| MODEL_LAYER           | your_model_layer_path             | model/hdf5/v1/retention_prediction_model.json    |
| MODEL_WEIGHTS         | your_model_weights_path           | model/hdf5/v1/retention_prediction_weights.h5    |
| STANDARD_SCALER       | your_standard_scaler_path (opt)   | model/hdf5/v1/standard_scaler.pkl                |

5. Create new docker image
```
task docker-build
```
6. Run a new docker container
```
task docker-run
```
7. Test the API with Postman. Import postman collection and environment and start the testing.

## Production Step
⚠️  WIP
<!-- > 🚨 This still in development. Please jump to the second step -->
<!---->
<!-- 1. Run `export PROJECT_ID=$(gcloud config get-value project)` -->
<!-- 2. Run `export SA=retention-prediction` -->
<!-- 2. Run this to create `retention-prediction` service account -->
<!-- ``` -->
<!-- gcloud iam service-accounts create $SA \ -->
<!--     --description="retention-prediction SA" \ -->
<!--     --display-name="retention-prediction" -->
<!-- ``` -->
<!-- 3. Run this to bind service account with `Storage Admin` role -->
<!-- ``` -->
<!-- gcloud projects add-iam-policy-binding $PROJECT_ID \ -->
<!--     --member="serviceAccount:$SA@$PROJECT_ID.iam.gserviceaccount.com" \ -->
<!--     --role="roles/storage.admin" -->
<!-- ``` -->
<!-- 4. Run this to get service account key as `key.json` -->
<!-- ``` -->
<!-- gcloud iam service-accounts keys create key.json \ -->
<!--     --iam-account=$SA@$PROJECT_ID.iam.gserviceaccount.com -->
<!-- ``` -->
<!-- 5. Add `s` into the `.env` file -->
<!---->
<!-- | Variables                      | Function                  | Example       | -->
<!-- | ------------------------------ |:------------------------: | -------------:| -->
<!-- | GOOGLE_APPLICATION_CREDENTIALS | your_service_account_path | ./key.json    | -->
<!---->
<!-- 6. 🚨 Keep it secret okay. Don't push your service account key into the github! -->

<!-- #### ✅ Then we're ready to deploy our Cloud Run -->
<!---->
<!-- 1. Run `docker build -t gcr.io/$PROJECT_ID/retention-pred:v1.0 .` -->
<!-- 2. Run `gcloud auth configure-docker` and press `Y` -->
<!-- 3. Run `docker push gcr.io/$PROJECT_ID/retention-pred:v1.0` -->
<!-- 4. Run `gcloud run deploy --image gcr.io/$PROJECT_ID/retention-pred:v1.0 --platform managed` -->
<!-- 5. Check your GCP Console > Cloud Run -->

## Misc

* If you encounter error below, run `sudo apt install python3-tk`
```
ModuleNotFoundError: No module named 'tkinter'
```

## References : 

[1] https://www.digitalocean.com/community/tutorials/how-to-build-a-deep-learning-model-to-predict-employee-retention-using-keras-and-tensorflow

[2] https://cloud.google.com/run/docs/quickstarts/build-and-deploy/deploy-python-service
