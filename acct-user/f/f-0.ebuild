# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="f"

ACCT_USER_ID=1000
ACCT_USER_GROUPS=( f users wheel audio video input plugdev pipewire usb tty rtkit )
ACCT_USER_HOME=/home/f
ACCT_USER_SHELL=/bin/bash
ACCT_USER_ENFORCE_ID=1
ACCT_USER_NO_MODIFY=1

acct-user_add_deps

