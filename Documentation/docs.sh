#!/bin/sh
cd ../Framework;
jazzy --min-acl internal --module Keychain --exclude=Keychain/Extensions/Foundation*,Keychain/Extensions/Framework/Keychain/Keychain+Manager.swift;
rm -rf build;
cd docs;
cp -r * ../../Documentation
cd ..;
rm -rf docs;
