<?
function get_content($url, $post, $token, $method) 
{
	$usecookie = "cookie.txt";
	$header[] = 'Content-Type: application/json';
	$header[] = "Accept-Encoding: gzip, deflate";
	$header[] = "Cache-Control: max-age=0";
	$header[] = "Connection: keep-alive";
	$header[] = "Accept-Language: en-US,en;q=0.8,id;q=0.6";
	$header[] = "Authorization: Bearer ".$token; // Prepare the authorisation token
	//var_dump ($header);
	
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
	curl_setopt($ch, CURLOPT_HEADER, false);
	curl_setopt($ch, CURLOPT_VERBOSE, false);
	// curl_setopt($ch, CURLOPT_NOBODY, true);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_ENCODING, true);
	curl_setopt($ch, CURLOPT_AUTOREFERER, true);
	curl_setopt($ch, CURLOPT_MAXREDIRS, 5);

	curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36");

	if ($post)
	{
		//echo "<br />".$post."<br />";
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
	}
	
	//special for get method
	if ($method == "GET") curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
	
	$rs = curl_exec($ch);

	if(empty($rs))
	{
		//var_dump($rs, curl_error($ch));
		curl_close($ch);
		return false;
	}
	curl_close($ch);
	return $rs;
}
?>