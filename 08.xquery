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
        <style>
        {"
          body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
          }

          h1 {
            color: #0066cc;
          }

          .article {
            border: 1px solid #ddd;
            margin: 10px;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          }

          .editor {
            font-style: italic;
            color: #555;
          }

          a {
            color: #0066cc;
            text-decoration: none;
          }

          a:hover {
            text-decoration: underline;
          }
        "}
        </style>
    </head>
    <body>
      <h1>Szabványok ahol legalább három editor és két deliverer cég van.</h1>
      {
        for $item in $json?*
        where count($item?latest?editors?*) ge $minEditorsCount and
                    count($item?latest?deliverers?*) ge $minDeliverersCount
        return
          <div class="article">
            <h2>{local:clean-html($item?title)}</h2>
            <p>{local:clean-html($item?description)}</p>
            <p class="editor">
              Szerkesztő(k): {
                for $editor in $item?latest?editors?*
                
                return
                <ul>
                <li>
                  <a href="{$editor?href}" target="_blank">{$editor?title}</a>
                </li>
                </ul>
                
              }
            </p>
            <p>
              További információ: 
              <a href="{$item?shortlink}" target="_blank">{$item?shortlink}</a>
            </p>
          </div>
      }
    </body>
  </html>

return $html
