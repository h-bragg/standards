# Graze Coding Standards

This document describes the coding standards of Graze across its common languages to be adhered to and enforced by the Graze tech team, any violation of standards must be justified by the developer and exceptions are allowed for cases where it is unavoidable, such as in the case of third-party integrations.

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](http://www.ietf.org/rfc/rfc2119.txt).

## General

1. Indent size MUST be 4 space characters and MUST NOT be the tab character.
2. All files MUST end with a blank new line (the new line character).
3. All files MUST use the Unix LF (linefeed) line ending.
4. There MUST NOT be trailing whitespace.

## Git

1. Repo names SHOULD be all lowercase with hyphens (-) to separate words where appropriate.
2. Internal-only libraries SHOULD be prefixed with "graze-".
3. It is RECOMMENDED to follow the style guide mantained in [agis-/git-style-guide](https://github.com/agis-/git-style-guide).

## Logging

1. Logs should be written to stderr and collected to a central store
2. Application logs should be in [logfmt](https://brandur.org/logfmt) format in development and production

  ```
  msg="Request finished" tag=request_finish status=200
    user=brandur@mutelight.org user_id=1234 app=mutelight app_id=1234
  ```

3. Logs in logfmt should have the following fields specified by default:
  1. Generic
    1. `app` - simple name of the application
    1. `env` - environment it is running in (`dev`,`test`,`staging`,`integration`,`live`)
    1. `module` - the area of the code this log is coming from
    1. `tag` - a unique name associated with this specific log message
    1. `level` - the log level (preferably limited to: `debug`,`info`,`error` but `warn`,`fatal` and `panic` are also valid)
    1. `msg` - a textual description of the message
    1. `transaction` - a unique transaction id for a particular request (if applicable)
    1. `time` - the current timestamp (in RFC3339 format)
    1. `dur` - the time taken to complete an action (in fractional seconds)
  1. Graze
    1. `apid` - Account Profile Id
    1. Other id's should be in the format `{item}_id`
  1. REST requests
    1. `http.method` - `GET`,`POST`, etc...
    1. `http.path` - Path of request (without params)
    1. `http.uri` - Full request path (with params)
    1. `http.status` - Status Code returned
    1. `http.protocol` - Protocol used for the request (`HTTP/1.1`, `HTTP/2.0`)
    1. `http.user` - The IP of the users request

## PHP

1. All PHP code MUST adhere to the [PSR-2 Coding Standard](http://www.php-fig.org/psr/psr-2/) (which MUST follow the [PSR-1 Coding Standard](http://www.php-fig.org/psr/psr-1/)).
2. Short array syntax (`[]` instead of `array()`) MUST be used.
3. All PHP code MUST adhere to the [PSR-4 Autoloading](http://www.php-fig.org/psr/psr-4/) Standard.
4. Class names MUST be declared in UpperCamelCase.
  1. Acronyms MUST be treated as normal words. `HttpException`, not `HTTPException`.
5. Variable names MUST be declared in camelCase.
  1. Acronyms MUST be treated as normal words. `xmlHttpRequest` not `XMLHTTPRequest`.
6. Scripts MUST be named in camelCase describing their primary function.
7. Non-static functions MUST NOT be called statically.
8. Static functions MUST NOT be called non-statically.
9. Comments SHOULD be used to provide explanation for “why” rather than “how” and SHOULD be used when there isn’t a way to make the code simpler or self-documenting.
10. Nested ternary operators MUST NOT be used.
11. PHP file encoding must be UTF-8.
12. `if` statements which span multiple lines should be split as follows:

  ```php
  if ($longVariableNameNumber1
      && $longVariableNameNumber2
      && $longVariableNameNumber3
      && $longVariableNameNumber4
      || $longVariableNameNumber5) {
    // body of control structure
  }
  ```

13. There MUST NOT be any assignment or modification of variables in the expressions of `if` statements.

  ```php
  if ($response = $request->getResponse()) {
    // not allowed
  }
  ```
14. Abstract class names MUST begin with `Abstract`.

  ```php
  abstract class AbstractGenerator {
  }
  ```
15. Interface names MUST end with `Interface`.

  ```php
  interface GeneratorInterface {
  }
  ```
16. 'Not' logical operators MUST NOT have whitespace between them and the subject being negated.
  ```php
  $true = !false;
  ```

### PHP DocBlock
1. DocBlock for functions / methods MUST exist where the function / method has arguments or a return value and MUST use the appropriate tags (@param, @return) to denote that. Developers making modifications to a function / method are tasked with ensuring that the DocBlock is up-to-date.
2. Functions / methods / classes that are sufficiently complex (i.e. not self-documenting) SHOULD have a DocBlock explaining how to use the function / method / class.
3. DocBlock presenting the type MUST be present for class member variables.
4. When a description is necessary for class member variables, the DocBlock MUST be multiline:

  ```php
  class Foo
  {
      /** @var int */
      protected $id;

      /**
       * The Bar used to fight the foo
       *
       * @var Bar
       */
      private $bar;
  }
  ```

5. DocBlock types for scalar values MUST be one of: `bool` (not boolean), `int` (not integer), `string`, `float` (not double).
6. DocBlock types for parameters/return values that are arrays of a single type MUST be written as: `Type[]`. If the variable is a multi-dimensional array, it MUST be represented with one set of `[]` per depth (`int[][]` for an array of array of ints)
7. If the parameter/return value is an array of several types, it MUST be described in the DocBlock as `mixed[]`.
8. If the parameter/return value is an array that is sometimes empty, it MUST still be written as in 6) (NOT `Type[]|[]`)

**example of a method's DocBlock:**
```
    /**
     * Foos the bars.
     *
     * @param int $barId Some number
     * @param Bar[] $allTheBars Collection of Bar objects
     * @return string[] List of messages
     */
    public function barFooer($barId, array $allTheBars) {}
```

## Views

1. MUST use the .phtml extension.
2. MUST be named in camelCase.
3. SHOULD be named after the controller action that they are the view for. E.g. the view for graze.com/account/payments must be in views/graze/en/account/payments.phtml.
4. PHP in views:
    1. MUST NOT modify the value of variables.
    2. MUST NOT reference static class properties, methods or constants.
    3. SHOULD NOT reference instance properties or methods, with the exception of the View instance.
    4. MAY reference PHP functions except where this conflicts with 4.i.

## Images

1. Words in image file names MUST be separated with hyphens (-).
2. Images SHOULD be compressed to the smallest possible size without compromising on clarity.
3. JPEG file format MUST be used only for an image that is or contains photography except in the case of (4).
4. PNG file format MUST be used for any image requiring transparency.

## HTML

1. HTML MUST be easily readable. The following guidelines are RECOMMENDED for increasing readability.
    1. No more than one tag per line.
    2. Correct indentation.
2. HTML SHOULD be using the HTML5 doctype.
3. Closing slashes MUST NOT be used on void elements. (img, br etc)
4. All tags and attributes MUST be in lowercase.
5. All attribute values MUST be enclosed by double-quotes.

## CSS / LESS

1. Words in file names MUST be separated with hyphens (-).
2. CSS3 is RECOMMENDED.
3. Selectors MUST be in hyphen case. (.button-blue).
4. Selectors MUST be on a single line, with a space after the last selector, followed by an opening brace. A selector MUST end with a closing brace that is un-indented and on a separate line. A blank line MUST be placed between each block of selectors.
5. There MUST only be one property:value pair per line.
6. CSS blocks SHOULD adhere to the CSS Property Order.
7. There MUST always be a space after a property's colon (e.g., display: block; and not display:block;).
8. Property declaration lines MUST end with a semi-colon.
9. For multiple, comma-separated selectors, each selector MUST be on its own line.
10. Attribute selectors, like input[type="text"] MUST always wrap the attribute's value in double quotes, for consistency and safety.
11. Attribute selectors MUST only be used where absolutely necessary (e.g., form controls) and MUST be avoided on custom components for performance and explicitness.
12. Series of classes for a component MUST include a base class (e.g., .component) and use the base class as a prefix for modifier and sub-components (e.g., .component-lg).

## JavaScript

Please refer to the [airbnb style guide](https://github.com/airbnb/javascript) for styling standards, **in particular**:

 - [Variables](https://github.com/airbnb/javascript#variables)
 - [jQuery](https://github.com/airbnb/javascript#jquery)
 - [Commas](https://github.com/airbnb/javascript#commas)
 - [Objects](https://github.com/airbnb/javascript#objects)
 - [Arrays](https://github.com/airbnb/javascript#arrays)
 - [Strings](https://github.com/airbnb/javascript#strings)
 - [Functions](https://github.com/airbnb/javascript#functions)

### Immediately-invoked function expressions (IIFE)

 1. MUST NOT be used for CommonJS exporting modules (built with Browserify)
 2. MUST be used in inline scripts and non Browserify compiled JS to avoid populating the global scope

**Example of usage in non CommonJS modules:**

```javascript
(function($) {
    console.log($);
    // Defined as long as global jQuery object is available
})(jQuery);

console.log($);
// Undefined
```

## Python

1. Python code SHOULD conform to the PEP8 and PEP257 guides
2. Exceptions:
    1. 160 column limit


## SQL

### Query Writing
1. Keywords and functions MUST be uppercase (SELECT, WHERE, MAX, AND)
2. Column aliases MUST be lower snake_case
3. When the SELECT, WHERE, GROUP BY or ORDER clauses contain more than one element, they MUST be on a new line after the keyword, indented once:

    ```sql
    SELECT
        first_name,
        last_name
    FROM users
    WHERE
        username = 'sxybill9'
        AND email <> 'bill@microsoft.com'
    ```
4. When a SELECT, WHERE, GROUP BY or ORDER clause only contains one element, it MAY all be written on the same line for brevity:

    ```sql
    SELECT
        first_name,
        last_name
    FROM users
    WHERE id = 321142
    ```
5. When a statement is written within a string in PHP:
    1. The query MUST start on a new line, indented once
    2. A semicolon MUST NOT be added at the end of the statement
6. All joins MUST be written like:

    ```sql
    INNER JOIN table_name
        ON condition1
        AND condition2
    ```
    Joins MUST NOT use the unqualified JOIN keyword.

7. Functions MAY be split across multiple lines, where each subsequent line is indented once. When doing so, the first item in the list MUST be on the next line, and there MUST be only one argument per line.

    ```sql
    SELECT
        CONCAT(
            first_name,
            ' ',
            last_name
        ) full_name
    FROM users
    ```

8. CASE statements MAY either be written using the previous rule or on a single line:
    * split lines
        ```sql
        SELECT
            CASE
                WHEN gender = 'M' THEN 'male'
                WHEN gender = 'F' THEN 'female'
                ELSE 'not provided'
            END
       ```

    * concisely
    ```sql
        SELECT
            CASE WHEN gender = 'M' THEN 'male' ELSE 'female' END
        FROM users
        ```

9. Subqueries MUST be started on the next line and indented once; the opening brace MUST be on the same line as the FROM clause, and the closing brace MUST be on its own line along with the subquery alias:

    ```sql
    SELECT
        my_subquery.*
    FROM (
        SELECT
            prenom first_name,
            COUNT(*) count_names
        FROM users
        GROUP BY prenom
    ) my_subquery
    ```
