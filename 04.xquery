(: Viasszadja azokat a specifikációkat amiknek a title vagy description attribítumában szerepelnek a keywords szavak:)
import schema default element namespace "" at "04.xsd";

let $json1 := json-doc('specifications.json')

let $keywords := ('vector', 'graphics', 'animation') (: Példa kulcsszavakra :)

let $selectedSpecifications :=
  for $spec in $json1?*
  where
    some $keyword in $keywords satisfies
      contains($spec?title, $keyword) or contains($spec?description, $keyword)
  return $spec

let $xml :=   <selectedSpecifications xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                   xsi:noNamespaceSchemaLocation="04.xsd">
    {
      for $spec in $selectedSpecifications
      return
        <specification>
          <title>{data($spec?title)}</title>
          <description>{data($spec?description)}</description>
          <shortname>{data($spec?shortname)}</shortname>
          <shortlink>{data($spec?shortlink)}</shortlink>
          <latestData>
            <date>{data($spec?latest?date)}</date>
            <status>{data($spec?latest?status)}</status>
            <editorsNumber>{count($spec?latest?editors?*)}</editorsNumber>
            <deliverersNumber>{count($spec?latest?deliverers?*)}</deliverersNumber>
          </latestData>
        </specification>
    }
  </selectedSpecifications>


return validate {$xml}