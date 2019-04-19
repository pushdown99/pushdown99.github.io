--------------------------------------------------------------------------------------------------
--
-- lora.lua
--
-- written by Haeyeon, Hwang (hyhwang@mnlsolution.com)
--
--------------------------------------------------------------------------------------------------

local lora       	= Proto("lora", "LoRa")

local VALS_MTYPE = {
[0x0] = "Join-Request", 
[0x1] = "Join-Accept", 
[0x2] = "Unconfirmed Data Up", 
[0x3] = "Unconfirmed Data Down", 
[0x4] = "Confirmed Data Up", 
[0x5] = "Confirmed Data Down", 
[0x6] = "MFU", 
[0x7] = "Proprietary"
}

local pfVer      	= ProtoField.uint8("lora.Ver" ,   	"Protocol Version", 	     base.DEC )
local pfToken      	= ProtoField.bytes("lora.Token" ,   "Random Token", 		     base.HEX )
local pfId       	= ProtoField.bytes("lora.Id" ,      "identifier", 	             base.HEX )
local pfGwId       	= ProtoField.bytes("lora.GwId" ,   "Gateway unique identifier", base.HEX )
local pfJson       	= ProtoField.string("lora.Json" ,   "JSON object", FT_STRING )
local pfMType       = ProtoField.uint8("lora.MType" ,  "MType", base.HEX, VALS_MTYPE , 0xE0 )
local pfRFU         = ProtoField.uint8("lora.RFU" ,    "RFU", base.HEX, nil , 0x1C )
local pfMajor       = ProtoField.uint8("lora.Major" ,  "Major", base.HEX, nil , 0x03 )
local pfDevAddr     = ProtoField.bytes("lora.DevAddr" ,   "DevAddr", 		     base.HEX )
local pfFCtrl       = ProtoField.uint8("lora.FCtrl" ,   "FCtrl", 		     base.HEX )
local pfFCnt        = ProtoField.uint16("lora.FCnt" ,   "FCnt", 		     base.DEC )

local pfADR         = ProtoField.uint8("lora.ADR" ,"ADR", base.HEX, nil , 0x80 )
local pfRFU6        = ProtoField.uint8("lora.RFU6" ,"RFU", base.HEX, nil , 0x40 )
local pfADRACKReq   = ProtoField.uint8("lora.ADRACKReq" ,"ADRACKReq", base.HEX, nil , 0x40 )
local pfFACK        = ProtoField.uint8("lora.ACK" ,"ACK", base.HEX, nil , 0x20 )
local pfFPending    = ProtoField.uint8("lora.FPending" ,"FPending", base.HEX, nil , 0x10 )
local pfRFU4        = ProtoField.uint8("lora.RFU" ,"RFU", base.HEX, nil , 0x10 )
local pfFOptsLen    = ProtoField.uint8("lora.FOptsLen" ,"FOptsLen", base.DEC, nil , 0x0F )
local pfFOpts       = ProtoField.bytes("lora.FOpts" ,"FOpts", base.HEX)
local pfFPort       = ProtoField.bytes("lora.FPort" ,"FPort", base.HEX)
local pfFRMPayload  = ProtoField.bytes("lora.FRMPayload" ,"FRMPayload", base.HEX)
local pfMIC         = ProtoField.bytes("lora.MIC" ,"MIC", base.HEX)
local pfAppEUI      = ProtoField.bytes("lora.AppEUI" ,"AppEUI", base.HEX)
local pfDevEUI      = ProtoField.bytes("lora.DevEUI" ,"DevEUI", base.HEX)
local pfDevNonce    = ProtoField.bytes("lora.DevNonce" ,"DevNonce", base.HEX)

local pfAppNonce    = ProtoField.uint24("lora.AppNonce", "AppNonce", base.HEX)
local pfNetID       = ProtoField.uint24("lora.NetID" ,"NetID", base.HEX)
local pfDLSettings  = ProtoField.uint8("lora.DLSettings" ,"DLSettings", base.HEX)
local pfRxDelay     = ProtoField.uint8("lora.RxDelay" ,"RxDelay", base.HEX)
local pfCFList      = ProtoField.uint16("lora.CFList" ,"CFList", base.HEX)

local pfReq         = ProtoField.framenum("lora.Req",  "LoRa Request", base.uint32)
local pfResp        = ProtoField.framenum("lora.Resp", "LoRa Response", base.uint32)
local pfAck         = ProtoField.framenum("lora.Ack",  "LoRa Acknowledge", base.uint32)

lora.fields = { 
	pfVer, pfToken, pfId, pfGwId, pfJson, pfMType, pfRFU, pfMajor, pfDevAddr,
	pfFCtrl, pfFCnt, pfADR, pfRFU6, pfADRACKReq, pfFACK, pfFPending, pfRFU4, pfFOptsLen, pfFOpts, 
	pfFPort, pfFRMPayload, pfMIC,
	pfAppEUI, pfDevEUI, pfDevNonce,
	pfAppNonce, pfNetID, pfDLSettings, pfRxDelay, pfCFList, 
	pfReq, pfResp, pfAck,
}
  
reqlist = {}
reslist = {}
acklist = {}

local udp_port_table = DissectorTable.get("udp.port")
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function string.fromhex(str)
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end

function string.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-- decoding
function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function getId (id)
	if id == 0 then
		return "PUSH_DATA"
	elseif id == 1 then
		return "PUSH_ACK"
	elseif id == 2 then
		return "PULL_DATA"
	elseif id == 3 then
		return "PULL_RESP"
	elseif id == 4 then
		return "PULL_ACK"
	elseif id == 5 then
		return "TX_ACK"
	end
end

function getLow( value )
    local high_value = math.floor(value/16)
    high_value = high_value*16
    local low_value = value - high_value
    return low_value
end

function getHigh( value )
    local high_value = math.floor(value/16)
    return high_value
end

function bitand(a, b)
    local result = 0
    local bitval = 1
    while a > 0 and b > 0 do
      if a % 2 == 1 and b % 2 == 1 then -- test the rightmost bits
          result = result + bitval      -- set the current bit
      end
      bitval = bitval * 2 -- shift left
      a = math.floor(a/2) -- shift right
      b = math.floor(b/2)
    end
    return result
end

function lshift(x, by)
  return x * 2 ^ by
end

function rshift(x, by)
  if x == nil then
  	return 0
  end
  return math.floor(x / 2 ^ by)
end


function getMType(t)
	t = rshift(t, 1)

	if t == 0 then
		return "Join-Request"
	elseif t == 1 then
		return "Join-Accept"
	elseif t == 2 then
		return "Unconfirmed Data Up"
	elseif t == 3 then
		return "Unconfirmed Data Down"
	elseif t == 4 then
		return "Confirmed Data Up"
	elseif t == 5 then
		return "Confirmed Data Down"
	elseif t == 6 then
		return "RFU"
	elseif t == 7 then
		return "Proprietary"
	end
end

function subdissector(mtype, data, pkt, subtree)
	local ba = ByteArray.new(data)
	local dataTvb = ba:tvb("Data") 
	datatree = subtree:add(dataTvb(), "LoRa Data (PHYPayload)")
	datatree:add(pfMType,   dataTvb(0, 1))
	datatree:add(pfRFU,   dataTvb(0, 1))
	datatree:add(pfMajor,   dataTvb(0, 1))
	
	if mtype == "Join-Request" then
	   	datatree:add(pfAppEUI,     dataTvb(1, 8))
	   	datatree:add(pfDevEUI,     dataTvb(9, 8))
	   	datatree:add(pfDevNonce,   dataTvb(17, 2))
	   	datatree:add(pfMIC,        dataTvb(dataTvb:len()-4, 4))
	elseif mtype == "Join-Accept" then
		datatree:add(pfAppNonce,   dataTvb(1, 3))
		datatree:add(pfNetID,      dataTvb(4, 3))
		datatree:add(pfDevAddr,    dataTvb(7, 4))
		datatree:add(pfDLSettings, dataTvb(11, 1))
		datatree:add(pfRxDelay,    dataTvb(12, 1))  	
	   	datatree:add(pfMIC,        dataTvb(dataTvb:len()-4, 4))
	elseif mtype == "Unconfirmed Data Down" or mtype =="Confirmed Data Down" then
		if data:len() > 8 then
			local port = dataTvb:range(8,1):le_uint()
			if port == 0xdf then
				pkt.cols.info:append (", Join for SKTelecom")
			end
	   		datatree:add(pfDevAddr,    dataTvb(1, 4))
	   		--datatree:add(pfFCtrl,      dataTvb(5, 1))
	   		datatree:add(pfADR,        dataTvb(5, 1))
	   		datatree:add(pfRFU6,       dataTvb(5, 1))
	   		datatree:add(pfFACK,       dataTvb(5, 1))
	   		datatree:add(pfFPending,   dataTvb(5, 1))
	   		datatree:add(pfFOptsLen,   dataTvb(5, 1))
        	datatree:add(pfFCnt,       dataTvb(6, 2))
	   		local optslen = getLow(dataTvb:range(5,1):le_uint())
	   		if optslen > 0 then
	   			datatree:add(pfFOpts,  dataTvb(8, optslen)):append_text(" (Encrypted NwkSEncKey)")
	   			datatree:add(pfFPort,  dataTvb(8+optslen, 1))
	   			datatree:add(pfFRMPayload, dataTvb(9+optslen, dataTvb:len()-4-9-optslen))
	   		else
	   		    datatree:add(pfFPort,      dataTvb(8, 1))
	   			datatree:add(pfFRMPayload, dataTvb(9, dataTvb:len()-4-9)):append_text(" (Encrypted)")
	   		end	   		
	   		datatree:add(pfMIC,        dataTvb(dataTvb:len()-4, 4))
	   	else
	   	    pkt.cols.info:append (" (Malformed data)")
	   	end
	elseif mtype == "Unconfirmed Data Up" or mtype =="Confirmed Data Up" then
		if data:len() > 8 then
			local port = dataTvb:range(8,1):le_uint()
			if port == 0xdf then
				pkt.cols.info:append (", Join for SKTelecom")
			end
	   		datatree:add(pfDevAddr,    dataTvb(1, 4))
	   		--datatree:add(pfFCtrl,      dataTvb(5, 1))
	   		datatree:add(pfADR,        dataTvb(5, 1))
	   		datatree:add(pfADRACKReq,  dataTvb(5, 1))
	   		datatree:add(pfFACK,       dataTvb(5, 1))
	   		datatree:add(pfRFU4,       dataTvb(5, 1))
	   		datatree:add(pfFOptsLen,   dataTvb(5, 1))
	   		datatree:add(pfFCnt,       dataTvb(6, 2))
	   		local optslen = getLow(dataTvb:range(5,1):le_uint())
	   		if optslen > 0 then
	   			datatree:add(pfFOpts,  dataTvb(8, optslen)):append_text(" (Encrypted NwkSEncKey)")
	   			datatree:add(pfFPort,  dataTvb(8+optslen, 1))
	   			datatree:add(pfFRMPayload, dataTvb(9+optslen, dataTvb:len()-4-9-optslen))
	   		else
	   		    datatree:add(pfFPort,      dataTvb(8, 1))
	   			datatree:add(pfFRMPayload, dataTvb(9, dataTvb:len()-4-9)):append_text(" (Encrypted)")
	   		end	   		
	   		datatree:add(pfMIC,        dataTvb(dataTvb:len()-4, 4))
	   	else
	   	    pkt.cols.info:append (" (Malformed data)")
	   	end
	end

end

function lora.dissector (buf, pkt, root)
		if buf:len() == 0 then
		return
	end
  
	if 1680 == pkt.dst_port or 1680 == pkt.src_port then
		pkt.cols.protocol = "LoRa"
	end
	
	subtree = root:add(lora,  buf(0))
    local id = buf:range(3,1):le_uint()
    local token = buf:range(1,2):le_uint()
    local json_dissector = Dissector.get("json")
    local data_dissector = Dissector.get("data")
    local json = require('json')
    pkt.cols.info:set(getId(id).." identifier "..id..", ".."len="..buf:len())
	subtree:add(pfVer,   buf( 0, 1))
	subtree:add(pfToken, buf( 1, 2))
	subtree:add(pfId,    buf( 3, 1)):append_text(" ("..id.." "..getId(id)..")")
  
    if id == 0 then -- PUSH_DATA packet
    	reqlist[token] = pkt.number
    	if acklist[token] ~= nil  then
            subtree:add(pfAck, buf(1, 2), acklist[token])
        end	
		subtree:add(pfGwId,  buf( 4, 8))
		decoded = json.decode(buf:range(12,buf:len()-12):string())
		if decoded.rxpk ~=nil then
			for i, rxpk in ipairs(decoded.rxpk) do
				--cipher:setkey(key)
		    	--pkt.cols.info:set(cipher:decrypt(rxpk.data))
		    	local data  = string.tohex(dec(rxpk.data))
		    	local mtype = getMType(tonumber(data:sub(1,1)))
		    	pkt.cols.info:set(mtype)
		    	subdissector(mtype, data, pkt, subtree)
		    end
		end
		if decoded.stat ~=nil then
	    	pkt.cols.info:set("LoRa Gateway Stat")
		end
		data_dissector:call (buf(12):tvb(), pkt, subtree)
		json_dissector:call (buf(12):tvb(), pkt, subtree)
		-- subtree:add(pfJson,  buf(12, buf:len() - 12))
    elseif id == 1 then -- PUSH_ACK packet    	
    	acklist[token] = pkt.number
    	if reqlist[token] ~= nil  then
            subtree:add(pfReq, buf(1, 2), reqlist[token])
        end
	elseif id == 2 then -- PULL_DATA packet
    	reqlist[token] = pkt.number
    	if acklist[token] ~= nil  then
            subtree:add(pfAck, buf(1, 2), acklist[token])
        end	
        subtree:add(pfGwId,  buf( 4, 8))
	elseif id == 3 then -- PULL_RESP
    	reslist[token] = pkt.number
    	if acklist[token] ~= nil  then
            subtree:add(pfAck, buf(1, 2), acklist[token])
        end	
    	decoded = json.decode(buf:range(4,buf:len()-4):string())
		if decoded.txpk ~=nil then
		    txpk = decoded.txpk
		    local data  = string.tohex(dec(txpk.data))
		    local mtype = getMType(tonumber(data:sub(1,1)))
		    pkt.cols.info:set(mtype)
		    subdissector(mtype, data, pkt, subtree)
		    --end
		end
		data_dissector:call (buf(4):tvb(), pkt, subtree)
		json_dissector:call (buf(4):tvb(), pkt, subtree)
	elseif id == 4 then -- PULL_ACK packet
    	acklist[token] = pkt.number
    	if reqlist[token] ~= nil  then
            subtree:add(pfReq, buf(1, 2), reqlist[token])
        end	
    elseif id == 5 then -- TX_ACK packet
    	acklist[token] = pkt.number
    	if reslist[token] ~= nil  then
            subtree:add(pfResp, buf(1, 2), reslist[token])
        end	
		subtree:add(pfGwId,  buf( 4, 8))
		if buf:len() > 12 and buf:range(12,1):le_uint() ~= nil then
			decoded = json.decode(buf:range(12,buf:len()-12):string())
			if decoded.rxpk ~=nil then
				for i, rxpk in ipairs(decoded.rxpk) do
					--cipher:setkey(key)
		    		--pkt.cols.info:set(cipher:decrypt(rxpk.data))
		    		local data  = string.tohex(dec(rxpk.data))
		    		local mtype = getMType(tonumber(data:sub(1,1)))
		    		pkt.cols.info:set(mtype)
		    		subdissector(mtype, data, pkt, subtree)
		    	end
			end
			if decoded.txpk_ack ~=nil and decoded.txpk_ack.error ~=nil then
				pkt.cols.info:set("Error: "..decoded.txpk_ack.error)
			end
	    end
		data_dissector:call (buf(12):tvb(), pkt, subtree)
		json_dissector:call (buf(12):tvb(), pkt, subtree)
	end
end

udp_port_table:add(1680, lora)
