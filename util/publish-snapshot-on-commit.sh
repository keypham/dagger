# see https://coderwall.com/p/9b_lfq

set -eux

if [ "$TRAVIS_REPO_SLUG" == "google/dagger" ] && \
   [ "$TRAVIS_JDK_VERSION" == "$JDK_FOR_PUBLISHING" ] && \
   [ "$TRAVIS_PULL_REQUEST" == "false" ] && \
   [ "$TRAVIS_BRANCH" == "master" ]; then
  echo -e "Publishing maven snapshot...\n"

  bash $(dirname $0)/deploy-dagger.sh \
    "deploy:deploy-file" \
    "HEAD-SNAPSHOT" \
    "-DrepositoryId=sonatype-nexus-snapshots" \
    "-Durl=https://oss.sonatype.org/content/repositories/snapshots" \
    "--settings=$(dirname $0)/settings.xml"

  bash $(dirname $0)/deploy-hilt.sh \
    "deploy:deploy-file" \
    "HEAD-SNAPSHOT" \
    "-DrepositoryId=sonatype-nexus-snapshots" \
    "-Durl=https://oss.sonatype.org/content/repositories/snapshots" \
    "--settings=$(dirname $0)/settings.xml"

  echo -e "Published maven snapshot"
else
  echo -e "Not publishing snapshot for jdk=${TRAVIS_JDK_VERSION} and branch=${TRAVIS_BRANCH}"
fi
