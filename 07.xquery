(:Kilistázza azon specifikációkat amellyek legfrissebb státusza Working Draft és 2021 után jelentek meg.:)

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";


let $json := json-doc("specifications.json")

let $filtered := for $element in $json?*
    where $element?latest?status = "Working Draft"   and 
    xs:date("2021-12-31") le xs:date($element?latest?date)
    return $element

let $html := <html>
    <head>
      <title>Working Draft Status Elements</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"/>
    </head>
    <body>
      <h2>Elements with Working Draft Status</h2>
      
    </body>
       <div class="ms-5 me-5">
       <ol class="list-group list-group-numbered">
           {
            for $element in $filtered
            return <li class="list-group-item p-2 justify-content-between align-items-start">
                        <div class="ms-2 me-auto flex-md-fill">
                            <div class="fw-bold">{$element?title}</div>
                            {$element?description}
                           </div>
                           <div><strong>Status : </strong>{$element?latest?status}</div>
                           <div><strong>Latest date : </strong>{$element?latest?date}</div>
                           <div>
                           <div class="d-inline">
                           <strong>Editors:</strong>
                           <ol class="list-group list-group">
                            {for $editor in $element?latest?editors?*
                                   return            
                                       <li class="list-group-item d-flex justify-content-between align-items-start">
                                           <div>
                                               {$editor?title} 
                                           </div>
                                       </li>         
                               }
                           </ol>
                        </div>
                        <div>
                            <strong>Deliverers:</strong>
                            <ol class="list-group list-group">
                                {for $deliverer in $element?latest?deliverers?*
                                    return 
                                        <li class="list-group-item d-flex justify-content-between align-items-start">
                                            <div class="ms-2 me-auto">
                                                {$deliverer?title} 
                                            </div>
                                        </li>
                                }
                            </ol>
                        </div>      
                       </div>
                    </li>
                    }
                </ol>
            </div>
    </html>

return $html