-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Licensed to the public under the Apache License 2.0.

local nw = require "luci.model.network"
local uci  = require "luci.model.uci".cursor()

nw.init(uci)

arg[1] = arg[1] or ""
local wnet = nw:get_wifinet(arg[1])
local wdev = wnet and wnet:get_device()

-- redirect to overview page if network does not exist anymore (e.g. after a revert)
if not wnet or not wdev then
	luci.http.redirect(luci.dispatcher.build_url("admin/network/wireless"))
	return
end


local name
local mode
local warn
if wnet:get("ifname") == "ra0" then
	name = "AP Mode Setting"
	mode = "ap"
	warn = "<em>Warning: After Submit, Please Reboot!!!</em>"
else
	name = "STA Mode Setting"
	mode = "sta"
	warn = "<em>Warning: If you want join in new network, Please back to wireless overview, Then click \"Scan\"!!!</em>"
end

m = SimpleForm("wireless", name, warn)
m.cancel = translate("Back to wireless overview")
m.reset = false

if mode == "sta" then
	m.submit = false
end

function m.on_cancel()
	luci.http.redirect(luci.dispatcher.build_url("admin/network/wireless"))
end


new_ssid = m:field(Value, "ssid", translate("SSID"), "")
new_ssid.default = wnet:get("ssid")

new_encr = m:field(ListValue, "encryption", translate("Encryption"), "")
new_encr:value("psk", "WPA-PSK")
new_encr:value("psk2", "WPA2-PSK")
new_encr.default = wnet:get("encryption")

new_key = m:field(Value, "key", translate("Key"), "")
new_key.default = wnet:get("key")


function new_key.parse(self, section)

	ssid = new_ssid and new_ssid:formvalue(section) or ""
	encr = new_encr and new_encr:formvalue(section) or ""
	key = new_key and new_key:formvalue(section) or ""

	if ssid == "" or key == "" then
		return
	end

	wnet:set("ssid", ssid)
	wnet:set("key", key)
	wnet:set("encryption", encr)
	nw:save("wireless")
	nw:commit("wireless")

	luci.http.redirect(luci.dispatcher.build_url("admin/network/wireless"))	

end


return m
