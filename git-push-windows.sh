#!/bin/bash

echo -e "Enter the folder that contains all the cloned repositories :\n(DO NOT MAKE SUBFOLDERS! ONE FOLDER SHOULD CONTAIN ALL THE REPOSITORIES WITHOUT SUBFOLDERS!)"
read dir;
conv_dir = "${dir//\\//}"


#Listing cloned repositories
ls conv_dir
echo -e "\nSelect the directory you want to push :"
read directory

echo -e "\nEnter the message :"
read msg

echo -e "\nResetting staged files"
git reset

#Git repository location
cd "${conv_dir}/$directory/"

echo -e "\nDo you want to create new branch ? (y/n)"
read ans

if [[ "$ans" == "y" ]]; then
    echo -e "\nEnter the name of the branch :"
    read branch
    git checkout -b "$branch"
    git add .
    git commit -m "$msg using WhiteHoot's git-push automation script."
    git push -f origin "$branch"
else
    echo -e "\nEnter the name of the branch :"
    read branch
    git checkout "$branch"
    git add .
    git commit -m "$msg using WhiteHoot's git-push automation script."
    git push -f origin "$branch"
fi

echo -e "\nCache your credentials ? (y/n)"
read ans
if [[ "$ans" == "y" ]]; then
    git config credential.helper store
    echo -e "\nSuccessfully cached your credentials!"
fi 

echo -e "\nDone!"