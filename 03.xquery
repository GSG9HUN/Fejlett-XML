(: Lekérdezés: Megkeresi azt a dátumot amikor a legtöbb specifikációt adták ki. :)
xquery version "3.1";

import schema default element namespace "" at "03.xsd";


let $json := json-doc("specifications.json")
let $dates :=
  for $doc in $json?*
  let $date := $doc?latest?date
  return $date
  (: csoportosítjuk a dátumokat :Dátum(darab) formátumban.:)
  
let $groupedDates :=
  for $date in distinct-values($dates)
  let $count := count($dates[. eq $date])
  return $date || " (" || $count || ")"
  
  (:rendezzük megszámlált dátumok szerint és visszaadjuk (dátum, darabszám) formába őket. :)
  
let $maxDate :=
  let $sorted :=
    for $group in $groupedDates
    let $date := xs:date(substring-before($group, " ("))
    let $count := xs:integer(substring-before(substring-after($group, " ("), ")"))
    order by $count descending
    return ($date, $count)
  return ($sorted[1],$sorted[2])

let $result := <maxVersionDate xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xsi:noNamespaceSchemaLocation="03.xsd">
                   <date>{data($maxDate[1])}</date>
                    <versionCount>{data($maxDate[2])}</versionCount>
    </maxVersionDate>

return validate{ $result }
