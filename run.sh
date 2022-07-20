#!/bin/bash
if [[ -d "./unix_venv" ]]
then
    # check python3 existence in OS
    if [[ !(-e py_v.txt && -s py_v.txt) ]]
    then
        python3 --version > py_v.txt
        chmod 664 py_v.txt
    fi
    if [[ -e py_v.txt && -s py_v.txt ]]
    then # the file isn't empty => python3 exists in OS
        # then create python virtual environment:
        python3 -m venv unix_venv
        if [[ -d "./unix_venv" ]]
        then
            REQUIREMENTS=requirements.txt
            LOGS=~/network_scanner/internet_logs.txt
            activate(){
                . ./unix_venv/bin/activate
            }
            activate
            if [[ -f "$REQUIREMENTS" ]]
            then
                chmod 664 requirements.txt
                echo "Installing python libraries..."
                pip install -r requirements.txt
                if [[ -e test_connection.py ]]
                then
                    python3 test_connection.py
                else
                    echo "Error: There is no test_connection.py file!"
                    exit 2
                fi
                if [[ -f "$LOGS" ]]
                then
                    chmod 664 $LOGS
                    echo "If the speed of Internet connection less than 27 Mbit/s you will see logs here:"
                    cat $LOGS
                    if [[ -e py_v.txt ]]
                    then
                        rm py_v.txt
                    fi
                    echo "The pogram is finished"
                else
                    echo "There is no $LOGS!"
                    exit 3
                fi
            else
                echo "There is no $REQUIREMENTS"
                exit 4
            fi
        else
            echo "Error: Cannot create unix_venv/"
            exit 5
        fi
    else
        echo "Error: There is no python-3 in your system"
        exit 1
    fi
else
    # check python3 existence in OS
    if [[ !(-e py_v.txt && -s py_v.txt) ]]
    then
        python3 --version > py_v.txt
        chmod 664 py_v.txt
    fi
    if [[ -e py_v.txt && -s py_v.txt ]]
    then # the file isn't empty => python3 exists in OS
        # then create python virtual environment:
        python3 -m venv unix_venv
        if [[ -d "./unix_venv" ]]
        then
            REQUIREMENTS=requirements.txt
            LOGS=~/network_scanner/internet_logs.txt
            activate(){
                . ./unix_venv/bin/activate
            }
            activate
            if [[ -f "$REQUIREMENTS" ]]
            then
                chmod 664 requirements.txt
                echo "Installing python libraries..."
                pip install -r requirements.txt
                if [[ -e test_connection.py ]]
                then
                    python3 test_connection.py
                else
                    echo "Error: There is no test_connection.py file!"
                    exit 2
                fi
                if [[ -f "$LOGS" ]]
                then
                    chmod 664 $LOGS
                    echo "If the speed of Internet connection less than 27 Mbit/s you will see logs here:"
                    cat $LOGS
                    if [[ -e py_v.txt ]]
                    then
                        rm py_v.txt
                    fi
                    echo "The pogram is finished"
                else
                    echo "There is no $LOGS!"
                    exit 3
                fi
            else
                echo "There is no $REQUIREMENTS"
                exit 4
            fi
        else
            echo "Error: Cannot create unix_venv/"
            exit 5
        fi
    else
        echo "Error: There is no python-3 in your system"
        exit 1
    fi
fi