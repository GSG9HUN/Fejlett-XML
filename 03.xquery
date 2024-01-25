(: Lekérdezés: Megkeresi azt a dátumot amikor a legtöbb specifikációt adták ki. :)
xquery version "3.1";

import schema default element namespace "" at "03.xsd";
let $json := json-doc("specifications.json")

let $grouped := array{
  for $spec in $json?*
  let $date := $spec?latest?date
  group by $date
  let $count := count($spec)
  order by $count descending
    return ($date,$count)
  }
let $result := <maxVersionDate xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xsi:noNamespaceSchemaLocation="03.xsd">
                   <date>{array:get($grouped,1)}</date>
                    <versionCount>{array:get($grouped,2)}</versionCount>
    </maxVersionDate>

return validate {$result}

