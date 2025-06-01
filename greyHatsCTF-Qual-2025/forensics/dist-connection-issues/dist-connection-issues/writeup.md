# Connection Issues/forensics

## Challenge Description
*"One of our employees was browsing the web when he suddenly lost connection! Can you help him figure out why?"*

I was provided with a PCAP file containing network traffic from an employee's web browsing session that ended with a connection loss.

I began by searching the packet capture for the flag format "grey" but initially found only legitimate web traffic:

```http
HTTP/1.1 200 OK
Date: Tue, 06 May 2025 17:19:51 GMT
Server: Apache/2.4.58 (Ubuntu)
Last-Modified: Tue, 06 May 2025 15:53:32 GMT
ETag: "81-634799e5abfc4"
Accept-Ranges: bytes
Content-Length: 129
Vary: Accept-Encoding
Content-Type: text/html

<html>
  <head><title>Very Serious Website</title></head>
  <body><h1>Hope you're enjoying GreyCTF so far :D</h1></body>
</html>
```

This showed the employee was browsing a simple website before the connection was lost.

From the traffic patterns, I identified:
- **Employee's IP**: `192.168.100.10` (client browsing on port 80)
- **Server/Gateway IP**: `192.168.100.1` (web server)

Following TCP streams revealed normal HTTP traffic until the connection abruptly terminated.

Working backwards from the point of connection loss, I discovered suspicious ARP traffic with the message:
```
duplicate use of 192.168.100.1 detected!
```

## The Attack: ARP Poisoning

### What is ARP?
The Address Resolution Protocol (ARP) maps IP addresses to MAC addresses on local networks. When a device needs to communicate with an IP address, it broadcasts an ARP request asking "Who has [IP address]?" The legitimate device responds with its MAC address.

### ARP Poisoning Attack
ARP poisoning occurs when an attacker sends fraudulent ARP replies, associating their MAC address with a victim's IP address. This redirects traffic intended for the victim to the attacker instead, enabling man-in-the-middle attacks.

Examining the ARP packets claiming ownership of `192.168.100.1`, I noticed suspicious base64-encoded data in the packet bytes: `b24zZH0=`

Decoding this fragment with CyberChef revealed: `on3d}` - clearly part of a flag!

I filtered for all ARP packets from the attacking device and extracted the base64 strings from each packet's data section. Concatenating these fragments gave me:

```
Z3JleXtkMWRfMV9qdXM3X2dlN19wMDFzb24zZH0=
```

Decoding the complete base64 string revealed the flag:

**`grey{d1d_1_jus7_ge7_p01son3d}`**
