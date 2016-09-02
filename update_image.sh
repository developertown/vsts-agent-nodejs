#!/bin/bash

. ./REVISIONS

NEXT_IMAGE_REV=$(($IMAGE_REV + 1))
NEW_TAG=$UPSTREAM_AGENT_REV-$NEXT_IMAGE_REV


echo ""
echo "WARNING:"
echo "  Building and pushing :latest and :$NEW_TAG in 5 seconds (or ctrl-c-nope your way out):"
echo ""
for i in $(seq 5 1); do
  sleep 1
  echo $i
done

docker build -t developertown/vsts-agent-nodejs:latest . \
  && docker tag developertown/vsts-agent-nodejs:latest developertown/vsts-agent-nodejs:$NEW_TAG \
  && docker push developertown/vsts-agent-nodejs:latest \
  && docker push developertown/vsts-agent-nodejs:$NEW_TAG \
  && echo "export UPSTREAM_AGENT_REV=$UPSTREAM_AGENT_REV" > REVISIONS \
  && echo "export IMAGE_REV=$NEXT_IMAGE_REV" >> REVISIONS
