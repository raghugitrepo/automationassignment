Api automation test using Robot Framework and request library.
Robot Framework supports for both Python 2 and python 3

Clone the repo once done.

Create config.py file which is same as config.py.dist and give the valid keys using below cmd

cp config.py.dist config.py 


Install python 2.7 version
Once installed you can simply run:

#pip install robotframework

Install robotframework-requests and it's dependencies via pip


pip install -U requests


pip install -U robotframework-requests

To run test cases: cd to plivo dir from terminal and run below cmd.

pybot -d results Tests/ 

for newer version of Robot Frameowrk 

robot -d results Tests/
