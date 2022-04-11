# pub_rds_tf

```bash
$  cd app/
# tfstate用のs3バケットを作成しておく
$ terraform init
```


```bash
# System Managerのパラメータストアに必要な情報を作成しておく
$ terraform apply \
-var=database_name=`aws ssm get-parameters --name "/dev/db/database_name" --region=us-west-1 --with-decryption | jq  -r ".Parameters[].Value"` \
-var=db_master_username=`aws ssm get-parameters --name "/dev/db/username" --region=us-west-1 --with-decryption | jq  -r ".Parameters[].Value"` \
-var=db_master_password=`aws ssm get-parameters --name "/dev/db/password" --region=us-west-1 --with-decryption | jq  -r ".Parameters[].Value"` \
--parallelism=30
```