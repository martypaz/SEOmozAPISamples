<!--- 
	
	moz.com Authentication script - by Martin Parry - http://www.coldfusion.com.au/

 --->

<!--- Obtain your access id and secret key here: http://www.seomoz.org/api/keys --->
<cfset secretKey = "ACCESS_ID_HERE">
<cfset accessID = "SECRET_KEY_HERE">

<!--- Get epoch time --->
<cfset expires = left(getTickcount(), 10) + 300>

<!--- A new linefeed is necessary between your AccessID and Expires. --->
<cfset string = "#accessID##chr(10)##expires#">

<!--- Uses crypto.cfc from Ben Nadel - https://github.com/bennadel/Crypto.cfc - Place it in same folder as this script --->
<cfset crypto = new Crypto() />

<!--- Create signature --->
<cfset signature = crypto.hmacSha1( secretKey, string, "base64" )>

<!--- Sample URL to get uid --->
<cfset baseURL = "http://lsapi.seomoz.com/linkscape/url-metrics/moz.com%2fblog?Cols=2048&AccessID=#urlEncodedFormat(accessID)#&Expires=#expires#&Signature=#urlEncodedFormat(signature)#">

<!--- Get and display --->
<cfhttp url="#baseURL#" method="get" timeout="15"></cfhttp>
<cfdump var="#deserializeJSON(cfhttp.fileContent)#" label="Moz response">
