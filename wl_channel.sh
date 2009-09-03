#!/bin/sh

#
# . ./wl_channel.sh
#

get_frequency_channel()
{
    INTERFACE=$1
    CHANNEL=$2

    iwlist $INTERFACE chan | grep ^[[:space:]][[:space:]]*Channel | sed 's/^[[:space:]][[:space:]]*Channel//g;s/GHz//g;s/[[:space:]]//g' | awk -F ":" 'BEGIN { OFS=":" } {channel_frequency_table[$1]=$2;} END {$C=channel; print channel_frequency_table[$C]}' channel=$CHANNEL
}

is_valid_channel()
{
    INTERFACE=$1
    CHANNEL=$2

    FREQUENCY=$(get_frequency_channel $1 $2)

    if [ "x$FREQUENCY" == "x" ]; then
        echo 0
    else
        echo 1
    fi
}

get_available_channels()
{
    INTERFACE=$1

    iwlist $INTERFACE chan | grep ^[[:space:]][[:space:]]*Channel | sed 's/^[[:space:]][[:space:]]*Channel//g;s/GHz//g;s/[[:space:]]//g' | awk -F ":" 'BEGIN { OFS=":" } {print $1;}'

}

loop_over_available_channels()
{
    INTERFACE=$1

    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    for i in $AVAIL_CHAN; do
        echo "->$i"
    done
}

w_interface()
{
    INTERFACE=$1
    INTERFACE_FILE=/tmp/$INTERFACE.tmp
    echo $INTERFACE > $INTERFACE_FILE
    W_INTERFACE=$(sed 's/ath/wifi/' $INTERFACE_FILE)
    rm -f $INTERFACE_FILE
    echo $W_INTERFACE
}

switch_to_width()
{
    INTERFACE=$1
    WIDTH=$2

    W_INTERFACE=$(w_interface $INTERFACE)

    echo "Adjusting channel width to ${WIDTH}MHz for interface $INTERFACE...($W_INTERFACE)"

    case $WIDTH in
        5)
            ifconfig $INTERFACE down
            echo 0x156d0002 > /proc/sys/dev/$W_INTERFACE/cwidth
            ifconfig $INTERFACE up
            ;;
        10)
            ifconfig $INTERFACE down
            echo 0x156d0001 > /proc/sys/dev/$W_INTERFACE/cwidth
            ifconfig $INTERFACE up
            ;;
        20)
            ifconfig $INTERFACE down
            echo 0x156d0000 > /proc/sys/dev/$W_INTERFACE/cwidth
            ifconfig $INTERFACE up
            ;;
        40)
            echo "Turbo mode unsupported"
            ;;
        *)
            echo "Wrong channel width"
            ;;
    esac

    current_width $INTERFACE
}

current_width()
{
    INTERFACE=$1

    W_INTERFACE=$(w_interface $INTERFACE)

    WIDTH=$(cat /proc/sys/dev/$W_INTERFACE/cwidth)

    case $WIDTH in
        2)
            echo "5"
            ;;
        1)
            echo "10"
            ;;
        0)
            echo "20"
            ;;
        *)
            echo "Wrong channel width"
            ;;
    esac
}

switch_to_channel()
{
    INTERFACE=$1
    CHANNEL=$2

    echo "Switching to channel $CHANNEL for interface $INTERFACE..."

    iwconfig $INTERFACE channel $CHANNEL

    current_channel $INTERFACE
}

current_channel()
{
    INTERFACE=$1

    CURRENT_CHANNEL=$(iwlist $INTERFACE channel | grep -i current.*frequency \
        | cut -f 2 -d'(' | cut -f 2 -d' ' | sed 's/)//')

    echo $CURRENT_CHANNEL
}

adjust_interface()
{
    INTERFACE=$1
    CHANNEL=$2
    WIDTH=$3

    #
    # Changing the width changes the list of available channels, so we
    # change the width and then try to move to the channel specified.
    #
    switch_to_width $INTERFACE $WIDTH
    switch_to_channel $INTERFACE $CHANNEL

    current_channel $INTERFACE
    current_width $INTERFACE
}

test_channel_width()
{
    INTERFACE=$1
    WIDTH=$2

    switch_to_width $INTERFACE $WIDTH
    CUR_WIDTH=$(current_width $INTERFACE)
    sleep 1

    echo "Looping over all available channels. (Channel width: $CUR_WIDTH)"
    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    echo "$AVAIL_CHAN"

    for i in $AVAIL_CHAN; do
        switch_to_channel $INTERFACE $i
        sleep 1
    done
}

test_5_channel_width()
{
    INTERFACE=$1

    switch_to_width $INTERFACE 5
    CUR_WIDTH=$(current_width $INTERFACE)
    sleep 1

    echo "Looping over all available channels. (Channel width: $CUR_WIDTH)"
    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    echo "$AVAIL_CHAN"

    for i in $AVAIL_CHAN; do
        switch_to_channel $INTERFACE $i
        sleep 1
    done
}

test_10_channel_width()
{
    INTERFACE=$1

    switch_to_width $INTERFACE 10
    CUR_WIDTH=$(current_width $INTERFACE)
    sleep 1

    echo "Looping over all available channels. (Channel width: $CUR_WIDTH)"
    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    echo "$AVAIL_CHAN"

    for i in $AVAIL_CHAN; do
        switch_to_channel $INTERFACE $i
        sleep 1
    done
}

test_20_channel_width()
{
    INTERFACE=$2

    switch_to_width $INTERFACE 20
    CUR_WIDTH=$(current_width $INTERFACE)
    sleep 1

    echo "Looping over all available channels. (Channel width: $CUR_WIDTH)"
    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    echo "$AVAIL_CHAN"

    for i in $AVAIL_CHAN; do
        switch_to_channel $INTERFACE $i
        sleep 1
    done
}

test_channel_widths()
{
    INTERFACE=$1

    CUR_WIDTH=$(current_width $INTERFACE)

    echo "Looping over all available channels. (Channel width: $CUR_WIDTH)"
    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    echo "$AVAIL_CHAN"

    for i in $AVAIL_CHAN; do
        #
        # Idea: try to use a handshake protocol at this point
        #
        # Just tell our pear that we want to change to channel $i and
        # wait until we get confirmation to go ahead. Hm. this is
        # racy, looks like a concensus problem.
        #
        # Try to write a server in C that receives a request to change
        # the channel? Or a server which synchronize? This looks like
        # a concesus problem, try a concensus algorithm!
        switch_to_channel $INTERFACE $i
        sleep 1
    done

    switch_to_width $INTERFACE 10
    CUR_WIDTH=$(current_width $INTERFACE)
    sleep 1

    echo "Looping over all available channels. (Channel width: $CUR_WIDTH)"
    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    echo "$AVAIL_CHAN"

    for i in $AVAIL_CHAN; do
        switch_to_channel $INTERFACE $i
        sleep 1
    done

    switch_to_width $INTERFACE 5
    CUR_WIDTH=$(current_width $INTERFACE)
    sleep 1

    echo "Looping over all available channels. (Channel width: $CUR_WIDTH)"
    AVAIL_CHAN=$(get_available_channels $INTERFACE)

    echo "$AVAIL_CHAN"

    for i in $AVAIL_CHAN; do
        switch_to_channel $INTERFACE $i
        sleep 1
    done
}

# . ./wl_channel.sh
# test_channel_widths ath0
# switch_to_width ath0 5
