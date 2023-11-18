#!/bin/bash

# Set the terminal type to avoid issues with escape sequences
set timeout 240

# Check the number of arguments
if {$argc != 3} {
    puts "Usage: $argv0 <cpus> <ram-in-MB> <hard-disk-in-GB>"
    exit 1
}

# Assign arguments to variables
set cpus [lindex $argv 0]
set memory [lindex $argv 1]
set hard_disk [lindex $argv 2]
set iso_file [lindex [glob alpine-virt-*-x86_64.iso] 0]

# Start build QEMU image
exec qemu-img create -f qcow2 alpine.img ${hard_disk}G

# Start the QEMU process
spawn qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpus -cpu qemu64 \
  -drive if=pflash,format=raw,read-only=on,file=$env(PREFIX)/share/qemu/edk2-x86_64-code.fd \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -cdrom $iso_file \
  -nographic alpine.img

# Wait for the login prompt
expect {
    "login:" {
        send "root\r"
        send "\b\r"
        send "\b\r"
        send "\b\r"
        send "\b\r"
        sleep 1
        send "clear\r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1

        # UP INTERNET
        send "setup-interfaces -a\r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "ifup eth0\r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "echo 'nameserver 1.1.1.1' > /etc/resolv.conf \r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1

        # Setup Alpine with answerfile
        send "wget -O answerfile https://raw.githubusercontent.com/heo001997/docker-on-phone/main/answerfile \r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "clear\r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "setup-alpine -f answerfile\r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1

        exp_continue
    }
    # Wait for input setup alpine - all default except erase
    # Password
    "New password:" {
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "\r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "\r"
        exp_continue
    }
    # New user
    "Setup a user?" {
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "\r"
        send "\b\r"
send "\b\r"
send "\b\r"
send "\b\r"
sleep 1
        send "\r"
        exp_continue
    }
    # Erase disk(s)
    "Erase the above disk(s) and continue? (y/n) " {
        sleep 10
        send "y"
        sleep 3
        send "\r"

        exp_continue
    }
    # Poweroff after finish installation
    "Installation is complete. Please reboot." {
        sleep 3
        # Send enough backspaces to clear the longest possible line
        send "\b\r"
        send "\b\r"
        send "\b\r"
        sleep 3
        send "poweroff\r"
        sleep 3
        interact
    }
    timeout {
        puts "Login prompt not received within 240 seconds."
        exit 1
    }
}