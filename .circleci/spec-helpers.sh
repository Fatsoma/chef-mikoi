#!/bin/bash

set -ex

target_revision=${CI_SPEC_HELPERS_REVISION:-HEAD}

checkout_branch=ci-deploy
repo=v2-spec-helpers
checkout_path="${HOME}/${repo}"

if [ -d "${checkout_path}" ] ; then
  (
    cd "${checkout_path}"
    git fetch origin && git fetch origin --tags && git reset --hard
  )
else
  git clone "git@github.com:Fatsoma/${repo}.git" "${checkout_path}"
fi

(
  cd "${checkout_path}"
  head=$(git rev-parse --abbrev-ref HEAD)
  if [ "${head}" != "${checkout_branch}" ]; then
    git branch -f "${checkout_branch}" && git checkout "${checkout_branch}"
  fi
  git reset --hard origin/"${target_revision}"
)
