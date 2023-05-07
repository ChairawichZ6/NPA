sh shell function

function pingall(){
	for x in 192.168.1.1 10.6.100.1 10.6.200.1 10.6.100.100 10.6.200.2 10.6.99.2 10.21.100.100
        do ping $x
    done
} 
