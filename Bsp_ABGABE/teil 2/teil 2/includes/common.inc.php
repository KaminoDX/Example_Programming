<?php
function ta($in)
{
	if (TESTMODUS) {
		echo ('<pre class="ta">');
		print_r($in);
		echo ('</pre>');
	}
}
