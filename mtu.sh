#!/bin/bash

# مقدار MTU جدید
NEW_MTU=1400

# دریافت لیست تمامی اینترفیس‌های شبکه
interfaces=$(ls /sys/class/net)

# تغییر مقدار MTU برای هر اینترفیس
for iface in $interfaces; do
    # بررسی اینکه اینترفیس فعال است یا خیر
    if ip link show "$iface" > /dev/null 2>&1; then
        echo "Setting MTU for interface $iface to $NEW_MTU"
        sudo ip link set dev "$iface" mtu $NEW_MTU
    else
        echo "Interface $iface is not available. Skipping."
    fi
done

echo "All MTUs have been updated to $NEW_MTU."
