# JavaScript remarks

## conventions

- Functions: camelCase
- Variables: camelCase
- Constants: UPPER_SNAKE_CASE
- Files: kebab-case

## async / await

- `Single-Threaded` Nature: JavaScript runs on a single thread, meaning it executes one piece of code at a time. However, it can handle asynchronous operations without blocking the main thread.
- `Event Loop`: The event loop is a mechanism that allows JavaScript to perform non-blocking operations by offloading tasks (like network requests) to the browser's or Node.js's APIs.
- `Promises and Callbacks`: Asynchronous tasks often return promises. The event loop monitors these promises and places their callbacks in the task queue once they are resolved.
- `Async/Await`: async/await provides a more synchronous syntax for handling promises, making code easier to read and write, but they still rely on promises under the hood.

### Event loop workflow

- `Call Stack`: JavaScript executes code on a stack, where each function call is added to the stack and executed in order.
- `Web APIs`: Asynchronous tasks (e.g., setTimeout, fetch) are offloaded to Web APIs provided by the browser (or Node.jsin server-side JavaScript), allowing them to run independently.
- `Task Queue`: When an asynchronous operation completes, its callback is placed in the task queue.
- `Event Loop`: The event loop continuously monitors the call stack and the task queue. If the call stack is empty, it takes the first task from the queue and pushes it to the call stack for execution.

### Example 1

```js
await fetch(streetsApiUrl)
    .then(response => response.json())
    .then(data => {
        if (data.data.length > 0) {
            streetName = data.data[0].street;
        } else {
            console.log('No streets found');
        }
    })
    .catch(error => console.error('Error fetching streets', error));
```

- Adding `await` before fetch ensures that the asynchronous operation completes before moving to the next line of code in the enclosing async function.
- `await`
  - Pauses the async function until the promise resolves.
- `.then()` 
  - Handles promises resolution, doesn’t await. Returns a new promise.
  - `return` inside a then statement only returns to the former then statement, not the async fucntion around it.

### Example 2

```js
  async function fetchData() {
    const response = await fetch('https://api.example.com/data');
    const data = await response.json();
    console.log(data);
    }
fetchData();
console.log('This runs while fetch is pending');
```

- Fetch Request: fetchData() is called. await fetch(...) initiates a network request.
- Event Loop: The event loop processes other code (e.g., console.log('This runs while fetch is pending')) while the network request is handled asynchronously.
- Promise Resolution: Once the network request completes, the promise is resolved, and the event loop resumes fetchData().