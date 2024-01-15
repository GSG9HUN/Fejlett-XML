(:Kilistázza azon specifikációkat amellyek legfrissebb státusza Working Draft és 2021 után jelentek meg.:)

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";


let $json := json-doc("XML.json")

let $filtered := for $element in $json?*
    where $element?latest?status = "Working Draft"   and 
    xs:date("2021-12-31") le xs:date($element?latest?date)
    return $element

let $html := <html>
    <head>
      <title>Working Draft Status Elements</title>
      <style>
      {"body {
             font-family: 'Arial', sans-serif;
             background-color: #f4f4f4;
             color: #333;
             margin: 0;
             padding: 0;
           }
           
           .container {
             max-width: 800px;
             margin: 20px auto;
             background-color: #fff;
             padding: 20px;
             border-radius: 8px;
             box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
           }
           
           h2 {
             color: #007bff;
           }
           
           table {
             width: 100%;
             border-collapse: collapse;
             margin-top: 20px;
           }
           
           th, td {
             border: 1px solid #ddd;
             padding: 12px;
             text-align: left;
           }
           
           th {
             background-color: #f2f2f2;
           }
           
           ul {
             list-style-type: none;
             margin: 0;
             padding: 0;
           }
           
           li {
             margin-bottom: 5px;
           }
           "}
      </style>
    </head>
    <body>
      <h2>Elements with Working Draft Status</h2>
      <table>
        <tr>
          <th>Title</th>
          <th>Description</th>
          <th>Status</th>
          <th>Date</th>
          <th>Editors</th>
          <th>Delivery Groups</th>
        </tr>
        {
          for $element in $filtered
          return
            <tr>
              <td>{$element?title}</td>
              <td>{$element?description}</td>
              <td>{$element?latest?status}</td>
              <td>{$element?latest?date}</td>
              <td>
                <ul>
                  {
                    for $editor in $element?latest?editors?*
                    return
                      <li>{$editor?title}</li>
                  }
                </ul>
              </td>
              <td>
                <ul>
                  {
                    for $delivery in $element?latest?deliveries?*
                    return
                      <li>{$delivery?title}</li>
                  }
                </ul>
              </td>
            </tr>
        }
      </table>
    </body>
  </html>

return $html
