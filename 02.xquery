xquery version "3.1";
(: Visszaadja a szerkesztők adatait :)

import module namespace deik-utility = "http://www.inf.unideb.hu/xquery/utility"
at "https://arato.inf.unideb.hu/jeszenszky.peter/FejlettXML/lab/lab10/utility/utility.xquery";
declare namespace json = "http://www.json.org";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:indent "yes";

declare function local:getEditorData($editorLink as xs:string) as item()? {
  try {
    let $editorPersonalData := fn:json-doc(deik-utility:add-query-params($editorLink, map{}))
    return map{
      $editorLink: map{
        "id": $editorPersonalData?id,
        "name": $editorPersonalData?name,
        "given": $editorPersonalData?given,
        "family": $editorPersonalData?family,
        "country-code": $editorPersonalData?country-code,
        "city": $editorPersonalData?city
      }
    }
  } catch * {
   }
};

let $urlPage1 := deik-utility:add-query-params("https://api.w3.org/specifications", map{"page": 1, "items": 1000})
let $urlPage2 := deik-utility:add-query-params("https://api.w3.org/specifications", map{"page": 2, "items": 1000})

let $dataPage1 := fn:json-doc($urlPage1)
let $dataPage2 := fn:json-doc($urlPage2)
let $urls := 
  array{
    for $pageData in ($dataPage1,$dataPage2)
        for $spec in $pageData?_links?specifications?*
        let $specData := fn:json-doc(deik-utility:add-query-params($spec?href, map{}))
        let $latestData := fn:json-doc(deik-utility:add-query-params($specData?_links?latest-version?href, map{}))
        let $editorsData := fn:json-doc(deik-utility:add-query-params($latestData?_links?editors?href, map{}))
        return for $link in $editorsData?_links?editors?*
            return  $link?href
  } 

let $uniqueURLs := array {distinct-values(for $x in $urls?* return $x)}


let $editorsData := array{ for $url in $uniqueURLs?* return local:getEditorData($url) }

return $editorsData









