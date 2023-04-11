#### What is a Subdomain Takeover
A subdomain takeover occurs when an attacker gains control over a subdomain of a target domain. Typically, this happens when the subdomain has a canonical name (CNAME) in the Domain Name System (DNS), but no host is providing content for it. This can happen because either a virtual host hasn't been published yet or a virtual host has been removed. An attacker can take over that subdomain by providing their own virtual host and then hosting their own content for it.<sup>1</sup>Subdomain takeover is not limited to CNAME records. NS, MX and even A records (which are not subject to this post) are affected as well. This post deals primarily with CNAME records. However, use cases for NS and MX records are presented where needed.

### Attack Scenario
* Your company starts using a new service, eg an external Support Ticketing-service.<br />
* Your company points a subdomain to the Support Ticketing-service, eg support.your-domain.com<br />
* Your company stops using this service but does not remove the subdomain redirection pointing to the ticketing system.<br />
* Attacker signs up for the Service and claims the domain as theirs. No verification is done by the Service Provider, and the DNS-setup is already correctly setup.<br />
* Attacker can now build a complete clone of the real site, add a login form, redirect the user, steal credentials (e.g. admin accounts), cookies and/or * completely destroy business credibility for your company.

#### Impact of a Subdomain Takeover
The implications of the subdomain takeover can be pretty significant. Using a subdomain takeover, attackers can send phishing emails from the legitimate domain, perform cross-site scripting (XSS), or damage the reputation of the brand which is associated with the domain.
Three things that make this scenario dangerous<br />
* It’s SUPER easy. Sign up for a new account and claim the domain. Done.<br />
* It’s completely hidden. The Domain Owner won’t notice. The attacker won’t leave any traces for the Domain Owner. Good luck monitoring this in an IDS!<br />
* The Service Provider is unlikely to be able to fix this in a feasible way.<br />

#### Mitigation
The mitigation strategies for domain names already vulnerable to subdomain takeover are rather straightforward:
Remove the affected DNS record — The simplest solution is to remove the affected record from the DNS zone. This step is usually used if the organization concludes that the affected source domain name is no longer needed.
Claim the domain name — This means registering the resource in particular cloud provider or a case of a regular Internet domain, repurchasing the expired domain. To prevent subdomain takeover in the future, organizations should change the process of creating and destructing resources in their infrastructure. In case of resource creation, the DNS record creation has to be the last step of this process. This condition prevents DNS record to be pointing to a non-existing domain at any point in time.

#### Attack techniques
Using Subjack<sup>3</sup><br />
``` subjack -w (subdomain.txt) -t 100 -ss; -v -o subjack.txt ```<br />

Using nuclei template<sup>4</sup><br />
``` nuclei -l /path to subdomain list.txt -T path to nuclei takeover folder -o takeover.txt ```

### Using Dig
```
1. Grab all subdomains of the target using subfinder: sudo subfinder -d domain.com --all -o subfinder.txt 
2. Run : cat domains.txt | while read domain;do dig  $domain;done | tee -a digs.txt
3. Grab all the CNAME Entries i.e, cat digs.txt | grep CNAME
4. Find a domain that is pointed to third party domain like sub.exampple.com CNAME x.aws.com
5. Check wheather the main subdomain is down
6. Go to host provider where the domain is pointed to and register that domain if you registered congrats you have takeover the subdomain.
```

#### References
1. https://developer.mozilla.org/en-US/docs/Web/Security/Subdomain_takeovers<br />
2. https://0xpatrik.com/subdomain-takeover-basics/<br />
3. https://labs.detectify.com/2014/10/21/hostile-subdomain-takeover-using-herokugithubdesk-more/<br />
4. https://github.com/projectdiscovery/nuclei-templates/tree/main/takeovers<br />

#### Things to do/learn
I would like to add a Subdomain to my webpage to better understand the process at the application level.
Also would like to learn if there is more of a manual way of finding possible take overs not using tools. 
