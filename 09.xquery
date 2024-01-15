
(:A lekérdezés visszaadja rendezve azon specifikációk adatait amellyeknek az editorjait nem tudjuk és a kiadás dátuma egy intervallumon belül van.:)
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

let $data := json-doc("XML.json")

let $filtered := for $entry in $data?*
                 where array:size($entry?latest?editors) <1 and 
                 xs:date("2005-09-15") le xs:date($entry?latest?date) and 
                 xs:date("2016-09-15") ge xs:date($entry?latest?date)
                 order by xs:date($entry?latest?date) ascending 
                 return $entry
return array{$filtered}