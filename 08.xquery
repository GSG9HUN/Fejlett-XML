
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";
let $json := json-doc("specifications.json")
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
      <h1>Webes Szabványok</h1>
      {
        for $item in $json?*
        return
          <div class="article">
            <h2>{$item?title}</h2>
            <p>{$item?description}</p>
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
