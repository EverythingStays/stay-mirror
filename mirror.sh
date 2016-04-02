#! /bin/sh

# TODO
# Should exit if there is dependencies from npmjs but not in the package.json

set -e

NAME=$1
VERSION=$2

MODULE_FOLDER=./modules/

read -p "Have you created a fork that is available at git@github.com:EverythingStays/$NAME-stay.git? <y/N> " prompt
if [[ $prompt =~ [yY](es)* ]]
then
  mkdir -p $MODULE_FOLDER
  echo "Getting details about $NAME@$VERSION..."
  REPOSITORY=$(curl --silent https://registry.npmjs.org/$NAME | jq -r ".versions.\"$VERSION\".repository.url")
  DEPENDENCIES=$(curl --silent https://registry.npmjs.org/$NAME | jq -r ".versions.\"$VERSION\".dependencies")
  echo "Repository: $REPOSITORY"
  echo "Dependencies:"
  echo $DEPENDENCIES


  echo "Normalizing the repository URL $REPOSITORY"
  REPOSITORY=$(./normalize_url.js $REPOSITORY)

  echo "Cloning $REPOSITORY..."
  git clone "$REPOSITORY" "$MODULE_FOLDER$NAME-stay"

  cd "$MODULE_FOLDER$NAME"-stay
  TAG=$(git tag | grep -i $VERSION) # Why this? Because people sometimes do v0.4.4 and sometime 0.4.4
  COMMIT=$(git show-ref $TAG | cut -d ' ' -f 1)
  echo "Checking out version $COMMIT..."
  git checkout $COMMIT

  echo "Checking out new branch $TAG-stay..."
  git checkout -b $TAG-stay

  echo "Adding to IPFS..."
  HASH=$(ipfs add -r . | tail -n 1 | cut -d ' ' -f 2)

  echo "Tagging $TAG-stay-release | $TAG-$HASH"
  git tag -s -a "$TAG-stay-release" -m "$TAG-$HASH"

  echo "Adding remote..."
  git remote add stay-fork git@github.com:EverythingStays/$NAME-stay.git;

  echo "Pushing with tags..."
  git push stay-fork $TAG-stay --tags
else
  echo "Come back to me once you have forked the repository!"
fi
