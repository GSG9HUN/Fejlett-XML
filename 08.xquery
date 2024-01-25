(:A lekérdezés visszaadja azokat a szabványokat ahol legalább 3 szerkesztő és 2 szállító cég van.:)
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

declare function local:clean-html($html as xs:string) as xs:string {
  let $text := fn:replace($html, '&lt;p&gt;|&lt;/p&gt;', '')
  let $cleaned-text := fn:replace($text, '&lt;.*?&gt;', '')
  return fn:normalize-space($cleaned-text)
};

let $json := json-doc("specifications.json")
let $minEditorsCount := 3
let $minDeliverersCount :=2
let $html := <html>
    <head>
      <title>HTML Lap</title>
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"/>
    </head>
    <body>
      <h1>Szabványok ahol legalább három editor és két deliverer cég van.</h1>
      {
        for $item in $json?*
        where count($item?latest?editors?*) ge $minEditorsCount and
                    count($item?latest?deliverers?*) ge $minDeliverersCount
        return
          <div class="card w-50 m-auto">
          <div class="card-body">
            <h5 class="card-title">{local:clean-html($item?title)}</h5>
            <p>{local:clean-html($item?description)}</p>
            <ol class="list-group list-group-numbered">
            <p class="editor">
              Szerkesztő(k):{
                for $editor in $item?latest?editors?*  
                return  <li class="list-group-item d-flex justify-content-between align-items-start">
                   <div class="ms-2 me-auto">
                    <div class="fw-bold">{$editor?title}</div>
                    </div>      
                  </li>
                
              }</p>
                  
             
            </ol>
            <a href="{$item?shortlink}" target="_blank" class="btn btn-primary">További információ</a>
          </div>

           
          </div>
      }
    </body>
  </html>

return $html
