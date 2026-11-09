# cloud-cidr

Fetch the published public IP CIDR ranges for the major cloud providers: AWS, Azure, Google Cloud, IBM Cloud and Oracle Cloud. Useful for deciding whether an IP address belongs to a cloud provider — for example when triaging scanner traffic, filtering logs, or feeding asset-discovery tooling.

## Contents

| File | Description |
|---|---|
| `aws.sh` | Downloads AWS's published IP ranges JSON (`https://ip-ranges.amazonaws.com/ip-ranges.json`) and prints the IPv4 prefixes. |
| `azure.sh` | Resolves the current Azure Public IP ranges download link from Microsoft's download page and extracts the IPv4 CIDRs. |
| `gcloud.sh` | Walks Google Cloud's `_cloud-netblocks.googleusercontent.com` DNS TXT records to enumerate all Google netblocks. |
| `ibmcloud.sh` | Scrapes the IBM Cloud hardware firewall IP list and removes private/reserved ranges. |
| `oracle.sh` | Downloads Oracle Cloud's published IP ranges JSON (`https://docs.cloud.oracle.com/iaas/tools/public_ip_ranges.json`). |
| `all.sh` | Runs all of the above and writes a de-duplicated, sorted combined list to `all.txt`. |
| `azure.txt` | A snapshot of the Azure public IP ranges captured on 21 November 2019. |

## Usage

Run the scripts individually, e.g.:

```bash
./aws.sh
```

Or refresh the combined list of every provider:

```bash
./all.sh
```

Requirements: `curl`, `jq`, `dig` and `grep` (with PCRE support for the Azure/IBM scripts).

### Checking whether an IP is in a cloud range

Using `grepcidr`:

```bash
./aws.sh > aws.txt
grepcidr "$(cat aws.txt)" <<< "52.94.76.0" && echo "AWS IP" || echo "Not AWS"
```

### Feeding scanners

Write each provider's output to a file and pass the ranges to tools that accept a CIDR list, for example:

```bash
./aws.sh > aws.txt
nmap -iL <(expand_cidr aws.txt) -p 443   # or use naabu/masscan's range file support
```

## Data sources

- **AWS**: official `ip-ranges.amazonaws.com/ip-ranges.json`.
- **Azure**: Microsoft's public "Azure Datacenter IP Ranges" download (the XML snapshot in `azure.txt` dates from November 2019 — the script always fetches the current file).
- **Google Cloud**: DNS TXT records under `_cloud-netblocks.googleusercontent.com`, resolved recursively.
- **IBM Cloud**: the hardware-firewall published IP list on GitHub (`ibm-cloud-docs/hardware-firewall-dedicated`).
- **Oracle Cloud**: `docs.cloud.oracle.com/iaas/tools/public_ip_ranges.json`.

Note that cloud providers change their ranges frequently; re-run the scripts for up-to-date data rather than relying on the committed snapshot.

## Disclaimer / Authorised use

This repository is for authorised security testing and responsible disclosure only. Use it to understand and classify network traffic on systems you own or are explicitly permitted to test.

## Author

Robbie Wiggins — [What-Security](https://www.what-security.co.uk) · [GitHub](https://github.com/random-robbie)
