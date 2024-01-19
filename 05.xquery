(: megkeresi azt a specifikációt amin a legtöbben dolgoztak és visszaadja az editorok adatait is mellé. :)
xquery version "3.1";

import schema default element namespace "" at "05.xsd";

let $json1 := json-doc('specifications.json')
let $json2 := json-doc('editors.json')


let $specifications :=  array{
        for $spec in $json1?*
        let $editorsCount := count($spec?latest?editors?*)
        order by $editorsCount descending
        return $spec
    }
    
let $specificationsWithMaxEditor := array:get($specifications,1)
let $editorsData := array{
    for $specEditor in $specificationsWithMaxEditor?latest?editors?*
    let $editorHref := $specEditor?href
    for $editor in $json2?*
         return if (map:keys($editor) = ($editorHref)) then $editor($editorHref) else ()
        
}
let $xml := <specWithEditors xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xsi:noNamespaceSchemaLocation="05.xsd">
    <specification>
        <title>{$specificationsWithMaxEditor?title}</title>
        <description>{$specificationsWithMaxEditor?description}</description>
        <shortname>{$specificationsWithMaxEditor?shortname}</shortname>
        <shortlink>{$specificationsWithMaxEditor?shortlink}</shortlink>
        <latestData>
            <date>{$specificationsWithMaxEditor?latest?date}</date>
            <status>{$specificationsWithMaxEditor?latest?status}</status>
            <editorsNumber>{count($specificationsWithMaxEditor?latest?editors?*)}</editorsNumber>
            <deliverersNumber>{count($specificationsWithMaxEditor?latest?deliverers?*)}</deliverersNumber>
        </latestData>
    </specification>

  <editors>
    {
      for $editor in $editorsData?*
      return
        <editor>
           <country-code>{$editor?country-code}</country-code>
           <city>{$editor?city}</city>
           <name>{$editor?family || " " || $editor?given}</name>
        </editor>
    }
  </editors>
  </specWithEditors>
  
return validate {$xml}