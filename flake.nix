{
  description = "My configuration with DNSCrypt Proxy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Use the unstable channel
    flake-utils.url = "github:numtide/flake-utils"; # Provides helper functions for flake definitions
  };


  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = system; };

    in {
     nixosConfigurations = {
     my-hostname = nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
      modules = [ ./configuration.nix ];
        configuration ={
        networking = {
            # If You use NetworkManager
            nameservers = [ "127.0.0.1" "::1" ];
            networkmanager.enable = true;
            networkmanager.dns = "none";
            # If you use DHCPCD uncomment This and comment the NetworkManager
            # dhcpcd.extraConfig = "nohook resolv.conf";
          };
          services.dnscrypt-proxy2 ={
          enable = true;
            settings = {
              ipv4_servers = true;
              ipv6_servers = true;
              require_dnssec = true;
              dnscrypt_servers = true;
              doh_servers = true;
              odoh_servers = true;
              require_nolog = true;
              require_nofilter = true;
              lb_strategy = "random";
              lb_estimator = true;
              dnscrypt_ephemeral_keys = true;
              ignore_system_dns = true;
              netprobe_address = "45.11.45.11:53";
              block_ipv6 = false;
              block_unqualified = true;
              block_undelegated = true;

              ##
              sources.public-resolvers = {
                urls = [
                  "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
                  "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
                ];
                cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
                minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
              };
              sources.relays = {
                urls = [
                  "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
                  "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
                ];
                cache_file = "/var/cache/dnscrypt-proxy/relays.md";
                minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
              };
              sources.odoh-servers = {
                urls = [
                  "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-servers.md"
                  "https://download.dnscrypt.info/resolvers-list/v3/odoh-servers.md"
                ];
                cache_file = "/var/lib/dnscrypt-proxy2/odoh-servers.md";
                minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
              };
              sources.odoh-relays = {
                urls = [
                  "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-relays.md"
                  "https://download.dnscrypt.info/resolvers-list/v3/odoh-relays.md"
                ];
                cache_file = "/var/lib/dnscrypt-proxy2/odoh-relays.md";
                minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
              };

              server_names = [
                "anon-cs-fr" "anon-bcn" "ams-dnscrypt-nl" "anon-meganerd" "anon-scaleway-ams" "d0wn-tz-ns1"
                "anon-arapurayil-in-ipv4" "anon-cs-rome" "dct-at1" "anon-cs-austria" "anon-techsaviours.org"
                "dct-nl1" "anon-meganerd" "anon-scaleway-ams" "dct-ru1" "anon-cs-czech" "anon-techsaviours.org"
                "dnscrypt.be" "anon-cs-belgium" "anon-serbica" "dnscrypt.ca-1" "anon-cs-il" "anon-openinternet"
                "dnscrypt.ca-2" "anon-cs-il2" "anon-openinternet" "dnscrypt.pl" "anon-cs-poland"
                "anon-techsaviours.org" "dnscrypt.uk-ipv4" "anon-cs-london" "anon-scaleway"
                "dnswarden-uncensor-dc-swiss" "anon-cs-fr" "anon-kama" "meganerd" "anon-scaleway-ams"
                "anon-serbica" "openinternet" "anon-cs-sea" "anon-inconnu" "plan9dns-fl" "anon-cs-tx"
                "anon-inconnu" "plan9dns-mx" "anon-cs-tx" "anon-inconnu" "plan9dns-nj" "anon-cs-nyc1"
                "anon-inconnu" "pryv8boi" "anon-cs-dus1" "anon-techsaviours.org" "sby-limotelu"
                "anon-cs-sydney" "anon-saldns01-conoha-ipv4" "scaleway-ams" "anon-meganerd"
                "anon-serbica" "scaleway-fr" "anon-cs-fr" "anon-dnscrypt.uk-ipv4" "serbica"
                "anon-cs-nl" "anon-scaleway-ams" "techsaviours.org-dnscrypt" "anon-cs-berlin"
                "anon-dnswarden-swiss" "v.dnscrypt.uk-ipv4" "anon-cs-london" "anon-scaleway"
                "odohrelay-koki-ams" "odohrelay-crypto-sx" "odohrelay-surf" "odohrelay-koki-bcn"
                "odohrelay-ams" "odohrelay-ibksturm" "odohrelay-se"
              ];



              anonymized_dns = {
                skip_incompatible = true;
                direct_cert_fallback = false;
                routes = [
                  { server_name = "*"; via = [
                    "anon-cs-fr" "anon-bcn" "ams-dnscrypt-nl" "anon-meganerd" "anon-scaleway-ams" "d0wn-tz-ns1"
                    "anon-arapurayil-in-ipv4" "anon-cs-rome" "dct-at1" "anon-cs-austria" "anon-techsaviours.org"
                    "dct-nl1" "anon-meganerd" "anon-scaleway-ams" "dct-ru1" "anon-cs-czech" "anon-techsaviours.org"
                    "dnscrypt.be" "anon-cs-belgium" "anon-serbica" "dnscrypt.ca-1" "anon-cs-il" "anon-openinternet"
                    "dnscrypt.ca-2" "anon-cs-il2" "anon-openinternet" "dnscrypt.pl" "anon-cs-poland"
                    "anon-techsaviours.org" "dnscrypt.uk-ipv4" "anon-cs-london" "anon-scaleway"
                    "dnswarden-uncensor-dc-swiss" "anon-cs-fr" "anon-kama" "meganerd" "anon-scaleway-ams"
                    "anon-serbica" "openinternet" "anon-cs-sea" "anon-inconnu" "plan9dns-fl" "anon-cs-tx"
                    "anon-inconnu" "plan9dns-mx" "anon-cs-tx" "anon-inconnu" "plan9dns-nj" "anon-cs-nyc1"
                    "anon-inconnu" "pryv8boi" "anon-cs-dus1" "anon-techsaviours.org" "sby-limotelu"
                    "anon-cs-sydney" "anon-saldns01-conoha-ipv4" "scaleway-ams" "anon-meganerd"
                    "anon-serbica" "scaleway-fr" "anon-cs-fr" "anon-dnscrypt.uk-ipv4" "serbica"
                    "anon-cs-nl" "anon-scaleway-ams" "techsaviours.org-dnscrypt" "anon-cs-berlin"
                    "anon-dnswarden-swiss" "v.dnscrypt.uk-ipv4" "anon-cs-london" "anon-scaleway"
                    "odohrelay-koki-ams" "odohrelay-crypto-sx" "odohrelay-surf" "odohrelay-koki-bcn"
                    "odohrelay-ams" "odohrelay-ibksturm" "odohrelay-se"
                  ];
                }
                ];
            };

            systemd.services.dnscrypt-proxy2.serviceConfig = {
            StateDirectory = "dnscrypt-proxy";
            };
              ##Settings
              };
          };
        };
      };
     };


    } );
}
