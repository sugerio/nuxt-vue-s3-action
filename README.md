# nuxt-vue-s3-action
Github action for build Nuxt Vue single page app, deploy it to Amazon s3 bucket and save version.zip on the artifact bucket


#Example:
```
name: Build, Deploy, Zip & Upload to s3 bucket

on:
  push:
    branches:
      - 'main'

jobs:
  build:
    # runs-on: ubuntu-latest
    runs-on: [self-hosted, linux, x64]
    steps:
    - uses: actions/checkout@master
    - name: Build, zip & upload to s3 bucket
      uses: sugerio/nuxt-vue-s3-action@main
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEFAULT_REGION: us-west-2
        AWS_BUCKET_NAME_FOR_WEB: web-s3-bucket-name
        AWS_BUCKET_NAME_FOR_ARTIFACT: artifact-s3-bucket-name
        AWS_BUCKET_KEY_PREFIX: console-ui
        BUILD_VUE_COMMAND: "npm run generate"
        RELEASE_TAG: v1.1.0
```