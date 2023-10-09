#!/bin/sh

export $(xargs < ./.env)
export GCR_VERSION="$(git describe --tags | cut -d '/' -f2)"
export TF_VAR_project="$PROJECT_ID"
export TF_VAR_region="$REGION"
export TF_VAR_ilt_name="$ILT_NAME"
export TF_VAR_image="gcr.io/$PROJECT_ID/$ILT_NAME:$GCR_VERSION"
export TF_VAR_db_user="$DB_USER"
export TF_VAR_db_password="$DB_PASSWORD"
export TF_VAR_db_port="$DB_PORT"
export TF_VAR_db_name="$DB_NAME"
export TF_VAR_vpc_network_name="$VPC_NETWORK_NAME"
export TF_VAR_name_prefix="$CLOUDSQL_NAME_PREFIX"
export TF_VAR_master_user_name="$DB_USER"
export TF_VAR_master_user_password="$DB_PASSWORD"
export TF_VAR_svpc_access="$SVPC_NAME"
