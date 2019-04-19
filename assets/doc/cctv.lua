--------------------------------------------------------------------------------------------------
--
-- cctv.lua
--
-- inspired by 'lgup.lua' By Jinkyu Park (jinkyu.park@lge.com)
-- written by Haeyeon, Hwang (hyhwang@mnlsolution.com)
--
-- CS, ISP, OSP, EB, SB
--
--------------------------------------------------------------------------------------------------

local cctv       	= Proto("cctv", "LGU+CCTV")

local pfName     	= ProtoField.string("cctv.hname",   	"Header Name",    			FT_STRING)
local pfVer      	= ProtoField.string("cctv.hver" ,   	"Header Version", 			FT_STRING)
local pfCode     	= ProtoField.uint32("cctv.hcode",   	"Header Code",    			base.HEX )
local pfSize     	= ProtoField.uint32("cctv.bsize",   	"Body Size",      			base.HEX )
local pfPriv     	= ProtoField.uint32("cctv.priv",    	"Privacy",        			base.HEX )
local pfReq     	= ProtoField.uint32("cctv.req",     	"Request Header Code", 		base.HEX )
local pfRes      	= ProtoField.uint32("cctv.res",     	"Result",        			base.HEX )
local pfFcnt     	= ProtoField.uint32("cctv.fcnt",    	"Fail Count",        		base.HEX )
local pfScode    	= ProtoField.uint32("cctv.scode",   	"Service Code",        		base.HEX )
local pfSkey     	= ProtoField.string("cctv.skey",    	"Service Key",    			FT_STRING )
local pfSerial   	= ProtoField.string("cctv.serial",  	"Serial Number",    		FT_STRING )
local pfSetInfo  	= ProtoField.string("cctv.setinfo", 	"Setting Information",   	FT_STRING )
local pfCamId   	= ProtoField.string("cctv.camera",   	"Camera Id",    			FT_STRING)
local pfFname    	= ProtoField.string("cctv.fname",   	"File Name",    			FT_STRING)
local pfFdata    	= ProtoField.string("cctv.fdata",   	"File Data",    			FT_STRING )
local pfEvent    	= ProtoField.string("cctv.event",   	"Event",      				FT_STRING)
local pfConfig   	= ProtoField.string("cctv.config",  	"Camera Configuration",  	FT_STRING)
local pfSDcard   	= ProtoField.string("cctv.sdcard",  	"SD Card Event Occurred",	FT_STRING )
local pfMessage  	= ProtoField.string("cctv.message", 	"Message",               	FT_STRING)
local pfResp     	= ProtoField.uint32("cctv.resp",    	"Response Code",         	base.HEX )
local pfStrmType 	= ProtoField.uint32("cctv.stream",  	"Stream Type",           	base.HEX )
local pfCToken   	= ProtoField.string("cctv.ctoken",  	"CAM Token",            	FT_STRING)
local pfUToken   	= ProtoField.string("cctv.utoken",  	"User Token",           	FT_STRING)
local pfCamType  	= ProtoField.uint32("cctv.camtype", 	"CAM Type",        			base.HEX )
local pfFWver    	= ProtoField.string("cctv.fwver",   	"Firmware Version",        	FT_STRING)
local pfRemocon  	= ProtoField.string("cctv.remocon", 	"Remocon DB Version",    	FT_STRING)
local pfIpType   	= ProtoField.uint32("cctv.iptype",  	"IP Address Type",       	base.HEX )
local pfIpAddr   	= ProtoField.string("cctv.ipaddr",  	"IP Address",    			FT_STRING)
local pfUserId   	= ProtoField.uint32("cctv.userid",  	"User ID",       			base.HEX )
local pfCtrlPort 	= ProtoField.uint32("cctv.ctrlport",	"Control Port",     		base.HEX )
local pfStrmPort 	= ProtoField.uint32("cctv.strmport",	"Stream Port",       		base.HEX )
local pfFWsize 	 	= ProtoField.uint32("cctv.fwsize",  	"Firmware Size",       		base.HEX )
local pfUrl 	 	= ProtoField.string("cctv.url",     	"URL",       				FT_STRING)
local pfMd5 	 	= ProtoField.string("cctv.md5",     	"MD5",       				FT_STRING)
local pfSvrMsg 	 	= ProtoField.uint32("cctv.svrmsg",  	"Server Message",       	base.HEX )
local pfCamStat  	= ProtoField.uint32("cctv.camstat", 	"CAM Status Code",       	base.HEX )
local pfRelayDat 	= ProtoField.string("cctv.relaydat", 	"Relay data",       		FT_STRING )
local pfSessId 	 	= ProtoField.string("cctv.sessid",  	"Session Id",       		FT_STRING)
local pfPubIpType	= ProtoField.uint32("cctv.pubiptype",  	"Public IP Address Type",   base.HEX )
local pfPubIpAddr   = ProtoField.string("cctv.pubipaddr",  	"Public IP Address",    	FT_STRING)
local pfPriIpType   = ProtoField.uint32("cctv.priiptype",  	"Private IP Address Type",  base.HEX)
local pfPriIpAddr   = ProtoField.string("cctv.priipaddr",  	"Private IP Address",    	FT_STRING)
local pfBName     	= ProtoField.string("cctv.bhname",   	"Bypass Header Name",    	FT_STRING)
local pfBVer      	= ProtoField.string("cctv.bhver" ,   	"Bypass Header Version", 	FT_STRING)
local pfBCode     	= ProtoField.uint32("cctv.bhcode",   	"Bypass Header Code",    	base.HEX )
local pfBSize     	= ProtoField.uint32("cctv.bbsize",   	"Bypass Body Size",      	base.HEX )

cctv.fields = { 
	pfName, pfVer, pfCode, pfSize, pfPriv, pfReq, pfRes, pfFcnt, pfScode, 
	pfSkey, pfSerial, pfSetInfo, pfCamId, pfFname, pfFdata, pfEvent, pfConfig, 
	pfSDcard, pfMessage, pfResp, pfStrmType, pfCToken, pfCamType, pfFWver, 
	pfRemocon, pfUToken, pfIpType, pfIpAddr, pfUserId, pfCtrlPort, pfStrmPort, 
	pfFWsize, pfUrl, pfMd5, pfSvrMsg, pfCamStat, pfRelayDat, pfSessId, 
	pfPriIpType, pfPriIpAddr, pfPubIpType, pfPubIpAddr,
	pfBName, pfBVer, pfBCode, pfBSize 
}
 
local hcodes = {
	[  101] = "Upload Authentication Request",
	[  102] = "KeepAlive Request",
	[  103] = "FileUpload Request",
	[  105] = "Event Request",
	[  107] = "Configuration Recovery Request",
	[  108] = "SD Card Request",
	[  109] = "Event(Ext) Request",
	[  110] = "Authentication Request",
	[  111] = "Firmware Update Status",
	[  112] = "CAM Type Request",
	[  200] = "Response",
	[  201] = "Authentication Response",
	[  202] = "Configuration Recovery Response",
	[  203] = "CAM Type Response",
	[ 1001] = "CAM Info Request",
	[ 1002] = "Connect RTSP Request",
	[ 1003] = "Start Stream Request",
	[ 1004] = "Stop Stream Request",
	[ 1005] = "CAM Status Request",
	[ 1006] = "Ask Stoppable",

	[ 2001] = "CAM Info Response",
	[ 2002] = "Connect RTSP Response",
	[ 2003] = "Start Stream Response",
	[ 2004] = "Stop Stream Response",
	[ 2005] = "CAM Status Response",
	[ 2006] = "Report Stoppable",

	[ 3001] = "Relay Data",
	[ 3002] = "Video Stream",
	[ 3003] = "Audio Stream",
	[ 3004] = "Stream Event",
	[ 3005] = "RTP Packet",

	[ 1101] = "Stream Ready Request",
	[ 2101] = "Stream Ready Response",
	[ 3101] = "Relay Request",
	[ 4101] = "Relay Response",

	[ 4001] = "CAM Id Request",
	[ 4002] = "Send Type Request",
	[ 4003] = "SDP Request",
	[ 4004] = "Stream Start Request",
	[ 4005] = "Stream Stop Request",
	[ 4006] = "User Token Request",

	[ 5001] = "CAM Id Response",
	[ 5002] = "Send Type Response",
	[ 5003] = "SDP Response",
	[ 5004] = "Stream Start Response",
	[ 5005] = "Stream Stop Response",
	[ 5006] = "User Token Response",

	[ 6001] = "ISA Status Request",
	[ 6002] = "OSA Status Request",
	[ 7000] = "Result Response",
	[ 7001] = "ISA Status Response",
	[ 7002] = "OSA Status Response",
	[ 7003] = "CSA Status Response",
	[12000] = "Connect STRM Request",
	[12001] = "Firmware Update Request",
	[12002] = "Configuration Update Request",
	[12003] = "Factory Reset Request",
	[12004] = "CAM Status Check (KeepAlive)",
	[12005] = "Check Firmware Info",
	[12007] = "Privacy Request",
	[13000] = "Response",
	[13001] = "Firmware Update Complete",
	[13002] = "Configuration Update Complete",
	[13003] = "Report Firmware Info",
	[14001] = "Report Firmware Update Complete",

	[ 9999] = "Response Error",
	[20001] = "Destroy Manager",
	[99999]	= "Error Packet"
}

local ecodes = {
	[    0] = "NOP",
	[10001] = "Upload fail (storage)",
	[11501] = "Authentication fail",
	[11106] = "Internal connection fail",
	[11105] = "Internal DB connection fail"
}

local events = {
	[ "3002"] = "FW Download Completed",
	[ "3003"] = "Validation Check Complete",
	[ "3003"] = "Backup Complete",
	[ "1400"] = "Intrusion Detection",
	[ "1401"] = "Sound Detection",
	[ "1402"] = "Movement Detection",
	[ "1403"] = "Door lock",
	[ "1499"] = "SD Card Error",
	[ "2200"] = "Privacy ON",
	[ "2201"] = "Privacy OFF"
}

local rcodes = {
	[   0] = "Okay",
	[1001] = "Unknown Packet",
	[1002] = "Unsupported Protocol",
	[1003] = "Version Higher",
	[1004] = "Version Lower",
	[1005] = "Length failure (no read)",

	[2001] = "Access Denied",
	[2002] = "User not-found",
	[2003] = "Wrong Password",
	[2004] = "Restricted Function",
	[2005] = "Token Error",
	[2006] = "Session not found",
	[2007] = "Session Connection Fail",

	[3001] = "Camera is not Ready",
	[3002] = "Streamer Failure",
	[3003] = "Setting Failure",

	[9999] = "Unknown Error"
}

local bcodes = {
	[   0] = "N/A",
	[ 101] = "Tile Up Request",
	[ 102] = "Tilt Down Request",
	[ 103] = "Pan Left Request",
	[ 104] = "Pan Right Request",
	[ 105] = "Abs Angle Request",
	[ 106] = "Rel Angle Request",

	[ 201] = "Remocon Setting",
	[ 202] = "Remocon Learning",
	[ 203] = "Remocon Re-Learning",
	[ 204] = "Remocon Key Delete",
	[ 205] = "Remocon PT value",
	[ 209] = "Alive Check",

	[ 301] = "2Way Audio Ready",
	[ 302] = "2Way Audio Stop",
	[ 303] = "2Way Audio Data",
	
	[1001] = "Tile Up Response",
	[1002] = "Tilt Down Response",
	[1003] = "Pan Left Response",
	[1004] = "Pan Right Response",
	[1005] = "Angle Response",
	[1001] = "Tile Up Response",
	[1002] = "Tilt Down Response",
	[1003] = "Pan Left Response",
	[1004] = "Pan Right Response",
	[1005] = "Abs Angle Response",
	[1006] = "Rel Angle Response",

	[2001] = "Remocon Setting Response",
	[2002] = "Remocon Learning Response",
	[2003] = "Remocon Re-Learning Response",
	[2004] = "Remocon Key Delete Response",
	[2005] = "Remocon PT value Response",
	[2009] = "Alive Check Response",

	[3001] = "2Way Audio Ready Response",
	[3002] = "2Way Audio Stop Response",
	[3003] = "2Way Audio Data Response",

	[9999] = "Unknown Error"
}

function GetDWORD(buf, x)
	return buf:range(x,4):le_uint()
end

function GetString(buf, x, l)
	return buf:range(x,l):string()
end

function GetStringZ(buf, x)
	return buf:range(x):stringz()
end

function ternary (cond , T , F )
    if cond then return T else return F end
end

function tternary(cond , T , cond2, T2, F )
    if cond then 
		return T 
    elseif cond2 then
		return T2 
    else 
		return F
    end
end


local OFFSET_HEADER_CODE = 12
local OFFSET_BODY_SIZE   = 16
local OFFSET_BODY        = 20

local remain		 = 0

local udp_port_table = DissectorTable.get("udp.port")
local tcp_port_table = DissectorTable.get("tcp.port")
local rtsp_dissector = Dissector.get("rtsp")
local http_dissector = Dissector.get("http")
local data_dissector = Dissector.get("data")

function cctv.dissector (buf, pkt, root)
	--RTSP case
	--if 30101 == pkt.dst_port or 30101 == pkt.src_port then
	--	if buf:len() >= 8 and "CCTVCODE" ~= GetString(buf,0,8) then
	--		rtsp_dissector:call (buf, pkt, root)
	--	end
	--end

	if buf:len() == 0 then
		return
	end

	-- root:set_text("------------------- LGUPLUS CCTV PROTOCOL -------------------")

	-- Protocol
	if 2326 == pkt.dst_port or 2326 == pkt.src_port then
		pkt.cols.protocol = "WATCHDOG"
	elseif 16161 == pkt.dst_port or 16161 == pkt.src_port then
		pkt.cols.protocol = "CTRL"
	elseif 17171 == pkt.dst_port or 17171 == pkt.src_port then
		pkt.cols.protocol = "SB"
	elseif 30100 == pkt.dst_port or 30100 == pkt.src_port then
		pkt.cols.protocol = "ISP"
	elseif 30101 == pkt.dst_port or 30101 == pkt.src_port then
		pkt.cols.protocol = "ISP"
	elseif 10105 == pkt.dst_port or 10105 == pkt.src_port then
		pkt.cols.protocol = "OSP"
	elseif 30103 == pkt.dst_port or 30103 == pkt.src_port then
		pkt.cols.protocol = "EB"
	elseif 30300 == pkt.dst_port or 30300 == pkt.src_port then
		pkt.cols.protocol = "INFO"
	end

	-- Exception Handle
	if "CCTVCODE" ~= GetString(buf,0,8) then
		pkt.cols.info = "Continuation"
		return
	end

	local nCode = GetDWORD(buf, OFFSET_HEADER_CODE)
	local nSize = GetDWORD(buf, OFFSET_BODY_SIZE  )

	pkt.cols.info:set(hcodes[nCode].."("..nCode..")")

	subtree = root:add(cctv,  buf(0))
	subtree:add(pfName, buf( 0, 8))
	subtree:add(pfVer,  buf( 8, 4))
	subtree:add(pfCode, buf(12, 4)):append_text(" "..hcodes[nCode].." ("..nCode..")")
	subtree:add(pfSize, buf(16, 4)):append_text(" ("..nSize..")")

 	if nSize ~= 0 then
		remain = nSize
	
		-- Auth Request
		if nCode == 110 then
			local nFcnt   	= GetDWORD(buf, OFFSET_BODY)
			local nScode  	= GetDWORD(buf, OFFSET_BODY+4)
			subtree:add(pfFcnt, 	buf( 20,  4)):append_text(" ("..nFcnt..")")
			subtree:add(pfScode, 	buf( 24,  4)):append_text(" ("..nScode..")")
			subtree:add(pfSkey, 	buf( 28, 40))
			subtree:add(pfSerial, 	buf( 68, 40))
			subtree:add(pfSetInfo, 	buf(108,  8))

		-- Auth Upload Request
		elseif nCode == 101 then
			local nFcnt   	= GetDWORD(buf, OFFSET_BODY)
			local nScode  	= GetDWORD(buf, OFFSET_BODY+4)
			subtree:add(pfFcnt, 	buf( 20,  4)):append_text(" ("..nFcnt..")")
			subtree:add(pfScode, 	buf( 24,  4)):append_text(" ("..nScode..")")
			subtree:add(pfSkey, 	buf( 28, 40))
			subtree:add(pfSerial, 	buf( 68, 40))

		-- Keep-alive Request
		elseif nCode == 102 then
			subtree:add(pfCamId, buf(20, 40))

		-- File upload Request
		elseif nCode == 103 then
			subtree:add(pfCamId, buf( 20, 40))
			subtree:add(pfFname,  buf( 60, 40))
			subtree:add(pfFdata,  buf(100, nSize-80))

		-- Event Request
		elseif nCode == 105 then
			local sEvt  = GetString(buf, OFFSET_BODY+40, 4)
			subtree:add(pfCamId, buf(20, 40))
			subtree:add(pfEvent,  buf(60,  4)):append_text(" ("..events[sEvt]..")")
			pkt.cols.info:append(" / "..events[sEvt])

		-- ConfRecover Request
		elseif nCode == 107 then
			subtree:add(pfCamId, buf(20, 40))

		-- SD card Request
		elseif nCode == 108 then
			local nSDcard = GetDWORD(buf, OFFSET_BODY+40)
			subtree:add(pfCamId, buf(20, 40))
			subtree:add(pfSDcard, buf(60, 4)):append_text(" ("..nSDcard.." "..ternary(nSDcard == 0, "Insert", "Eject")..")")

		-- EventExt Request
		elseif nCode == 109 then
			local sEvt  = GetString(buf, OFFSET_BODY+40, 4)
			subtree:add(pfCamId, buf(20, 40))
			subtree:add(pfEvent,  buf(60,  4)):append_text(" ("..events[sEvt]..")")
			subtree:add(pfMessage,buf(64,200))

		-- FW Update status
		elseif nCode == 111 then
			local sEvt  = GetString(buf, OFFSET_BODY+40, 4)
			subtree:add(pfCamId, buf(20,  40))
			subtree:add(pfEvent,  buf(60,  4)):append_text(" ("..events[sEvt]..")")

		-- CAM Type Request
		elseif nCode == 112 then
			subtree:add(pfCamId, buf(20, 40))

		-- Response
		elseif nCode == 200 then
			local nReq  = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfReq, buf(20, 4)):append_text(" ("..nReq.." "..hcodes[nReq]..")")

			if nReq == 110 or nReq == 101 then
				local nRes  = GetDWORD(buf, OFFSET_BODY+4)
				subtree:add(pfReq, buf(24, 4)):append_text(" ("..nRes.." "..ecodes[nRes]..")")
				pkt.cols.info:append(" / "..hcodes[nReq]..", "..ecodes[nRes])

			elseif nReq == 102 or nReq == 103 or nReq == 105 or nReq == 107 or nReq == 108 or nReq == 109 or nReq == 111 or nReq == 14001 then
				local nRes  = GetDWORD(buf, OFFSET_BODY+4)
				subtree:add(pfResp, buf(24, 4)):append_text(" ("..nRes.." "..ternary(nRes == 0, "Success", "Fail")..")")
				pkt.cols.info:append(" / "..hcodes[nReq]..", "..ternary(nRes == 0, "Success", "Fail"))

			end

		-- Auth Response
		elseif nCode == 201 then
			local nReq  = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfReq,    buf(20,  4)):append_text(" ("..nReq.." "..hcodes[nReq]..")")
			subtree:add(pfCamId, buf(24, 40))

		-- ConfRecovery Response
		elseif nCode == 202 then
			local nReq  = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfReq,    buf(20,  4)):append_text(" ("..nReq.." "..hcodes[nReq]..")")
			subtree:add(pfConfig, buf(24, 2000))
			
		-- CAM Type Response
		elseif nCode == 203 then
			local nReq  	= GetDWORD(buf, OFFSET_BODY)
			local nRes  	= GetDWORD(buf, OFFSET_BODY+4)
			subtree:add(pfReq,  buf(20, 4)):append_text(" ("..nReq.." "..hcodes[nReq]..")")
			subtree:add(pfResp, buf(24, 4)):append_text(" ("..nRes.." "..ternary(nRes == 0, "Success", "Fail")..")")
			subtree:add(pfCamType, buf(28, 4))

		-- Stream Ready Request
		elseif nCode == 1101 then
			subtree:add(pfCToken,  buf(20,48))
--			subtree:add(pfUrl,     buf(68, 120))	
			
		-- Stream Ready Response
		elseif nCode == 2101 then
			local nResp   = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfResp,   buf(20, 4)):append_text(" ("..nResp.." "..rcodes[nResp]..")")
			subtree:add(pfUrl,    buf(24, 120))	
			
		-- Response Camera Info
		elseif nCode == 2001 then
			local nResp   = GetDWORD(buf, OFFSET_BODY)
			local nStrmType = GetDWORD(buf, OFFSET_BODY+4)
			subtree:add(pfResp,   buf(20, 4)):append_text(" ("..nResp.." "..rcodes[nResp]..")")
			subtree:add(pfStrmType, buf(24, 4)):append_text(" ("..nStrmType.." "..ternary(nStrmType == 1, "RTSP", "custom TCP")..")")
			subtree:add(pfCToken,  buf(28,48))

		-- Connect RTSP Response / Stop Stream Response
		elseif nCode == 2002 or nCode == 2004 then
			local nResp   = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfResp,   buf(20, 4)):append_text(" ("..nResp.." "..rcodes[nResp]..")")

		-- Start Stream Response
		elseif nCode == 2003 then
			local nResp   = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfResp,   	buf(20,   4)):append_text(" ("..nResp.." "..rcodes[nResp]..")")
			subtree:add(pfUrl,  	buf(24, 256))

		-- Report Stoppable
		elseif nCode == 2006 then
			local nResp   = GetDWORD(buf, OFFSET_BODY)
			local nSvrMsg = GetDWORD(buf, OFFSET_BODY+4)

			subtree:add(pfResp,   	buf(20, 4)):append_text(" ("..nResp.." "..rcodes[nResp]..")")
			subtree:add(pfMessage,  buf(24, 4)):append_text(" ("..nSvrMsg.." "..ternary(nSvrMsg == 1, "stoppable and session termination", "staying until stop command from server")..")")

		-- CAM Status Response
		elseif nCode == 2005 then
			local nResp   	= GetDWORD(buf, OFFSET_BODY)
			local nCamStat 	= GetDWORD(buf, OFFSET_BODY+4)
			
			subtree:add(pfResp,   	buf(20, 4)):append_text(" ("..nResp.." "..rcodes[nResp]..")")
			subtree:add(pfCamStat, 	buf(24, 4)):append_text(" ("..nCamStat..")")

		-- Relay Data
		elseif nCode == 3001 then
			subtree:add(pfSessId,   	buf(20, 64))
			-- Bypass specificaition
			if "HTBYPASS" == GetString(buf,84,8) then
				local nBCode = GetDWORD(buf, 84+OFFSET_HEADER_CODE)
				local nBSize = GetDWORD(buf, 84+OFFSET_BODY_SIZE  )

				subtree:add(pfBName, buf( 84, 8))
				subtree:add(pfBVer,  buf( 92, 4))
				subtree:add(pfBCode, buf( 96, 4)):append_text(" "..bcodes[nBCode].." ("..nBCode..")")
				subtree:add(pfBSize, buf(100, 4)):append_text(" ("..nBSize..")")
				data_dissector:call (buf(104):tvb(), pkt, subtree)
			end


		-- Relay Data Request
		elseif nCode == 3101 then
			subtree:add(pfRelayDat, 	buf(20, nSize))
			
		-- ISA Status Request
		elseif nCode == 6001 then
			local nStrmType = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfStrmType, buf( 20,  4)):append_text(" ("..nStrmType..")")
			subtree:add(pfCToken, 	buf(24,  48))


		-- ISA Status Response
		elseif nCode == 7003 then
			local nPubIpType	= GetDWORD(buf, OFFSET_BODY)

			subtree:add(pfPubIpType,   	buf(20,  4)):append_text(" ("..nPubIpType.." "..ternary(nPubIpType == 0, "ipv4", "ipv6")..")")
			subtree:add(pfPubIpAddr,   	buf(24, 40))

		-- OSA Status Request
		elseif nCode == 6002 then
			local nStrmType = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfStrmType, buf( 20,  4)):append_text(" ("..nStrmType..")")
			subtree:add(pfCToken, 	buf( 24, 48))


		-- OSA Status Response
		elseif nCode == 7002 then
			local nPubIpType	= GetDWORD(buf, OFFSET_BODY)
			local nPriIpType	= GetDWORD(buf, OFFSET_BODY+44)

			subtree:add(pfPubIpType,   	buf(20,  4)):append_text(" ("..nPubIpType.." "..ternary(nPubIpType == 0, "ipv4", "ipv6")..")")
			subtree:add(pfPubIpAddr,   	buf(24, 40))
			subtree:add(pfPriIpType,   	buf(64,  4)):append_text(" ("..nPriIpType.." "..ternary(nPriIpType == 0, "ipv4", "ipv6")..")")
			subtree:add(pfPriIpAddr,   	buf(68, 40))

		-- Connect STRM Request
		elseif nCode == 12000 then
			local nStrmType = GetDWORD(buf, OFFSET_BODY)
			local nIpType	= GetDWORD(buf, OFFSET_BODY+4)
			local nCtrlPort = GetDWORD(buf, OFFSET_BODY+48)
			local nStrmPort = GetDWORD(buf, OFFSET_BODY+52)
			local nUserId	= GetDWORD(buf, OFFSET_BODY+56)
			
			subtree:add(pfStrmType, buf( 20,  4)):append_text(" ("..nStrmType..")")
			subtree:add(pfIpType, 	buf( 24,  4)):append_text(" ("..nIpType.." "..ternary(nIpType == 0, "ipv4", "ipv6")..")")
			subtree:add(pfIpAddr, 	buf( 28, 40))
			subtree:add(pfCtrlPort, buf( 68,  4)):append_text(" ("..nCtrlPort..")")
			subtree:add(pfStrmPort, buf( 72,  4)):append_text(" ("..nStrmPort..")")
			subtree:add(pfUserId, 	buf( 76,  4)):append_text(" ("..nUserId..")")
			subtree:add(pfCamId, 	buf( 80, 40))
			subtree:add(pfUToken, 	buf(120, 48))
			subtree:add(pfCToken, 	buf(168, 48))
		
		-- FW Update Request
		elseif nCode == 12001 then
			local nFWsize = GetDWORD(buf, OFFSET_BODY+210)
			subtree:add(pfFWver, 	buf( 20,  10))
			subtree:add(pfUrl, 		buf( 30, 200))
			subtree:add(pfFWsize, 	buf(230,   4)):append_text(" ("..nFWsize..")")
			subtree:add(pfMd5, 		buf(234,  32))

		-- Conf Update Request
		elseif nCode == 12002 then
			subtree:add(pfConfig, buf(24, 2000))

		-- Privacy On/Off
		elseif nCode == 12007 then
			local nPriv = GetDWORD(buf, OFFSET_BODY)
			local sPriv = tternary(nPriv == 0, "On", nPriv == 1, "Off", "Error")
			subtree:add(pfPriv, buf(20, 4)):append_text(" ("..nPriv.." "..sPriv..")")
			pkt.cols.info:append(" / "..sPriv)

		-- Connect STRM Response
		elseif nCode == 13000 then
			local nReq 	= GetDWORD(buf, OFFSET_BODY)
			local nRes  = GetDWORD(buf, OFFSET_BODY+44)
			subtree:add(pfReq,  	buf(20, 4)):append_text(" ("..nReq.." "..hcodes[nReq]..")")
			subtree:add(pfCamId, 	buf(24, 40))
			subtree:add(pfRes, 		buf(64, 4)):append_text(" ("..nRes.." "..ternary(nRes == 0, "Success", "Fail")..")")
			pkt.cols.info:append(" / "..hcodes[nReq])
			
		-- FW Update Complete
		elseif nCode == 13001 or nCode == 13003 then
			local nReq = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfReq,  	buf(20, 4)):append_text(" ("..nReq.." "..hcodes[nReq]..")")
			subtree:add(pfCamId,  	buf(24, 40))
			subtree:add(pfFWver,   buf(64, 10))
			subtree:add(pfRemocon, buf(74, 10))

		-- Conf Update Complete Response
		elseif nCode == 13002 then
			local nReq  = GetDWORD(buf, OFFSET_BODY)
			subtree:add(pfReq,    	buf(20,  4)):append_text(" ("..nReq.." "..hcodes[nReq]..")")
			subtree:add(pfCamId, 	buf(24, 40))
			subtree:add(pfConfig, 	buf(64, 2000))
			

		else
			data_dissector:call (buf(20):tvb(), pkt, subtree)
		end

	end

	pkt.cols.info:append(", Len:"..nSize)
end

tcp_port_table:add( 2326, cctv)
tcp_port_table:add(10105, cctv)
tcp_port_table:add(16161, cctv)
tcp_port_table:add(17171, cctv)
tcp_port_table:add(20103, cctv)
tcp_port_table:add(30100, cctv)
--tcp_port_table:add(30101, cctv)
tcp_port_table:add(30103, cctv)
tcp_port_table:add(30300, cctv)
tcp_port_table:add(10102, rtsp_dissector)
tcp_port_table:add(30101, rtsp_dissector)
tcp_port_table:add(30102, rtsp_dissector)
tcp_port_table:add(10103, http_dissector)

