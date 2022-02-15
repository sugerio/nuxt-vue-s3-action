#Install dependencies
echo "Installing dependencies"
npm install > /dev/null 2>&1

#Build application
echo "Building application"
#Execute the command provided
`echo $BUILD_VUE_COMMAND` 

#Sync files with amazon s3 bucket app
aws --region $AWS_DEFAULT_REGION s3 sync ./dist s3://$AWS_BUCKET_NAME_FOR_WEB --no-progress --delete
echo "Successfully sync dist files to s3 bucket for vue hosting:" $AWS_BUCKET_NAME_FOR_WEB

mkdir -p dist_zip
RELEASE_ZIP=$RELEASE_TAG.zip
echo "Packaging zip to:" $RELEASE_ZIP
cd dist
zip ../dist_zip/$RELEASE_ZIP *
echo "Successfully created $RELEASE_ZIP"

# Upload to s3 artifact bucket.
echo "Upload zip file to bucket" $AWS_BUCKET_NAME_FOR_ARTIFACT 
S3_RELEASE_ZIP=s3://$AWS_BUCKET_NAME_FOR_ARTIFACT/$AWS_BUCKET_KEY_PREFIX/$RELEASE_ZIP
aws --region $AWS_DEFAULT_REGION s3 cp ../dist_zip/$RELEASE_ZIP $S3_RELEASE_ZIP --no-progress
echo "Successfully uploaded zip to $S3_RELEASE_ZIP"

# Clean
cd ../
rm -rf dist_zip/
rm -rf dist/
rm -rf node_modules/
echo "Successfully remove the dist_zip folder"