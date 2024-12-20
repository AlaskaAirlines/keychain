#!/bin/sh
cd ../Framework;
jazzy --min-acl internal --module KeychainAccess --exclude="KeychainAccess/Extensions/Foundation/*","KeychainAccess/Extensions/Framework/Keychain/Keychain+Manager.swift";
rm -rf build;
cd docs;
cp -r * ../../Documentation
cd ..;
rm -rf docs;
