#!/usr/bin/env bash

pushd `dirname $0` > /dev/null
DIR=`pwd -P`
popd > /dev/null

UNAME_STR=`uname`

echo "Installing dependencies..."
if [[ "$UNAME_STR" == "Darwin" ]] && hash brew 2>/dev/null; then
	brew update && brew install python3 libftdi0 libffi autoconf bison gawk gnu-sed graphviz xdot mercurial
fi
if [[ "$UNAME_STR" == "Linux" ]] && hash apt-get 2>/dev/null; then
	sudo apt-get install -y pkg-config build-essential cmake bison autoconf flex gawk tcl-dev libffi-dev git mercurial python python3 python3-dev libfl-dev libboost-dev libboost-filesystem-dev libboost-thread-dev libboost-program-options-dev libboost-python-dev qt5-default libftdi-dev
  sudo apt-get install -y libreadline-dev clang graphviz xdot libftdi1-2 libftdi1-dev libftdipp1-3 libftdipp1-dev libudev-dev cmake
fi

echo "┌───────────────────┐"
echo "│  nextpnr_generic  │"
echo "└───────────────────┘"
$DIR/nextpnr_ecp5.sh

echo "┌─────────┐"
echo "│ apicula │"
echo "└─────────┘"
$DIR/apicula.sh

echo "┌───────┐"
echo "│ yosys │"
echo "└───────┘"
$DIR/yosys.sh

echo "┌──────────┐"
echo "│ iverilog │"
echo "└──────────┘"
$DIR/iverilog.sh

echo "┌───────────┐"
echo "│ verilator │"
echo "└───────────┘"
$DIR/verilator.sh

echo "┌───────────────────┐"
echo "│  openFPGALoader   │"
echo "└───────────────────┘"
$DIR/openFPGALoader.sh
