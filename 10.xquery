(: Recommendation státuszú elemek és Uknown working group delivery szerepel a deliveries tömbbe összegyűjtése. :)
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

let $data := json-doc("specifications.json")
let $items :=
  for $item in $data?*
  where some $delivery in $item?latest?deliveries?* satisfies $delivery?title = "UNKNOWN WORKING GROUP" and
  $item?latest?status = "Recommendation" 
 
  return $item
  
return array{$items}