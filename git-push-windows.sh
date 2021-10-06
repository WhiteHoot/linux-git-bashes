#!/bin/bash

#init config
dir=`cat config.txt`

PS3="Select the operation: "

select opt in Guide Clone Push Quit; do

  case $opt in
    Guide)
		echo -e "\n\nMake sure you have assigned your directory that contains\nall the cloned repsitories WITH FORWARD SLASH (ex: C:/User/Document)\nin config.txt file! Also make sure there are no subfolders!"
		echo -e "\n"
		;;
    Clone)
		read -p "Enter the git url: " url
		git clone "$url"
		echo -e "\n Done cloning!\n"
		;;
    Push)
      #Listing cloned repositories
		ls $dir
		echo -e "\nSelect the directory you want to push :"
		read directory

		echo -e "\nEnter the message :"
		read msg

		echo -e "\nResetting staged files"
		git reset

		#Git repository location
		cd $dir/$directory/

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

		echo -e "\nDone!\n"
		;;
    Quit)
		break
		;;
    *) 
      echo -e "\nInvalid option $REPLY\n"
      ;;
  esac
done


