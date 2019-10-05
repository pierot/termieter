#/usr/bin/env sh

# Get password from OS X Keychain function
# Replace %ACCOUNT_NAME% with account name of Keychain item
# See `man security` for more info
get_key () {
  security 2>&1 >/dev/null find-generic-password -ga ${USER} -s "$1" \
    |ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

# Get the Zone ID from: https://www.cloudflare.com/a/overview/<your-domain>
DNS_ZONE=$(get_key "cloudflare-ddns-dns-zone")

# Get the existing identifier for DNS entry:
# https://api.cloudflare.com/#dns-records-for-a-zone-list-dns-records
IDENTIFIER=$(get_key "cloudflare-ddns-identifier")

# Get these from: https://www.cloudflare.com/a/account/my-account
AUTH_EMAIL=$(get_key "cloudflare-ddns-email")
AUTH_KEY=$(get_key "cloudflare-ddns-key")

# Desired domain name
DOMAIN_NAME="darius.jackjoe.be"

# Get previous IP address
_PREV_IP_FILE="/tmp/public-ip.txt"
_PREV_IP=$(cat $_PREV_IP_FILE &> /dev/null)

echo "1"
# Install `dig` via `dnsutils` for faster IP lookup.
command -v dig &> /dev/null && {
    _IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
} || {
    _IP=$(curl --silent https://api.ipify.org)
} || {
    exit 1
}

_IP=$(curl --silent https://api.ipify.org)

# If new/previous IPs match, no need for an update.
if [ "$_IP" = "$_PREV_IP" ]; then
    exit 0
fi
echo "3"

_UPDATE=$(cat <<EOF
{ "type": "A",
  "name": "$DOMAIN_NAME",
  "content": "$_IP",
  "ttl": 120,
  "proxied": false }
EOF
)

echo "Call cloudflare api"
curl "https://api.cloudflare.com/client/v4/zones/$DNS_ZONE/dns_records/$IDENTIFIER" \
     --silent \
     -X PUT \
     -H "Content-Type: application/json" \
     -H "X-Auth-Email: $AUTH_EMAIL" \
     -H "X-Auth-Key: $AUTH_KEY" \
     -d "$_UPDATE" > /tmp/cloudflare-ddns-update.json && \
     echo $_IP > $_PREV_IP_FILE
