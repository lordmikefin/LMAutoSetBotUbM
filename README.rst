
LordMike's Automatic Setup Bot for Ubuntu-MATE
==============================================


( Guide is under construction :)


This project contains tools to install and setup all application as you like them to be.

Quick installation guide.
This will get needed stuff under directory ~/LM_ToyBox


Install guide
-------------

.. code-block:: bash

 mkdir ~/LM_ToyBox
 cd ~/LM_ToyBox
 
 wget https://github.com/lordmikefin/LMAutoSetBotUbM/releases/download/v0.0.2/LMAutoSetBotUbM-v0.0.2.zip
 unzip LMAutoSetBotUbM-v0.0.2.zip -d ~/LM_ToyBox/LMAutoSetBotUbM/
 
 cd ~/LM_ToyBox/LMAutoSetBotUbM/
 
 ./init.sh



Clone
-----

Cloning will get needed stuff under current folder.


Prepare for cloning
-------------------

Install Git

.. code-block:: bash

 sudo apt-get install git


Clone the project using HTTPS and run it
----------------------------------------

.. code-block:: bash

 git clone https://github.com/lordmikefin/LMAutoSetBotUbM.git
 
 cd LMAutoSetBotUbM/
 git submodule init
 git submodule update
 
 ./init.sh


Clone the project using SSH
---------------------------

.. code-block:: bash

 git clone git@github.com:lordmikefin/LMAutoSetBotUbM.git
 
 cd LMAutoSetBotUbM/
 git submodule init
 git submodule update
 
 # Set ssh urls for submodules
 cd submodule/LMToysBash
 
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/LMToysBash.git
 
 cd ../../python/setup_apps
 
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/setup_apps.git
 
 cd ../LMToyBoxPython
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/LMToyBoxPython.git
 
 cd ../app_source_handler
 git checkout master
 git remote -v
 git remote set-url origin git@github.com:lordmikefin/app_source_handler.git


Github action script
--------------------

zip package file is now auto created with Github action workflow script.

I have small project github-action-release_ where I have tested how to use Github actions.

.. _github-action-release: https://github.com/lordmikefin/github-action-release

