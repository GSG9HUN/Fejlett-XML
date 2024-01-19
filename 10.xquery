(: Recommendation státuszú elemek és Uknown working group deliverer szerepel a deliverers tömbbe összegyűjtése. :)
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

let $data := json-doc("specifications.json")
let $items :=
  for $item in $data?*
  where some $deliverer in $item?latest?deliverers?* satisfies $deliverer?title = "UNKNOWN WORKING GROUP" and
  $item?latest?status = "Recommendation" 
 
  return $item
  
return array{$items}