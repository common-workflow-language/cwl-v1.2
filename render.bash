#!/usr/bin/env bash
if [[ -z "$WORKSPACE" ]] ; then
    WORKSPACE=$PWD/temp/
fi
mkdir -p $WORKSPACE
repo=https://github.com/common-workflow-language/cwl-website \
bn=$(basename $repo)
if [[ -d $bn ]] ; then
    (cd $bn && git fetch origin && git reset --hard origin/main)
else
    git clone $repo && pushd $bn; git checkout main ; git show --no-patch ; popd
fi
echo "- basename: Base.yml"  >> $WORKSPACE/cwl-website/site/v1.2-deps.yaml
echo "  class: File"  >> $WORKSPACE/cwl-website/site/v1.2-deps.yaml
echo "  location: ../v1.2/Base.yml" >> $WORKSPACE/cwl-website/site/v1.2-deps.yaml
cat $WORKSPACE/cwl-website/site/v1.2-deps.yaml
CURDIR=$PWD
pushd $WORKSPACE/cwl-website ; ln -s $CURDIR v1.2 ; popd
cp cwlsite-v1.2-only-job.yaml $WORKSPACE/cwl-website/site/
mkdir -p render
cwltool $@ --no-container --cache $WORKSPACE/cache --outdir $PWD/render --relax-path-checks $WORKSPACE/cwl-website/site/cwlsite.cwl $WORKSPACE/cwl-website/site/cwlsite-v1.2-only-job.yaml
