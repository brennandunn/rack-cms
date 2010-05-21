Feature: Outputting markup
  In order to render a page that contains placeholders
  Rack CMS needs to pull information from a datastore 
  And replace the placeholders with these values
  
  Scenario: A page marked with placeholders that has no stored values
    Given I have the following markup:
      """
      <html>
        <body>
          <div ctype="rich" ctitle="Rich Content">I should not change</div>
          <img ctitle="Profile Image" src="/images/example.jpg">
        </body>
      </html>
      """
    When the page is rendered
    Then the response should be the following:
      """
      <html>
        <body>
          <div>I should not change</div>
          <img src="/images/example.jpg">
        </body>
      </html>
      """
  
  @wip
  Scenario: A page marked with placeholders that has stored values
    Given I have the following markup:
      """
      <html>
        <body>
          <div ctype="rich" ctitle="Rich Content">I should not change</div>
          <img ctitle="Profile Image" src="/images/example.jpg">
        </body>
      </html>
      """
    And this page's values are:
      | title         | content                                 |
      | Rich Content  | I replaced you!                         |
      | Profile Image | { src: '/images/replaced.jpg' }         |
    When the page is rendered
    Then the response should be the following:
      """
      <html>
        <body>
          <div>I replaced you!</div>
          <img src="/images/replaced.jpg">
        </body>
      </html>
      """
  
  Scenario: A page with no placeholders
    Given I have the following markup:
      """
        <html>
          <body>
            Nothing here!
          </body>
        </html>
      """
    When the page is rendered
    Then the response should not have changed