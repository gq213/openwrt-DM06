-- Copyright 2009 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

local fs   = require "nixio.fs"
local nw   = require "luci.model.network"
local fw   = require "luci.model.firewall"
local uci  = require "luci.model.uci".cursor()
local http = require "luci.http"

local iw = luci.sys.wifi.getiwinfo(http.formvalue("device"))

local has_firewall = fs.access("/etc/config/firewall")

if not iw then
	luci.http.redirect(luci.dispatcher.build_url("admin/network/wireless"))
	return
end

m = SimpleForm("network", translatef("Join In \"%s\"", http.formvalue("join")), translate("<em>Warning: Input passphrase only, Don't change others. After Submit, Please Reboot!!!</em>"))
m.cancel = translate("Back to scan results")
m.reset = false

function m.on_cancel()
	local dev = http.formvalue("device")
	http.redirect(luci.dispatcher.build_url(
		dev and "admin/network/wireless_join?device=" .. dev
			or "admin/network/wireless"
	))
end

fw.init(uci)

m.hidden = {
	device      = http.formvalue("device"),
	join        = http.formvalue("join"),
	channel     = http.formvalue("channel"),
	mode        = http.formvalue("mode"),
	bssid       = http.formvalue("bssid"),
	wep         = http.formvalue("wep"),
	wpa_suites	= http.formvalue("wpa_suites"),
	wpa_version = http.formvalue("wpa_version")
}

if http.formvalue("wep") == "1" then
	key = m:field(Value, "key", translate("WEP passphrase"),
		translate("Specify the secret encryption key here."))

	key.password = true
	key.datatype = "wepkey"

elseif (tonumber(m.hidden.wpa_version) or 0) > 0 and
	(m.hidden.wpa_suites == "PSK" or m.hidden.wpa_suites == "PSK2")
then
	key = m:field(Value, "key", translate("WPA passphrase"),
		translate("Specify the secret encryption key here."))

	key.password = true
	key.datatype = "wpakey"
	--m.hidden.wpa_suite = (tonumber(http.formvalue("wpa_version")) or 0) >= 2 and "psk2" or "psk"
end

newnet = m:field(Value, "_netname_new", translate("Name of the new network"),
	translate("The allowed characters are: <code>A-Z</code>, <code>a-z</code>, " ..
		"<code>0-9</code> and <code>_</code>"
	))

newnet.default = m.hidden.mode == "Ad-Hoc" and "mesh" or "wwan"
newnet.datatype = "uciname"

if has_firewall then
	fwzone = m:field(Value, "_fwzone",
		translate("Create / Assign firewall-zone"),
		translate("Choose the firewall zone you want to assign to this interface. Select <em>unspecified</em> to remove the interface from the associated zone or fill out the <em>create</em> field to define a new zone and attach the interface to it."))

	fwzone.template = "cbi/firewall_zonelist"
	fwzone.default = m.hidden.mode == "Ad-Hoc" and "mesh" or "wan"
end

function newnet.parse(self, section)

	upap_ssid = m.hidden.join
	upap_encryption = (tonumber(m.hidden.wpa_version) or 0) >= 2 and "psk2" or "psk"
	upap_key = key and key:formvalue(section) or ""

	if upap_key ~= "" then
		uci:set("wireless", "sta", "ssid", upap_ssid)
		uci:set("wireless", "sta", "encryption", upap_encryption)
		uci:set("wireless", "sta", "key", upap_key)
		uci:set("wireless", "sta", "disabled", "0")
		uci:save("wireless")
		uci:commit("wireless")

		luci.sys.call("sh /etc/set_mode_sta_lan.sh >/dev/null 2>&1")
	end

	luci.http.redirect(luci.dispatcher.build_url("admin/network/wireless"))	

end

return m
