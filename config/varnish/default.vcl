vcl 4.0;

backend default {
  .host                 = "nginx";
  .port                 = "80";
  .first_byte_timeout 	= 900s;
}

sub vcl_deliver {

	if (obj.hits > 0) {
		set resp.http.X-Cache = "HIT";
	} else {
		set resp.http.X-Cache = "MISS";
	}

}

sub vcl_recv {

	# dont cache site2.com or site3.com - optional www
	if (req.http.host ~ "(www\.)?(conectouv2)\.dev.com") {
		return(pass);
	}

}
