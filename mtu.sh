for iface in $(ip -o link show | awk -F': ' '{print $2}'); do 
    sudo ip link set dev $iface mtu 1450; 
    if [[ -d /etc/netplan ]]; then 
        sudo sed -i "/mtu:/d" /etc/netplan/*.yaml && echo "    mtu: 1450" | sudo tee -a /etc/netplan/*.yaml && sudo netplan apply; 
    elif [[ -d /etc/sysconfig/network-scripts ]]; then 
        sudo sed -i '/MTU/d' /etc/sysconfig/network-scripts/ifcfg-$iface && echo "MTU=1450" | sudo tee -a /etc/sysconfig/network-scripts/ifcfg-$iface && sudo systemctl restart network; 
    elif [[ -f /etc/network/interfaces ]]; then 
        sudo sed -i "/mtu/d" /etc/network/interfaces && echo "mtu 1450" | sudo tee -a /etc/network/interfaces && sudo systemctl restart networking; 
    fi 
done
