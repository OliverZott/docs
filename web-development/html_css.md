# HTML / CSS Basics

## CSS

```css
selector {
    property: value;
    property: value;
}
```

### Selectors

- **Element Selector**: Targets all instances of a specific HTML element.

    ```css
    p {
        color: red;
    }
    ```

- **Class Selector**: Targets elements with a specific class. Classes are denoted with a . (dot).

    ```css
    .classname {
    color: blue;
    }
    ```

- **ID Selector**: Targets an element with a specific ID. IDs are denoted with a # (hash).

    ```css
    #idname {
    color: green;
    }
    ```

- **Attribute Selector**: Targets elements with a specific attribute.

    ```css
    input[type="text"] {
        border: 1px solid black;
    }
    ```

### Combinators

- **Descendant Selector (space)**: Targets elements that are descendants of a specified element.

    ```css
    div p {
    color: orange;
    }
    ```

- **Child Selector (>)**: Targets elements that are direct children of a specified element.
- **Adjacent Sibling Selector (+)**: Targets an element that is immediately preceded by a specified element.
- **General Sibling Selector (~)**: Targets all elements that are siblings of a specified element.

    ```css
    div > p {
    color: purple;
    }
    ```

### Pseudo-classes and Pseudo-elements

- **Pseudo-classes**: Apply styles to elements in a specific state.

    ```css
    a:hover {
    color: red;
    }
    ```

- **Pseudo-elements**: Style specific parts of an element.

    ```css
    p::first-line { 
        font-weight: bold; 
    }
    ```

### Specificity and Inheritance

- **Inheritance**: Some CSS properties are inherited from parent elements to child elements. For example, color is an inherited property, while margin is not.
- **Specificity**: Determines which CSS rule is applied by the browser when multiple rules could apply to the same element. Specificity is calculated based on the types of selectors used.

    ```css
    /* Specificity levels */
    p { color: black; }         /* Low specificity */
    .classname { color: blue; } /* Medium specificity */
    #idname { color: green; }   /* High specificity */
    ```

### Example

```css
/* Select and style all <p> elements */
p {
    color: navy;
}

/* Select and style elements with class "intro" */
.intro {
    font-size: 20px;
    line-height: 1.5;
}

/* Select and style the element with ID "main-title" */
#main-title {
    font-weight: bold;
    text-align: center;
}

/* Select and style all <a> elements inside <div> elements */
div a {
    text-decoration: none;
    color: teal;
}

/* Select and style the first <li> element of each <ul> */
ul li:first-child {
    font-style: italic;
}
```
