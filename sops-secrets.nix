{ config, pkgs, lib, ... }:
 
{
  sops.secrets."porkbun/apikey" = {
    sopsFile = ./secrets/porkbun_secrets.yaml;
  };

  sops.secrets."porkbun/secretapikey" = {
    sopsFile = ./secrets/porkbun_secrets.yaml;
  };

  sops.secrets.home_wifi = {
    sopsFile = ./secrets/home-wifi.env.enc;
    format = "dotenv";
  };

  sops.secrets."wifi/home-wifi/psk" = { 
    sopsFile = ./secrets/wifi_secrets.yaml;
  };
  
  sops.secrets."wifi/nano-wifi/psk" = { 
    sopsFile = ./secrets/wifi_secrets.yaml;
    # key = "wifi.nano-wifi.psk"; # this key entry on each thing was erroring out because, essentially, sops was trying to eval the key twice. Once with the top line [sops.secrets."" =] and once with the key = bit. so it's entirely unnecessary
  };
  
  sops.secrets."wifi/koshka-wifi/psk" = {
    sopsFile = ./secrets/wifi_secrets.yaml;
  };
}
