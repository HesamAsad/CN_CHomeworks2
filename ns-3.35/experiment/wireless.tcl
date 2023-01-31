if { $argc != 2 } {
	puts "Enter error rate, bandwidth, and packet_size correctly!"
	abort()
}
set error_rate [lindex $argv 0]
set bandwidth [lindex $argv 1]Mb

# defining constants

set val(chan)           Channel/WirelessChannel    	;
set val(prop)           Propagation/TwoRayGround   	;
set val(netif)          Phy/WirelessPhy            	;
set val(mac)            Mac/802_11                 	;#MAC protocole
set val(ifq)            Queue/DropTail/PriQueue    	;
set val(ll)             LL                         	;
set val(ant)            Antenna/OmniAntenna        	;
set val(ifqlen)         50                         	;
set val(nn)             9                          	;
set val(rp)             AODV                       	;# routing protocol
set val(x)        		500							;
set val(y)        		500							;
set val(finish)         100                 		;
set ns [new Simulator]
set packet_size 100Kb


set throughput6 [open throughput6.tr w]
set throughput7 [open throughput7.tr w]
set throughput8 [open throughput8.tr w]
set throughput9 [open throughput9.tr w]
set throughput10 [open throughput10.tr w]


$ns use-newtrace
set name wireless
set tracefd [open $name.tr w]
set namfile [open $name.nam w]
$ns trace-all $tracefd
$ns namtrace-all-wireless $namfile $val(x) $val(y)


Mac/802_11 set dataRate_ $bandwidth.Mb
Mac/802_11 set RTSThreshold_    1

#Network topography
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)
set channel1 [new $val(chan)]

proc HandleErrorRate {} {
    global  error_rate
    set errorModel [new ErrorModel]
    $errorModel unit packet;
    $errorModel set rate_ $error_rate
    return $errorModel
}

# defining node
$ns node-config -adhocRouting $val(rp) \
			 	-llType $val(ll) \
			 	-macType $val(mac) \
			 	-ifqType $val(ifq) \
			 	-ifqLen $val(ifqlen) \
			 	-antType $val(ant) \
			 	-propType $val(prop) \
			 	-phyType $val(netif) \
			 	-topoInstance $topo \
			 	-agentTrace ON \
			 	-macTrace ON \
			 	-routerTrace ON \
			 	-movementTrace ON \
			 	-channel $channel1\
                -IncomingErrProc HandleErrorRate

#set sender nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
#balancer
set n5 [$ns node]	
#set receiver nodes
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]

# Nodes random motion
$n0 random-motion 0
$n1 random-motion 0
$n2 random-motion 0
$n3 random-motion 0
$n4 random-motion 0
$n5 random-motion 0
$n6 random-motion 0
$n7 random-motion 0
$n8 random-motion 0
$n9 random-motion 0
$n10 random-motion 0

# Nodes size
$ns initial_node_pos $n0 20
$ns initial_node_pos $n1 20
$ns initial_node_pos $n2 20
$ns initial_node_pos $n3 20
$ns initial_node_pos $n4 20
$ns initial_node_pos $n5 20
$ns initial_node_pos $n6 20
$ns initial_node_pos $n7 20
$ns initial_node_pos $n8 20
$ns initial_node_pos $n9 20
$ns initial_node_pos $n10 20

#Nodes locations
$n0 set X_ 50.0
$n0 set Y_ 530.0
$n0 set Z_ 0.0
$n1 set X_ 50.0
$n1 set Y_ 430.0
$n1 set Z_ 0.0
$n2 set X_ 50.0
$n2 set Y_ 330.0
$n2 set Z_ 0.0
$n3 set X_ 50.0
$n3 set Y_ 230.0
$n3 set Z_ 0.0
$n4 set X_ 50.0
$n4 set Y_ 130.0
$n4 set Z_ 0.0

$n5 set X_ 100.0
$n5 set Y_ 335.0
$n5 set Z_ 0.0

$n6 set X_ 150.0
$n6 set Y_ 540.0
$n6 set Z_ 0.0
$n7 set X_ 150.0
$n7 set Y_ 440.0
$n7 set Z_ 0.0
$n8 set X_ 150.0
$n8 set Y_ 340.0
$n8 set Z_ 0.0
$n9 set X_ 150.0
$n9 set Y_ 240.0
$n9 set Z_ 0.0
$n10 set X_ 150.0
$n10 set Y_ 140.0
$n10 set Z_ 0.0

#TCP connections
set udp0_5 [new Agent/UDP]
set udp1_5 [new Agent/UDP]
set udp2_5 [new Agent/UDP]
set udp3_5 [new Agent/UDP]
set udp4_5 [new Agent/UDP]

set balancer0_5 [new Agent/Null]
set balancer1_5 [new Agent/Null]
set balancer2_5 [new Agent/Null]
set balancer3_5 [new Agent/Null]
set balancer4_5 [new Agent/Null]

$udp0_5 set packetSize_ $packet_size.Kb
$udp1_5 set packetSize_ $packet_size.Kb
$udp2_5 set packetSize_ $packet_size.Kb
$udp3_5 set packetSize_ $packet_size.Kb
$udp4_5 set packetSize_ $packet_size.Kb

$ns attach-agent $n0 $udp0_5
$ns attach-agent $n1 $udp1_5
$ns attach-agent $n2 $udp2_5
$ns attach-agent $n3 $udp3_5
$ns attach-agent $n4 $udp4_5
$ns attach-agent $n5 $balancer0_5
$ns attach-agent $n5 $balancer1_5
$ns attach-agent $n5 $balancer2_5
$ns attach-agent $n5 $balancer3_5
$ns attach-agent $n5 $balancer4_5

$ns connect $udp0_5 $balancer0_5
$ns connect $udp1_5 $balancer1_5
$ns connect $udp2_5 $balancer2_5
$ns connect $udp3_5 $balancer3_5
$ns connect $udp4_5 $balancer4_5

set cbr0_5 [new Application/Traffic/CBR]
set cbr1_5 [new Application/Traffic/CBR]
set cbr2_5 [new Application/Traffic/CBR]
set cbr3_5 [new Application/Traffic/CBR]
set cbr4_5 [new Application/Traffic/CBR]

$cbr0_5 attach-agent $udp0_5
$cbr1_5 attach-agent $udp1_5
$cbr2_5 attach-agent $udp2_5
$cbr3_5 attach-agent $udp3_5
$cbr4_5 attach-agent $udp4_5

## UDP part
set tcp5_6 [new Agent/TCP]
set tcp5_7 [new Agent/TCP]
set tcp5_8 [new Agent/TCP]
set tcp5_9 [new Agent/TCP]
set tcp5_10 [new Agent/TCP]

set sink5_6 [new Agent/TCPSink]
set sink5_7 [new Agent/TCPSink]
set sink5_8 [new Agent/TCPSink]
set sink5_9 [new Agent/TCPSink]
set sink5_10 [new Agent/TCPSink]

$tcp5_6 set packetSize_ $packet_size.Kb
$tcp5_7 set packetSize_ $packet_size.Kb
$tcp5_8 set packetSize_ $packet_size.Kb
$tcp5_9 set packetSize_ $packet_size.Kb
$tcp5_10 set packetSize_ $packet_size.Kb

$ns attach-agent $n5 $tcp5_6
$ns attach-agent $n5 $tcp5_7
$ns attach-agent $n5 $tcp5_8
$ns attach-agent $n5 $tcp5_9
$ns attach-agent $n5 $tcp5_10

$ns attach-agent $n6 $sink5_6
$ns attach-agent $n7 $sink5_7
$ns attach-agent $n8 $sink5_8
$ns attach-agent $n8 $sink5_9
$ns attach-agent $n8 $sink5_10

$ns connect $tcp5_6 $sink5_6
$ns connect $tcp5_7 $sink5_7
$ns connect $tcp5_8 $sink5_8
$ns connect $tcp5_9 $sink5_9
$ns connect $tcp5_10 $sink5_10

set cbr5_6 [new Application/Traffic/CBR]
set cbr5_7 [new Application/Traffic/CBR]
set cbr5_8 [new Application/Traffic/CBR]
set cbr5_9 [new Application/Traffic/CBR]
set cbr5_10 [new Application/Traffic/CBR]

$cbr5_6 attach-agent $tcp5_6
$cbr5_7 attach-agent $tcp5_7
$cbr5_8 attach-agent $tcp5_8
$cbr5_9 attach-agent $tcp5_9
$cbr5_10 attach-agent $tcp5_10

$ns at 0 "initNetwork"
$ns at 0 "$cbr0_5 start"
$ns at 0 "$cbr1_5 start"
$ns at 0 "$cbr2_5 start"
$ns at 0 "$cbr3_5 start"
$ns at 0 "$cbr4_5 start"
$ns at 0 "$cbr5_6 start"
$ns at 0 "$cbr5_7 start"
$ns at 0 "$cbr5_8 start"
$ns at 0 "$cbr5_9 start"
$ns at 0 "$cbr5_10 start"

set time 1


proc initNetwork {} {
    global sink5_6 sink5_7 sink5_8 sink5_9 sink5_10 ns time
    #Initialize sinks
    $sink5_6 set bytes_ 0
    $sink5_7 set bytes_ 0
    $sink5_8 set bytes_ 0
    $sink5_9 set bytes_ 0
    $sink5_10 set bytes_ 0
    
    set currTime [$ns now]
    $ns at [expr $currTime+$time] "handleSink"
}

proc handleSink {} {
    global sink5_6 sink5_7 sink5_8 sink5_9 sink5_10
    global throughput6 throughput7 throughput8 throughput9 throughput10 time ns

    set link5_6 [$sink5_6 set bytes_]
    set link5_7 [$sink5_7 set bytes_]
    set link5_8 [$sink5_8 set bytes_]
    set link5_9 [$sink5_9 set bytes_]
    set link5_10 [$sink5_10 set bytes_]
    
    set currTime [$ns now]
    # The load on sink
    set load6 [expr ($link5_6*8)/$time]
    set load7 [expr ($link5_7*8)/$time]
    set load8 [expr ($link5_8*8)/$time]
    set load9 [expr ($link5_9*8)/$time]
    set load10 [expr ($link5_10*8)/$time]

    puts $throughput6 "$currTime [expr $load6]"
    puts $throughput7 "$currTime [expr $load7]"
    puts $throughput8 "$currTime [expr $load8]"
    puts $throughput9 "$currTime [expr $load9]"
    puts $throughput10 "$currTime [expr $load10]"
    
    $sink5_6 set bytes_ 0
    $sink5_7 set bytes_ 0
    $sink5_8 set bytes_ 0
    $sink5_9 set bytes_ 0
    $sink5_10 set bytes_ 0
    
    # Repeat the process till time = 100
    $ns at [expr $currTime+$time] "handleSink"
}

proc finish {} {
    global ns tracefd namfile throughput6 throughput7 throughput8 throughput9 throughput10
    $ns flush-trace

    close $namfile
    close $tracefd

    close $throughput6
    close $throughput7
    close $throughput8
    close $throughput9
    close $throughput10
    
    exit 0
}

$ns at $val(finish) "finish"

$ns run
