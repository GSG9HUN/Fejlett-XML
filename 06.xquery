(:Visszaadja csoportosítva melyik országból mennyien dolgoztak és a nevüket valamint, hogy melyik városból. Ha nem tudjuk akkor azt írjuk ki hogy Ismeretlen :)
xquery version "3.1";

import schema default element namespace "" at "06.xsd";

let $json := json-doc('editors.json')
let $editorCounts := <countries xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xsi:noNamespaceSchemaLocation="06.xsd">
  {for $editor in $json?*
  let $countryCode := $editor?*?country-code
  group by $countryCode
  order by count($editor) descending
  return  <country 
    code="{if(exists($countryCode)) then string($countryCode) else "Ismeretlen"}" 
    editorCount="{count($editor)}">
      { 
        for $editorData in $editor?*
        return
          <editor>
            <name>{$editorData?name}</name>
            <city>{if (exists($editorData?city)) then $editorData?city else "Ismeretlen"}</city>
          </editor>
      }
    </country>}
    </countries>
return validate{$editorCounts}