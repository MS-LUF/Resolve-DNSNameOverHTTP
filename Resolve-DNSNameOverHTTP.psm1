#
# Created by: lucas.cueff[at]lucas-cueff.com
#
# v0.1 : 
# - intial release
# - dns lookup needed but DNS is blocked on your network ? easy peasy through a limited internet web access and PowerShell :-)
# - PowerShell interface to DNS-over-HTTPS google API
# Released on: 02/2018
#
#'(c) 2018 lucas-cueff.com - Distributed under Artistic Licence 2.0 (https://opensource.org/licenses/artistic-license-2.0).'

<#
	.SYNOPSIS 
	powershell commandline interface to use DNS-over-HTTPS google API web service

	.DESCRIPTION
	Resolve-DNSNameOverHTTP.psm1 module provides a commandline interface toDNS-over-HTTPS google API
	
	.EXAMPLE
	C:\PS> import-module Resolve-DNSNameOverHTTP.psm1
#>

function Resolve-DNSNameOverHTTP {
 <#
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

#>
    [cmdletbinding()]
    Param (    
        [parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true,Mandatory=$true)]
            [String[]]$name,
        [parameter(Mandatory=$true)] 
            [ValidateSet('A','AAAA','CNAME','MX','ANY')]
            [String[]]$searchtype, 
        [parameter(Mandatory=$false)]
            [switch]$DNSSEC,
        [parameter(Mandatory=$false)]
        [ValidateScript({($_ -match "(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])") -or ($_ -match "s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?")})]
            [string[]]$EDNSClientSubnet
    )
    $DateRequest = get-date
    $padding = (new-guid).guid
    $baseurl = "https://dns.google.com/resolve?"
    If (!$EDNSClientSubnet) {
        $EDNSClientSubnet = "0.0.0.0/0"
    }
    If ($DNSSEC.IsPresent) {
        $cd = "true"
    } Else {
        $cd = "false"
    }
    $requesturl = "$($baseurl)name=$($name)&type=$($searchtype)&random_padding=$padding&edns_client_subnet=$($EDNSClientSubnet)&cd=$($cd)"
    try {
        $dnsresult = invoke-webrequest $requesturl
    } catch {
        if ($debug -or $verbose) {
            write-warning "Not able to use Google DNS online API service - KO"
            write-warning "Error Type: $($_.Exception.GetType().FullName)"
            write-warning "Error Message: $($_.Exception.Message)"
            write-warning "HTTP error code:$($_.Exception.Response.StatusCode.Value__)"
            write-warning "HTTP error message:$($_.Exception.Response.StatusDescription)"
        }
        $errorvalue = @()
        $errorvalue += [PSCustomObject]@{
             error = $_.Exception.Response.StatusCode.Value__
             'cli-error_results' = "$($_.Exception.Response.StatusDescription)"
             'cli-Request_Padding' = $padding
             'cli-Request_Date' = $DateRequest
         }
    }
    if (-not $errorvalue) {
        try {
            $temp = $dnsresult.Content | convertfrom-json
            $temp | add-member -MemberType NoteProperty -Name 'cli-Request_Padding' -Value $padding
            $temp | add-member -MemberType NoteProperty -Name 'cli-Request_Date' -Value $DateRequest
        } catch {
            if ($debug -or $verbose) {
                write-warning "unable to convert result into a powershell object - json error"
                write-warning "Error Type: $($_.Exception.GetType().FullName)"
                write-warning "Error Message: $($_.Exception.Message)"
            }
            $errorvalue = @()
            $errorvalue += [PSCustomObject]@{
                'cli-error_results' = "$($_.Exception.GetType().FullName) - $($_.Exception.Message) : $($dnsresult.Content)"
                'cli-Request_Padding' = $padding
                'cli-Request_Date' = $DateRequest
            }
        }
    }
    if ($temp) {return $temp}
    if ($errorvalue) {return $errorvalue}
}

Export-ModuleMember -Function Resolve-DNSNameOverHTTP
