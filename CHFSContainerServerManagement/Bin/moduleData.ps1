@{
    DockerOpenlocalports = @(
        @{name='Docker_Inbound';Protocol='tcp';localport=2375}
        @{name='Docker_Secure';Protocol='tcp';localport=2376}
        @{name='Docker_Swarm_Listen';Protocol='tcp';localport=2377}
        @{name='Docker_Swarm_InterCom-TCP';Protocol='tcp';localport=7946}
        @{name='Docker_Swarm_InterCom-UDP';Protocol='udp';localport=7946}
        @{name='Docker_Swarm_OverlayNetwork';Protocol='udp';localport=4789}
    )
    NewNetFirewallRule = @{
        Profile = @('Domain','Public','Private')
        Direction = 'Inbound'
        Action = 'Allow'
    }
}