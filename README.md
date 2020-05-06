# このリポジトリの使い方

```
docker run \
  -e AWS_ACCESS_KEY_ID=#{個々人のAWSアクセスキー} \
  -e AWS_SECRET_ACCESS_KEY=${個々人のAWSシークレットアクセスキー} \
  -v $(pwd):/terraform \
  -w /terraform \
  -it \
  --entrypoint=ash \
  hashicorp/terraform:0.12.24
```
