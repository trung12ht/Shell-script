#!/bin/bash
 
# Import the class definition file.
. hocsinh.sh
. upcasting.sh
. downcasting.sh

function main()
{
    # Create the vectors objects. (1)
    hocsinh "hocsinh1" "Nguyen_Van_Trung" 20 "KHMT-04"
 
    # Show it's properties. (2)
    nguoi "nguoi1" "Tran_Thi_H" 21 "12"

    # Call to it's methods.
    $hocsinh1_show
    $nguoi1_hello

    # upcasting
    echo "__________________"
    echo "before upcasting: "
    $hocsinh1_hello
    upcasting hocsinh nguoi "hocsinh1"
    echo "after upcasting: "
    $hocsinh1_hello

    # downcasting
    echo "__________________"
    echo "before downcasting: "
    $hocsinh1_hello
    downcasting nguoi hocsinh "hocsinh1"
    echo "after downcasting: "
    $hocsinh1_hello
}
 
main
