# Resolve-DNSNameOverHTTP
PowerShell commandline interface to use DNS-over-HTTPS google API web service
dns lookup needed but DNS is blocked on your network ? easy peasy through a limited internet web access and PowerShell :-)

## install Resolve-DNSNameOverHTTP from PowerShell Gallery repository
You can easily install it from powershell gallery repository
https://www.powershellgallery.com/packages/Resolve-DNSNameOverHTTP/
using a simple powershell command and an internet access :-) 
```
	Install-Module -Name Resolve-DNSNameOverHTTP
```
## import module from PowerShell 
```	
	.EXAMPLE
	C:\PS> import-module Resolve-DNSNameOverHTTP.psd1
  
```
## module content
###  Resolve-DNSNameOverHTTP function
 ```
 	.SYNOPSIS 
	Get dns information from google dns web service. more info : https://developers.google.com/speed/public-dns/docs/dns-over-https

	.DESCRIPTION
	Get dns information from google dns web service. more info : https://developers.google.com/speed/public-dns/docs/dns-over-https
	
	.PARAMETER name
	-name string{domain name or fqdn}
	
	.PARAMETER searchtype
	-searchtype string{'A','AAAA','CNAME','MX','ANY'}
	set your record type to search.

    .PARAMETER DNSSEC
    -DNSSEC SWITCH
     enable DNSSEC
    
    .PARAMETER EDNSClientSubnet
	-EDNSClientSubnet string{network subnet in CIDR format}
	set the EDNS Client Subnet.
	
	.OUTPUTS
    TypeName: System.Management.Automation.PSCustomObject
        Name                MemberType   Definition
        ----                ----------   ----------
        Equals              Method       bool Equals(System.Object obj)
        GetHashCode         Method       int GetHashCode()
        GetType             Method       type GetType()
        ToString            Method       string ToString()
        AD                  NoteProperty bool AD=False
        Additional          NoteProperty Object[] Additional=System.Object[]
        Answer              NoteProperty Object[] Answer=System.Object[]
        CD                  NoteProperty bool CD=False
        cli-Request_Date    NoteProperty datetime cli-Request_Date=09/02/2018 22:20:29
        cli-Request_Padding NoteProperty System.String cli-Request_Padding=e65f7a21-ef78-4394-b185-df4b1cb9ed58
        Comment             NoteProperty string Comment=Response from 157.56.81.41.
        edns_client_subnet  NoteProperty string edns_client_subnet=0.0.0.0/0
        Question            NoteProperty Object[] Question=System.Object[]
        RA                  NoteProperty bool RA=True
        RD                  NoteProperty bool RD=True
        Status              NoteProperty int Status=0
        TC                  NoteProperty bool TC=False
    
    Status              : 0
    TC                  : False
    RD                  : True
    RA                  : True
    AD                  : False
    CD                  : False
    Question            : {@{name=www.lucas-cueff.com.; type=1}}
    Answer              : {@{name=www.lucas-cueff.com.; type=1; TTL=3599; data=94.23.25.71}}
    Additional          : {}
    edns_client_subnet  : 0.0.0.0/0
    Comment             : Response from 207.46.15.59.
    cli-Request_Padding : 99e913d3-b4ea-430a-8bbc-86e069e251c4
    cli-Request_Date    : 09/02/2018 22:19:31

    .EXAMPLE
	Request info for lucas-cueff.com domain
    C:\PS> Resolve-DNSNameOverHTTP -name lucas-cueff.com -searchtype ANY

    .EXAMPLE
	Request info for lucas-cueff.com domain with DNSSEC option
    C:\PS> Resolve-DNSNameOverHTTP -name lucas-cueff.com -searchtype ANY -DNSSEC

    .EXAMPLE
	Request info for lucas-cueff.com domain with DNSSEC option
    C:\PS> Resolve-DNSNameOverHTTP -name lucas-cueff.com -searchtype ANY -DNSSEC

    .EXAMPLE
	Request info for lucas-cueff.com domain with DNSSEC option for source subnet 80.92.114.0/23
    C:\PS> Resolve-DNSNameOverHTTP -name lucas-cueff.com -searchtype ANY -DNSSEC -EDNSClientSubnet '80.92.114.0/23'
 ```
