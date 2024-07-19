#!/bin/bash

sed -i 's/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=6.6/' target/linux/x86/Makefile
