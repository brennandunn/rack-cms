Feature: Editing a page
  In order to edit a page
  Rack CMS embeds a toolbar
  
  Background:
    Given I have the following markup:
      """
      <html>
        <head>
          <title>Edit me</title>
        </head>
        <body>
          <div ctype="rich" ctitle="Rich Content">I should not change</div>
          <img ctitle="Profile Image" src="/images/example.jpg">
        </body>
      </html>
      """
    And I am in editing mode



  Scenario: A page that has no stored values set yet
    When the page is rendered
    Then the response should be the following:
      """
      <html>
        <head>
          <title>Edit me</title>
          <script type="text/javascript" src="/__rack_cms__/jquery.js"></script><script type="text/javascript" src="/__rack_cms__/editor.js"></script><link type="text/css" rel="stylesheet" href="/__rack_cms__/editor.css">        </head>
        <body>
          <div ctype="rich" ctitle="Rich Content">I should not change</div>
          <img ctitle="Profile Image" src="/images/example.jpg"><div id="rack_cms_toolbar"></div>
      </body>
      </html>
      """
  
  Scenario: A page that has stored values set
    Given this page's values are:
      | title         | content                                 |
      | Rich Content  | I replaced you!                         |
      | Profile Image | { src: '/images/replaced.jpg' }         |
    When the page is rendered
    Then the response should be the following:
      """
      <html>
        <head>
          <title>Edit me</title>
          <script type="text/javascript" src="/__rack_cms__/jquery.js"></script><script type="text/javascript" src="/__rack_cms__/editor.js"></script><link type="text/css" rel="stylesheet" href="/__rack_cms__/editor.css">
        </head>
        <body>
          <div ctype="rich" ctitle="Rich Content">I replaced you!</div>
          <img ctitle="Profile Image" src="/images/replaced.jpg"><div id="rack_cms_toolbar"></div>
      </body>
      </html>
      """
  
  @wip
  Scenario: Storing a value and reloading the page
    When the placeholder "Rich Content" is saved with "Look at me!"
    And the placeholder "Profile Image" is saved with "{ src: '/images/foo.jpg' }"
    And the page is rendered
    Then the response should be the following:
      """
      <html>
        <head>
          <title>Edit me</title>
          <script type="text/javascript" src="/__rack_cms__/jquery.js"></script><script type="text/javascript" src="/__rack_cms__/editor.js"></script><link type="text/css" rel="stylesheet" href="/__rack_cms__/editor.css">
        </head>
        <body>
          <div ctype="rich" ctitle="Rich Content">Look at me!</div>
          <img ctitle="Profile Image" src="/images/foo.jpg"><div id="rack_cms_toolbar"></div>
      </body>
      </html>
      """