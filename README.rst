
LordMike's Automatic Setup Bot for Ubuntu-MATE
==============================================


( Guide is under construction :)


This project contains tools to install and setup all application as you like them to be.

Quick installation guide.

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


