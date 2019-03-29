#!/usr/bin/env bash

bundle exec jekyll build --incremental
bundle exec jekyll build --incremental
git checkout master
cp -r _site/* ./

