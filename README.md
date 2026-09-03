# MikroTik DHCP Recursive Failover

Simple **dual-WAN failover** script for MikroTik RouterOS using **recursive routing**.

## How It Works

### DHCP Gateway

The script gets the gateway from the DHCP Client on `ether1` and `ether2`:

```routeros
:local gateway1 [/ip dhcp-client get [find interface="ether1"] gateway]
:local gateway2 [/ip dhcp-client get [find interface="ether2"] gateway]
```

### Recursive Routes

The gateways are then used for **recursive routes**:

```text
8.8.8.8/32 → gateway1
1.1.1.1/32 → gateway2
```

### Default Routes

```text
0.0.0.0/0 → 8.8.8.8  distance 1  (Primary)
0.0.0.0/0 → 1.1.1.1  distance 2  (Backup)
```

`8.8.8.8` and `1.1.1.1` are used as **recursive targets** to check each WAN connection.

## Failover

If the **primary WAN** cannot reach `8.8.8.8`, the **distance 1** route becomes inactive and traffic switches to the **distance 2** route through `ether2`.

When the primary WAN is available again, traffic switches back automatically.

## Scope & Target Scope

The recursive routes use **`scope`** and **`target-scope`** so RouterOS can resolve the public IPs through their respective DHCP gateways.
