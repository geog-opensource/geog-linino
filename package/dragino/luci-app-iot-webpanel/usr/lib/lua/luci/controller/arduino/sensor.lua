--[[
    Copyright (C) 2014 Dragino Technology Co., Limited

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
]]--

module("luci.controller.arduino.sensor", package.seeall)

local util = require("luci.util")
local ix = util.exec("LANG=en ifconfig wlan0")
local mac = ix and ix:match("HWaddr ([^%s]+)")
mac = string.gsub(mac,":","")

local server_t = { cumulocity={has_tenant=1,has_user=1,has_api=1,has_pass=1,has_gid=1}
			}

function index()
	entry({ "webpanel" , "sensor"}, call("config") ,nil)
end


local function not_nil_or_empty(value)
  return value and value ~= ""
end

local function config_get()
  local uci = luci.model.uci.cursor()

  uci:load("iot")
  local devicename = uci:get_first("iot","settings","DeviceName") or "DRAGINO-"..mac

  local ctx = {
	server_t = server_t,
	server = uci:get_first("iot","settings","server"),
	tenant = uci:get_first("iot","settings","tenant"),
	user = uci:get_first("iot","settings","user"),
	pass = uci:get_first("iot","settings","pass"),
	apikey = uci:get_first("iot","settings","ApiKey"),
	devicename = devicename,
	globalid = uci:get_first("iot","settings","GlobalID"),
  }

  luci.template.render("dragino/sensor", ctx)
end

local function config_post()
  local uci = luci.model.uci.cursor()
  uci:load("iot")

  if luci.http.formvalue("server") then
    uci:set("iot", "general", "server", luci.http.formvalue("server"))
  end
  if luci.http.formvalue("tenant") then
    uci:set("iot", "general", "tenant", luci.http.formvalue("tenant"))
  end
  if luci.http.formvalue("user") then
    uci:set("iot", "general", "user", luci.http.formvalue("user"))
  end
  if luci.http.formvalue("pass") then
    uci:set("iot", "general", "pass", luci.http.formvalue("pass"))
  end
  if luci.http.formvalue("apikey") then
    uci:set("iot", "general", "ApiKey", luci.http.formvalue("apikey"))
  end

  local dn = luci.http.formvalue("devicename")
  devicename = not_nil_or_empty(dn) and dn or 'DRAGINO-'..mac
  uci:set("iot", "general", "DeviceName", devicename)



  uci:commit("iot")
  luci.util.exec("/usr/bin/reset-mcu")

  config_get()
end

function config()
  if luci.http.getenv("REQUEST_METHOD") == "POST" then
    config_post()
  else
    config_get()
  end
end