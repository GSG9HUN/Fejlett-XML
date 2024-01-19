(:Lekéri a specifikációkat a megadott séma szerint :)

xquery version "3.1";

import module namespace deik-utility = "http://www.inf.unideb.hu/xquery/utility"
at "https://arato.inf.unideb.hu/jeszenszky.peter/FejlettXML/lab/lab10/utility/utility.xquery";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:indent "yes";


let $urlPage1 := deik-utility:add-query-params("https://api.w3.org/specifications", map{"page": 1, "items": 1000})
let $urlPage2 := deik-utility:add-query-params("https://api.w3.org/specifications", map{"page": 2, "items": 1000})

let $dataPage1 := fn:json-doc($urlPage1)
let $dataPage2 := fn:json-doc($urlPage2)

let $allData :=
  array {
    for $pageData in ($dataPage1, $dataPage2)
    for $spec in $pageData?_links?specifications?*
    let $specData := fn:json-doc(deik-utility:add-query-params($spec?href, map{}))
    let $latestData := fn:json-doc(deik-utility:add-query-params($specData?_links?latest-version?href, map{}))
    let $editorsData := fn:json-doc(deik-utility:add-query-params($latestData?_links?editors?href, map{}))
    let $deliverersData := fn:json-doc(deik-utility:add-query-params($latestData?_links?deliverers?href, map{}))
    return
      map{
        "shortlink": $specData?shortlink,
        "description": $specData?description,
        "title": $specData?title,
        "shortname": $specData?shortname,
        "latest": map{
          "status": $latestData?status,
          "informative": $latestData?informative,
          "date": $latestData?date,
          "editors": $editorsData?_links?editors,
          "deliverers": $deliverersData?_links?deliverers
        }
      }
  }

return $allData